//
//  TimelineView.m
//  Haima
//
//  Created by Lei Perry on 4/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TimelineView.h"
#import "TimelineEntry.h"

#define TIME_OFFSET_PREFIX 1
#define TIME_OFFSET_SUFFIX 9
#define PIXELS_PER_TIME_OFFSET 15

@implementation TimelineView

@synthesize timelineEntries = _timelineEntries;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef c = UIGraphicsGetCurrentContext();
    
    CGFloat color[4] = {175.0/255, 177.0/255, 182.0/255, 1.0f};
    CGContextSetStrokeColor(c, color);
    
    CGContextMoveToPoint(c, 0.0, rect.size.height/2-0.5);
    CGContextAddLineToPoint(c, rect.size.width, rect.size.height/2-0.5);
    CGContextStrokePath(c);
    
    for (int i=1; i<rect.size.width/PIXELS_PER_TIME_OFFSET; i++) {
        CGContextMoveToPoint(c, i*PIXELS_PER_TIME_OFFSET, rect.size.height/2-0.5);
        CGContextAddLineToPoint(c, i*PIXELS_PER_TIME_OFFSET, rect.size.height/2+10.5);
        CGContextStrokePath(c);
    }
    
    int factor = -1;
    int lastTimeOffset = 0;
    for (int i=0; i<_timelineEntries.count; i++) {
        TimelineEntry *entry = [_timelineEntries objectAtIndex:i];
        int centerX = (entry.timeOffset + TIME_OFFSET_PREFIX) * PIXELS_PER_TIME_OFFSET;
        if (entry.timeOffset - lastTimeOffset < 12)
            factor = -1 * factor;
        lastTimeOffset = entry.timeOffset;
        
        CGContextMoveToPoint(c, centerX, rect.size.height/2-0.5);
        CGContextAddLineToPoint(c, centerX, rect.size.height/2+factor*120);
        CGContextStrokePath(c);
    }
}

- (void)dealloc
{
    [_timelineEntries release];
    [super dealloc];
}

@end
