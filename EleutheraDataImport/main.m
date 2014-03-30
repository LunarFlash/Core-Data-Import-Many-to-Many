//
//  main.m
//  EleutheraDataImport
//
//  Created by Yi Wang on 7/20/13.
//  Copyright (c) 2013 Yi. All rights reserved.
//

//http://stackoverflow.com/questions/3949368/nsbundle-pathforresource-is-null
/*
 Command-line Tool targets can still link files using NSBundle pathForResource. You need tell the application to copy the file(s) into the products directory when it builds. Go into “Build Phases” tab, click “Add Build Phase”, and select “Add Copy Files”. Then simply drag the file(s) you need.
 */


#import "Tag.h"
#import "Place.h"
#import "PlaceMgr.h"
#import "TagMgr.h"




static NSManagedObjectModel *managedObjectModel()
{
    
    static NSManagedObjectModel *model = nil;
    if (model != nil) {
        return model;
    }
    
    NSString *path = @"Places";
    
    NSURL *modelURL = [NSURL fileURLWithPath:[path stringByAppendingPathExtension:@"mom"]];
    model = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    
    return model;
}

static NSManagedObjectContext *managedObjectContext()
{
    static NSManagedObjectContext *context = nil;
    if (context != nil) {
        return context;
    }
    
    @autoreleasepool {
        context = [[NSManagedObjectContext alloc] init];
        
        NSPersistentStoreCoordinator *coordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:managedObjectModel()];
        [context setPersistentStoreCoordinator:coordinator];
        
        NSString *STORE_TYPE = NSSQLiteStoreType;
        
        //NSString *path = [[NSProcessInfo processInfo] arguments][0];
        NSString *path = @"Places";
        path = [path stringByDeletingPathExtension];
        NSURL *url = [NSURL fileURLWithPath:[path stringByAppendingPathExtension:@"sqlite"]];
        
        
        
        
        NSError *error;
        NSPersistentStore *newStore = [coordinator addPersistentStoreWithType:STORE_TYPE configuration:nil URL:url options:nil error:&error];
        
        if (newStore == nil) {
            NSLog(@"Store Configuration Failure %@", ([error localizedDescription] != nil) ? [error localizedDescription] : @"Unknown Error");
        }
    }
    return context;
}

int main(int argc, const char * argv[])
{
        
    
    @autoreleasepool {
        
        

        
        // Create the managed object context
        NSManagedObjectContext *context = managedObjectContext();
        
        // Custom code here...
        // Save the managed object context
        NSError *error = nil;
        if (![context save:&error]) {
            NSLog(@"Error while saving %@", ([error localizedDescription] != nil) ? [error localizedDescription] : @"Unknown Error");
            exit(1);
        }
        
        
        
        
        
        
        NSError* err = nil;
        NSString* dataPath = [[NSBundle mainBundle] pathForResource:@"Places" ofType:@"json"];
        
        if ([[NSFileManager defaultManager] fileExistsAtPath:dataPath]){
            NSLog(@"file exists......");
        }
        
        
        NSArray* places = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfFile:dataPath]
                                                          options:kNilOptions
                                                            error:&err];
        
        
        
        //NSLog(@"Read in Places: %@", places);
        
        /********** --  Done reading in data from json ***********/
        

#pragma mark save data
        [places enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            
            
            //--first see if this place is a duplicate
            NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
            NSEntityDescription *entity = [NSEntityDescription entityForName:@"Place"
                                                      inManagedObjectContext:context];
            NSPredicate *pred = [NSPredicate predicateWithFormat:@"name == %@", [obj objectForKey:@"name" ]];
            [fetchRequest setEntity:entity];
            [fetchRequest setPredicate:pred];
            NSError *error = nil;
            NSArray *fetchedPlaces = [context executeFetchRequest:fetchRequest error:&error];
            
            if (![fetchedPlaces count]){ //only insert this place into data store if it does not already exist
                
                Place *place = [NSEntityDescription insertNewObjectForEntityForName:@"Place" inManagedObjectContext:context];
                place.address = [obj objectForKey:@"address"];
                place.city = [obj objectForKey:@"city"];
                place.country = [obj objectForKey:@"country"];
                place.details = [obj objectForKey:@"details"];
                //place.image = [obj objectForKey:@"image"];  //This is binary, will get from Parse
                //place.mapImage = [obj objectForKey:@"mapImage"];  // Will just use name to get the file
                place.name = [obj objectForKey:@"name"];
                place.phone = [obj objectForKey:@"phone"];
                place.state = [obj objectForKey:@"state"];
                place.website = [obj objectForKey:@"website"];
                //place.tags =  [NSSet setWithArray:[obj objectForKey:@"tags"]];
                place.zip = [obj objectForKey:@"zip"];
                NSArray *coordinates = [obj objectForKey:@"coordinates"];
                place.latitude = coordinates[0];
                place.longitude = coordinates[1];
                
                NSSet *tagsStringSet = [NSSet setWithArray:[obj objectForKey:@"tags"]]; //eliminates duplicates from array
                //NSLog(@"tagsStringSet:%@", tagsStringSet);
                
                for (NSString *tagString in tagsStringSet){
                    NSString *lowerCaseTagString = [tagString lowercaseString];
                    
                    // First see if this tag already exists
                    //sfetchRequest = [[NSFetchRequest alloc] init];
                    entity = [NSEntityDescription entityForName:@"Tag"
                                                              inManagedObjectContext:context];
                    pred = [NSPredicate predicateWithFormat:@"name == %@", lowerCaseTagString];
                    [fetchRequest setEntity:entity];
                    [fetchRequest setPredicate:pred];
                    NSError *error = nil;
                    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
                    
                    if (fetchedObjects.count > 0)
                    {   //we found a match, this tag we are trying to import alraedy exists
                        // there should be at most 1 item since we essentially use this logic to eliminate duplicate tags
                        for (Tag *tag in fetchedObjects)
                        {
                            [place addTagsObject:tag];
                            [tag addPlacesObject:place];
                            NSLog(@"\n\nAdded duplicate tag:%@, to %@", tag.name, place.name);
                            //[place NSLogMe];
                        }
                        
                    }  //end of if this is a duplicate tag
                    else {
                        
                        NSLog(@"\nAdding new tag:%@ while importing place:%@", tagString, place.name);
                        // this tag does not exist yet, so we should insert it.
                        Tag *tag = [NSEntityDescription insertNewObjectForEntityForName:@"Tag" inManagedObjectContext:context];
                        
                        tag.name = lowerCaseTagString; //tagString;
                        [tag addPlacesObject:place];
                        [place addTagsObject:tag];
                        //NSLog(@"\ntag:%@", tag.name);
                    }
                    
                    
                    
                }
                
                
                // save the context
                NSError *error;
                if (![context save:&error]) {
                    NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
                }
                
                
                
                
                
            } // if place does not exist
            else {
                NSLog(@"**********************This place already exists*********************");
            }
            
        }];
        
 
        
        // Test listing all Places from the store
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
        NSEntityDescription *entity = [NSEntityDescription entityForName:@"Place"
                                                  inManagedObjectContext:context];
        
        [fetchRequest setEntity:entity];
        NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
        for (Place *place in fetchedObjects) {
            [PlaceMgr NSLogMe:place];
            
        }
        
        // List all Tags from the store
        entity = [NSEntityDescription entityForName:@"Tag" inManagedObjectContext:context];
        [fetchRequest setEntity:entity];
        fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
        for (Tag *tag in fetchedObjects) {
            [TagMgr NSLogMe:tag];
        }
        
        
        
        
        
    }
    
    
    return 0;
}

