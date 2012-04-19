//
//  TimelineScrollView.h
//  Haima
//
//  Created by Lei Perry on 4/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

@protocol TimelineScrollViewDelegate;

@interface TimelineScrollView : UIScrollView<UIScrollViewDelegate>
{
    float origin;
    BOOL movingRight;
    
    BOOL touchFlag;
    CGPoint startTouch;
}

@property (nonatomic, retain) NSArray *timelineEntries;

@property (nonatomic, assign) id<TimelineScrollViewDelegate> timelineDelegate;

@end


@protocol TimelineScrollViewDelegate <NSObject>

- (void)timelineScrollView:(TimelineScrollView *)scrollView tapOnIndex:(NSUInteger)index;

@end