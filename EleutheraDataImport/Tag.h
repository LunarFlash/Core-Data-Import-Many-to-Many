//
//  Tag.h
//  Eleuthera
//
//  Created by Yi Wang on 6/2/13.
//  Copyright (c) 2013 Yi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Place;

@interface Tag : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSSet *places;
@end

@interface Tag (CoreDataGeneratedAccessors)

- (void)addPlacesObject:(Place *)value;
- (void)removePlacesObject:(Place *)value;
- (void)addPlaces:(NSSet *)values;
- (void)removePlaces:(NSSet *)values;

- (void) NSLogMe;

@end
