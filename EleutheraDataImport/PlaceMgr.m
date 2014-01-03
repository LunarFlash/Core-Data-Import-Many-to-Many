//
//  PlaceMgr.m
//  Eleuthera
//
//  Created by Yi Wang on 1/2/14.
//  Copyright (c) 2014 Yi. All rights reserved.
//

#import "PlaceMgr.h"
#import "Tag.h"

@implementation PlaceMgr

+ (void) NSLogMe:(Place *)place
{
    NSString *placeString = [NSString stringWithFormat:@"\n\nname:%@\naddress:%@\ncity:%@\ncountry:%@\ndetails:%@\b\nphone:%@\nstate:%@\nzip:%@\nlat:%@\nlong:%@\n",  place.name, place.address, place.city, place.country,place.details, place.phone, place.state, place.zip, place.latitude, place.longitude];
    
    NSString *tagsString = @"Tags:";
    for (Tag *t in place.tags){
        tagsString = [tagsString stringByAppendingString:t.name];
        tagsString = [tagsString stringByAppendingString:@", "];
    }
    tagsString = [tagsString substringToIndex:[tagsString length] - 2];
    placeString = [placeString stringByAppendingString:tagsString];
    
    NSLog(@"%@", placeString);
    
}

@end
