//
//  Place.h
//  Eleuthera
//
//  Created by Yi Wang on 6/2/13.
//  Copyright (c) 2013 Yi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Place : NSManagedObject

@property (nonatomic, retain) NSString * address;
@property (nonatomic, retain) NSString * city;
@property (nonatomic, retain) NSString * country;
@property (nonatomic, retain) NSString * details;
@property (nonatomic, retain) NSString * image;
@property (nonatomic, retain) NSString * mapImage;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * phone;
@property (nonatomic, retain) NSString * state;
@property (nonatomic, retain) NSString * zip;
@property (nonatomic, retain) NSString * mapURL;
@property (nonatomic, retain) NSSet *tags;
@end

@interface Place (CoreDataGeneratedAccessors)

- (void)addTagsObject:(NSManagedObject *)value;
- (void)removeTagsObject:(NSManagedObject *)value;
- (void)addTags:(NSSet *)values;
- (void)removeTags:(NSSet *)values;
- (void)updateAttributes:(NSDictionary *)attributes;


- (void) NSLogMe;

@end
