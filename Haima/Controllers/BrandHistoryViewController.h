//
//  BrandHistoryViewController.h
//  Haima
//
//  Created by Lei Perry on 4/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "TimelineScrollView.h"
#import "TimeEntryView.h"


@interface BrandHistoryViewController : UIViewController<TimelineScrollViewDelegate>
{
    TimelineScrollView *_scrollView;
    NSArray *_timelineEntries;
    
    TimeEntryView *_timeEntryView;
    UITapGestureRecognizer *_tapGesture;
    UIImageView *_lastTapOnImageView;
}
@end
