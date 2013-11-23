//
//  Place.m
//  Eleuthera
//
//  Created by Yi Wang on 6/2/13.
//  Copyright (c) 2013 Yi. All rights reserved.
//

#import "Place.h"
#import "Tag.h"

@implementation Place

@dynamic address;
@dynamic city;
@dynamic country;
@dynamic details;
@dynamic image;
@dynamic mapImage;
@dynamic name;
@dynamic phone;
@dynamic state;
@dynamic zip;
@dynamic mapURL;
@dynamic tags;


- (void) NSLogMe
{
    NSLog(@"name=%@", self.name);
    NSLog(@"address=%@", self.address);
    NSLog(@"city=%@", self.city);
    NSLog(@"country=%@", self.country);
    NSLog(@"details=%@", self.details);
    NSLog(@"image=%@", self.image);
    NSLog(@"mapImage=%@", self.mapImage);
    NSLog(@"phone=%@", self.phone);
    NSLog(@"state=%@", self.state);
    NSLog(@"zip=%@", self.zip);
    NSLog(@"mapURL=%@", self.mapURL);
    
    Tag *t = [[Tag alloc] init];
    for (t in self.tags){
        NSLog(@"Tag for %@ =%@", self.name, t);
    }
}

-(NSDictionary*) translateToNSDictionary
{
    NSArray *tagsArray = [self.tags allObjects];
    NSDictionary *returnVal = [[NSDictionary alloc] initWithObjectsAndKeys:self.name, @"name",
                               self.address, @"address",
                               self.city, @"city",
                               self.country, @"country",
                               self.details, @"details",
                               self.image, @"image",
                               self.mapImage, @"mapImage",
                               self.phone, @"phone",
                               self.state, @"state",
                               self.zip, @"zip",
                               self.mapURL, @"mapURL",
                               tagsArray, @"tags",  nil];
    return returnVal;
}


@end
