//
//  BrandHistoryViewController.m
//  Haima
//
//  Created by Lei Perry on 4/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "BrandHistoryViewController.h"
#import "DataController.h"
#import "TimelineEntry.h"
#import "UIImage+bitrice.h"
#import "TimelineView.h"
#import "Constants.h"

@implementation BrandHistoryViewController


- (void)setupTimeline {
    _timelineEntries = [[[DataController sharedDataController] getTimelineEntries] retain];
    _scrollView.timelineEntries = _timelineEntries;
    
    // calculate total width
    TimelineEntry *lastEntry = [_timelineEntries lastObject];
    int width = (TIME_ENTRY_TIME_OFFSET_PREFIX+lastEntry.timeOffset+TIME_ENTRY_TIME_OFFSET_SUFFIX) * TIME_ENTRY_PIXELS_PER_TIME_OFFSET;
    _scrollView.contentSize = CGSizeMake(width, _scrollView.frame.size.height);
    
    TimelineView *timeline = [[[TimelineView alloc] initWithFrame:CGRectMake(0, 0, width, _scrollView.frame.size.height) andEntries:_timelineEntries] autorelease];
    timeline.backgroundColor = [UIColor clearColor];
    timeline.timelineEntries = _timelineEntries;
    [_scrollView addSubview:timeline];
    
    UIView *container = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, _scrollView.frame.size.height)];

    int factor = -1;
    int lastTimeOffset = 0;
    for (int i=0; i<_timelineEntries.count; i++) {
        TimelineEntry *entry = [_timelineEntries objectAtIndex:i];
        int centerX = (entry.timeOffset + TIME_ENTRY_TIME_OFFSET_PREFIX) * TIME_ENTRY_PIXELS_PER_TIME_OFFSET;
        if (entry.timeOffset - lastTimeOffset < 12)
            factor = -1 * factor;
        lastTimeOffset = entry.timeOffset;
    
        UIImage *pictureImage = [UIImage imageNamed:entry.pictureUrl];
        float ratioD = TIME_ENTRY_PICTURE_WIDTH / TIME_ENTRY_PICTURE_HEIGHT;
        float ratioA = pictureImage.size.width / pictureImage.size.height;
        CGRect rect;
        if (ratioA > ratioD) {
            float widthD = TIME_ENTRY_PICTURE_WIDTH * pictureImage.size.height / TIME_ENTRY_PICTURE_HEIGHT;
            rect = CGRectMake((pictureImage.size.width-widthD)/2, 0, widthD, pictureImage.size.height);
        }
        else {
            float heightD = pictureImage.size.width * TIME_ENTRY_PICTURE_HEIGHT / TIME_ENTRY_PICTURE_WIDTH;
            rect = CGRectMake(0, (pictureImage.size.height-heightD)/2, pictureImage.size.width, heightD);
        }
        pictureImage = [pictureImage imageAtRect:rect];
        pictureImage = [pictureImage imageByScalingProportionallyToSize:CGSizeMake(TIME_ENTRY_PICTURE_WIDTH*1.9f, TIME_ENTRY_PICTURE_HEIGHT*1.9f)];
                            
        UIImageView *picture = [[[UIImageView alloc] initWithImage:pictureImage] autorelease];
        picture.tag = (i+1)*10;
        picture.userInteractionEnabled = YES;
        picture.frame = CGRectMake(0, 0, TIME_ENTRY_PICTURE_WIDTH, TIME_ENTRY_PICTURE_HEIGHT);
        picture.center = CGPointMake(centerX, TIME_ENTRY_VERTICAL_MIDDLE_Y + factor * 120);
        picture.layer.borderColor = [UIColor whiteColor].CGColor;
        picture.layer.borderWidth = 5;
        picture.layer.shadowColor = [UIColor blackColor].CGColor;
        picture.layer.shadowOpacity = 0.3f;
        picture.layer.shadowOffset = CGSizeMake(4.0f, 4.0f);
        picture.layer.shadowRadius = 2.0f;
        picture.layer.masksToBounds = NO;
        [container addSubview:picture];
        
        CGSize size = [entry.description sizeWithFont:[UIFont systemFontOfSize:14]
                                    constrainedToSize:CGSizeMake(TIME_ENTRY_PICTURE_WIDTH, 999)
                                        lineBreakMode:UILineBreakModeWordWrap];
        UILabel *description = [[[UILabel alloc] initWithFrame:CGRectMake(0, 0, TIME_ENTRY_PICTURE_WIDTH, size.height)] autorelease];
        description.tag = (i+1)*10+1;
        description.backgroundColor = [UIColor clearColor];
        description.center = CGPointMake(centerX, TIME_ENTRY_VERTICAL_MIDDLE_Y + factor*(180+size.height/2));
        description.font = [UIFont systemFontOfSize:14];
        description.lineBreakMode = UILineBreakModeWordWrap;
        description.numberOfLines = 0;
        description.text = entry.description;
        description.textAlignment = UITextAlignmentLeft;
        description.textColor = [UIColor darkGrayColor];
        [container addSubview:description];
    }
    
    [_scrollView addSubview:container];
    [container release];
}

- (void)loadView
{
    UIView *view = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.view = view;
    [view release];
    
    UIImage *bgImage = [UIImage imageNamed:@"bg-brand-history"];
    UIImageView *bg = [[UIImageView alloc] initWithImage:bgImage];
    bg.frame = CGRectMake(0, 40, bgImage.size.width, bgImage.size.height);
    bg.alpha = 0.08;
    [self.view addSubview:bg];
    [bg release];
    
    _scrollView = [[TimelineScrollView alloc] initWithFrame:CGRectMake(0, 0, 1024, 690)];
    _scrollView.backgroundColor = [UIColor clearColor];
    _scrollView.timelineDelegate = self;
    [self.view addSubview:_scrollView];
    [self setupTimeline];
    
//    UIImage *mask = [UIImage imageNamed:@"timeline-mask"];
//    CALayer *maskLayer = [CALayer layer];
//    maskLayer.frame = CGRectMake(0, 0, 1024, 690);
//    maskLayer.contents = (id)mask.CGImage;
//    self.view.layer.mask = maskLayer;
}

- (void)dealloc
{
    [_scrollView release];
    [_timelineEntries release];
    [super dealloc];
}

#pragma mark - TimelineScrollViewDelegate
- (void)timelineScrollView:(TimelineScrollView *)scrollView tapOnIndex:(NSUInteger)index {
    NSLog(@"tap on %d", index);
}


@end