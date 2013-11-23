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
    NSString *placeString = [NSString stringWithFormat:@"\n\nname:%@\naddress:%@\ncity:%@\ncountry:%@\ndetails:%@\nimage:%@\nmapImage:%@\nmapURL:%@\nphone:%@\nstate:%@\nzip:%@\n",  self.name, self.address, self.city, self.country,self.details, self.image, self.mapImage, self.mapURL,
                            self.phone, self.state, self.zip];
    
    NSString *tagsString = @"Tags:";
    for (Tag *t in self.tags){
        tagsString = [tagsString stringByAppendingString:t.name];
        tagsString = [tagsString stringByAppendingString:@", "];
    }
    tagsString = [tagsString substringToIndex:[tagsString length] - 2];
    placeString = [placeString stringByAppendingString:tagsString];
    
    NSLog(@"%@", placeString);
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
