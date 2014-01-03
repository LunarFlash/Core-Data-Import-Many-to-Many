//
//  TagMgr.m
//  Eleuthera
//
//  Created by Yi Wang on 1/2/14.
//  Copyright (c) 2014 Yi. All rights reserved.
//

#import "TagMgr.h"


@implementation TagMgr

+ (void)NSLogMe:(Tag *)tag
{
    NSString *tagString = [NSString stringWithFormat:@"\n\nTag:%@\n",tag.name];
    NSString *placesString = @"Places:";
    for (Place *p in tag.places){
        placesString = [placesString stringByAppendingString:p.name];
        placesString = [placesString stringByAppendingString:@", "];
    }
    placesString = [placesString substringToIndex:[placesString length] - 2];
    tagString = [tagString stringByAppendingString:placesString];
    NSLog(@"%@",tagString);
}

@end
