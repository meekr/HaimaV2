//
//  TimelineEntry.h
//  Haima
//
//  Created by Lei Perry on 4/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

@interface TimelineEntry : NSObject

@property (nonatomic) NSUInteger timeOffset;
@property (nonatomic, retain) NSString *timeLabel;
@property (nonatomic, retain) NSString *description;
@property (nonatomic, retain) NSString *pictureUrl;

@end