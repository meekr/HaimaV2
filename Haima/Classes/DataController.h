//
//  DataController.h
//  Haima
//
//  Created by Lei Perry on 4/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ProductFeature.h"
#import "ProductFeatureCategory.h"
#import "ProductFeatureItem.h"
#import "TimelineEntry.h"

@interface DataController : NSObject

+ (DataController *)sharedDataController;

@property (nonatomic, readonly) NSDictionary *allFeatures;

- (ProductFeature *)getFeatureByIndex:(NSUInteger)index;

- (NSArray *)getTimelineEntries;

@end