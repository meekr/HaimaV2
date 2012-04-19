//
//  TimelineView.m
//  Haima
//
//  Created by Lei Perry on 4/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TimelineView.h"
#import "TimelineEntry.h"
#import "Constants.h"


@implementation TimelineView

@synthesize timelineEntries = _timelineEntries;

- (id)initWithFrame:(CGRect)frame andEntries:(NSArray *)entries
{
    self = [super initWithFrame:frame];
    if (self) {
        self.timelineEntries = entries;
        
        int factor = -1;
        int lastTimeOffset = 0;
        for (int i=0; i<_timelineEntries.count; i++) {
            TimelineEntry *entry = [_timelineEntries objectAtIndex:i];
            int centerX = (entry.timeOffset + TIME_ENTRY_TIME_OFFSET_PREFIX) * TIME_ENTRY_PIXELS_PER_TIME_OFFSET;
            if (entry.timeOffset - lastTimeOffset < 13)
                factor = -1 * factor;
            lastTimeOffset = entry.timeOffset;
            UIImage *timeLabelBg = [UIImage imageNamed:(factor > 0 ? @"time-label-bg-1" : @"time-label-bg")];
            
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.frame = CGRectMake(0, 0, timeLabelBg.size.width, timeLabelBg.size.height);
            button.center = CGPointMake(centerX, TIME_ENTRY_VERTICAL_MIDDLE_Y-factor*14);
            button.userInteractionEnabled = NO;
            [button setBackgroundImage:timeLabelBg forState:UIControlStateNormal];
            [self addSubview:button];
            
            float targetY = factor > 0 ? 0 : 4;
            UILabel *buttonText = [[[UILabel alloc] initWithFrame:CGRectMake(0, targetY, button.frame.size.width, 20)] autorelease];
            buttonText.backgroundColor = [UIColor clearColor];
            buttonText.font = [UIFont systemFontOfSize:13];
            buttonText.textAlignment = UITextAlignmentCenter;
            buttonText.textColor = [UIColor colorWithRed:31.0/255 green:85.0/255 blue:110.0/255 alpha:1];
            buttonText.text = entry.timeLabel;
            [button addSubview:buttonText];
        }
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
    
    for (int i=1; i<rect.size.width/TIME_ENTRY_PIXELS_PER_TIME_OFFSET; i++) {
        CGContextMoveToPoint(c, i*TIME_ENTRY_PIXELS_PER_TIME_OFFSET, rect.size.height/2-0.5);
        CGContextAddLineToPoint(c, i*TIME_ENTRY_PIXELS_PER_TIME_OFFSET, rect.size.height/2+10.5);
        CGContextStrokePath(c);
    }
    
    int factor = -1;
    int lastTimeOffset = 0;
    for (int i=0; i<_timelineEntries.count; i++) {
        TimelineEntry *entry = [_timelineEntries objectAtIndex:i];
        int centerX = (entry.timeOffset + TIME_ENTRY_TIME_OFFSET_PREFIX) * TIME_ENTRY_PIXELS_PER_TIME_OFFSET;
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
