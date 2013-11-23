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
    NSString *tagString = [NSString stringWithFormat:@"\n\nTag:%@\n",self.name];
    NSString *placesString = @"Places:";
    for (Place *p in self.places){
        placesString = [placesString stringByAppendingString:p.name];
        placesString = [placesString stringByAppendingString:@", "];
    }
    placesString = [placesString substringToIndex:[placesString length] - 2];
    tagString = [tagString stringByAppendingString:placesString];
    NSLog(@"%@",tagString);
}

-(NSDictionary*) translateToNSDictionary
{
    NSArray *placesArray = [self.places allObjects];
    NSDictionary *returnVal = [[NSDictionary alloc] initWithObjectsAndKeys:self.name, @"name", placesArray, @"places",  nil];
    return returnVal;
}

@end
