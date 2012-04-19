//
//  TimelineScrollView.m
//  Haima
//
//  Created by Lei Perry on 4/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TimelineScrollView.h"
#import "TimelineEntry.h"
#import "Constants.h"

@implementation TimelineScrollView

@synthesize timelineEntries = _timelineEntries;
@synthesize timelineDelegate;

- (id)init {
    if (self = [super init]) {
        self.showsHorizontalScrollIndicator = NO;
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.showsHorizontalScrollIndicator = NO;
    }
    return self;
}

- (void)layoutSubviews {
    UIView *container = [self.subviews objectAtIndex:1];
    float centerX = self.contentOffset.x + 512;
    for (int i=0; i<_timelineEntries.count; i++) {
        UIImageView *picture = (UIImageView *)[container viewWithTag:(i+1)*10];
        UILabel *description = (UILabel *)[container viewWithTag:(i+1)*10+1];
        int factor = (picture.frame.origin.y > TIME_ENTRY_VERTICAL_MIDDLE_Y ? 1 : -1);
        
        // exceeds boundary
        if (picture.frame.origin.x < self.contentOffset.x-100 ||
            picture.frame.origin.x > self.bounds.size.width + self.contentOffset.x)
            continue;
        
        float deltaX = fabs(centerX - picture.center.x);
        float scale = 0.9f + (512-deltaX)/512;
        float alpha = 1.0f - deltaX/(512*2.5);

        // picture
        picture.transform = CGAffineTransformMakeScale(scale, scale);
        picture.center = CGPointMake(picture.center.x,
                                     TIME_ENTRY_VERTICAL_MIDDLE_Y+factor*(TIME_ENTRY_VERTICAL_OFFSET_FROM_MIDDLE+picture.frame.size.height/2));
        picture.alpha = alpha;
      
        // label
        CGSize size = [description.text sizeWithFont:[UIFont systemFontOfSize:14*scale]
                                    constrainedToSize:CGSizeMake(picture.frame.size.width+7, 999)
                                        lineBreakMode:UILineBreakModeWordWrap];
        description.frame = CGRectMake(0, 0, picture.frame.size.width+7, size.height);
        description.alpha = alpha;
        description.font = [UIFont systemFontOfSize:14*scale];
        if (picture.frame.origin.y > TIME_ENTRY_VERTICAL_MIDDLE_Y)
            description.center = CGPointMake(picture.center.x, picture.center.y+picture.frame.size.height/2+description.frame.size.height/2+10);
        else
            description.center = CGPointMake(picture.center.x, picture.center.y-picture.frame.size.height/2-description.frame.size.height/2);
    }
}

- (void)dealloc {
    [_timelineEntries release];
    [super dealloc];
}

#pragma mark - UIScrollView Delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    movingRight = self.contentOffset.x - origin > 0 ? YES : NO;
	origin = self.contentOffset.x;
    
    [self setNeedsLayout];
}

#pragma mark - touch events
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	UITouch *t = [touches anyObject];
	CGPoint where = [t locationInView:self];

	touchFlag = YES;
	startTouch = where;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *t = [touches anyObject];
	if (touchFlag == YES) {
        UIView *container = [self.subviews objectAtIndex:1];
        for (int i=0; i<_timelineEntries.count; i++) {
            UIImageView *picture = (UIImageView *)[container viewWithTag:(i+1)*10];
            
            // exceeds boundary
            if (picture.frame.origin.x < self.contentOffset.x-100 ||
                picture.frame.origin.x > self.bounds.size.width + self.contentOffset.x)
                continue;
            
            if (CGRectContainsPoint(picture.bounds, [t locationInView:picture])) {
                if ([self.timelineDelegate respondsToSelector:@selector(timelineScrollView:tapOnView:atIndex:)])
                    [self.timelineDelegate timelineScrollView:self tapOnView:picture atIndex:picture.tag/10 - 1];
                
                break;
            }
        }
	}
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
	UITouch *t = [touches anyObject];
	CGPoint where = [t locationInView:self];
    
	if (touchFlag) {
		// determine if the user is dragging or not
		int dx = fabs(where.x - startTouch.x);
		int dy = fabs(where.y - startTouch.y);
		if ((dx < 3) && (dy < 3)) return;
		touchFlag = NO;
	}
}

@end