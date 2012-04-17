//
//  TimelineEntry.m
//  Haima
//
//  Created by Lei Perry on 4/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TimelineEntry.h"

@implementation TimelineEntry

@synthesize timeOffset;
@synthesize timeLabel = _timeLabel;
@synthesize description = _description;
@synthesize pictureUrl = _pictureUrl;

- (void)dealloc {
    [_timeLabel release];
    [_description release];
    [_pictureUrl release];

    [super dealloc];
}

@end