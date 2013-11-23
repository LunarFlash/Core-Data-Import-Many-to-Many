//
//  Tag.m
//  Eleuthera
//
//  Created by Yi Wang on 6/2/13.
//  Copyright (c) 2013 Yi. All rights reserved.
//

#import "Tag.h"
#import "Place.h"


@implementation Tag

@dynamic name;
@dynamic places;


- (void) NSLogMe
{
    NSLog(@"name=%@", self.name);
    for (Place *p in self.places){
        [p NSLogMe];
    }
}

-(NSDictionary*) translateToNSDictionary
{
    NSArray *placesArray = [self.places allObjects];
    NSDictionary *returnVal = [[NSDictionary alloc] initWithObjectsAndKeys:self.name, @"name", placesArray, @"places",  nil];
    return returnVal;
}

@end
