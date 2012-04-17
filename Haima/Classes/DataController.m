//
//  DataController.m
//  Haima
//
//  Created by Lei Perry on 4/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "DataController.h"
#import "SynthesizeSingleton.h"
#import "DataUtil.h"


@interface DataController()

- (ProductFeatureCategory *)getFeatureCategory:(NSDictionary *)dictionary;
- (ProductFeatureItem *)getFeatureItem:(NSDictionary *)dictionary;

@end


@implementation DataController

@synthesize allFeatures = _allFeatures;

SYNTHESIZE_SINGLETON_FOR_CLASS(DataController);


- (NSDictionary *)allFeatures
{
    if (_allFeatures == nil){
        _allFeatures = [[DataUtil readDictionaryFromFile:@"Features"] retain];
    }
    return _allFeatures;
}

- (ProductFeature *)getFeatureByIndex:(NSUInteger)index
{
    NSArray *array = [self.allFeatures objectForKey:@"Features"];
    NSDictionary *dictionary = [array objectAtIndex:index];
    
    // get product feature
    ProductFeature *pf = [[ProductFeature alloc] init];
    pf.name = [dictionary objectForKey:@"name"];
    pf.description = [dictionary objectForKey:@"description"];
    
    // get feature category
    NSArray *categories = [dictionary objectForKey:@"categories"];
    if (array && [array count] > 0)
    {
        NSMutableArray *cats = [[NSMutableArray alloc] init];
        for (NSDictionary *dict in categories) {
            [cats addObject:[self getFeatureCategory:dict]];
        }
        [pf setCategories:cats];
        [cats release];
    }
    
    // get feature items
    NSArray *features = [dictionary objectForKey:@"features"];
    if (array && [array count] > 0)
    {
        NSMutableArray *fs = [[NSMutableArray alloc] init];
        for (NSDictionary *dict in features) {
            [fs addObject:[self getFeatureItem:dict]];
        }
        [pf setItems:fs];
        [fs release];
    }
    
    return [pf autorelease];
}

- (ProductFeatureCategory *)getFeatureCategory:(NSDictionary *)dictionary
{
    ProductFeatureCategory *cate = [[ProductFeatureCategory alloc] init];
    cate.name = [dictionary objectForKey:@"name"];
    
    // get features
    NSArray *array = [dictionary objectForKey:@"features"];
    if (array && [array count] > 0)
    {
        NSMutableArray *fs = [[NSMutableArray alloc] init];
        for (NSDictionary *dict in array) {
            [fs addObject:[self getFeatureItem:dict]];
        }
        [cate setItems:fs];
        [fs release];
    }
    return [cate autorelease];
}

- (ProductFeatureItem *)getFeatureItem:(NSDictionary *)dictionary
{
    ProductFeatureItem *item = [[ProductFeatureItem alloc] init];
    item.name = [dictionary objectForKey:@"name"];
    item.description = [dictionary objectForKey:@"description"];
    item.spotId = [[dictionary objectForKey:@"spotId"] intValue];
    return [item autorelease];
}

- (NSArray *)getTimelineEntries
{
    NSDictionary *dictionary = [DataUtil readDictionaryFromFile:@"Timeline"];
    NSArray *array = [dictionary objectForKey:@"Entries"];
    NSMutableArray *entries = [NSMutableArray arrayWithCapacity:array.count];
    for (NSDictionary *dict in array) {
        TimelineEntry *entry = [[TimelineEntry alloc] init];
        entry.timeOffset = [[dict objectForKey:@"timeOffset"] intValue];
        entry.timeLabel = [dict objectForKey:@"timeLabel"];
        entry.description = [dict objectForKey:@"description"];
        entry.pictureUrl = [dict objectForKey:@"pictureUrl"];
        [entries addObject:entry];
        [entry release];
    }
    return entries;
}

- (void)dealloc
{
    [_allFeatures release];
    _allFeatures = nil;
    
    [super dealloc];
}

@end