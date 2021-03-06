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
#import "ImageBrowserItemView.h"

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
        if (entry.timeOffset - lastTimeOffset < TIME_OFFSET_THRESHOLD)
            factor = -1 * factor;
        lastTimeOffset = entry.timeOffset;
    
        CGRect rect = CGRectMake(0, 0, TIME_ENTRY_PICTURE_WIDTH, TIME_ENTRY_PICTURE_HEIGHT);
        ImageBrowserItemView *picture = [ImageBrowserItemView itemViewWithFrame:rect
                                                                       imageURL:[NSURL fileURLWithPath:entry.pictureUrl]];
        picture.imageDelegate = self;
        picture.backgroundColor = [UIColor clearColor];
        picture.tag = (i+1)*10;
        picture.center = CGPointMake(centerX, TIME_ENTRY_VERTICAL_MIDDLE_Y+factor*(TIME_ENTRY_VERTICAL_OFFSET_FROM_MIDDLE+TIME_ENTRY_PICTURE_HEIGHT/2));
        [container addSubview:picture];
                
        UILabel *description = [[[UILabel alloc] init] autorelease];
        description.tag = (i+1)*10+1;
        description.backgroundColor = [UIColor clearColor];
        description.font = [UIFont systemFontOfSize:14];
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
    
    _timeEntryView = [[TimeEntryView alloc] init];
    _timeEntryView.backgroundColor = [UIColor darkGrayColor];
    _timeEntryView.frame = CGRectMake(0, 0, 1024, 690);
    _timeEntryView.alpha = 0;
    [self.view addSubview:_timeEntryView];
    
    _tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapOnTimeEntryView:)];
}

- (void)tapOnTimeEntryView:(UITapGestureRecognizer *)gesture {
    [_timeEntryView removeGestureRecognizer:_tapGesture];
    [UIView animateWithDuration:.2
                          delay:0
                        options:UIViewAnimationCurveEaseInOut
                     animations:^{
                         _timeEntryView.center = CGPointMake(_lastTapOnImageView.center.x-_scrollView.contentOffset.x, _lastTapOnImageView.center.y);
                         _timeEntryView.transform = CGAffineTransformMakeScale(_lastTapOnImageView.frame.size.width/1024, _lastTapOnImageView.frame.size.height/690);
                         _timeEntryView.alpha = 0;
                     }
                     completion:^(BOOL finished){
                     }];
}

- (void)dealloc
{
    [_scrollView release];
    [_timelineEntries release];
    [_timeEntryView release];
    [_tapGesture release];
    [super dealloc];
}

#pragma mark - TimelineScrollViewDelegate
- (void)timelineScrollView:(TimelineScrollView *)scrollView tapOnView:(UIImageView *)imageView atIndex:(NSUInteger)index {
    _lastTapOnImageView = imageView;
    
    TimelineEntry *entry = [_timelineEntries objectAtIndex:index];
    _timeEntryView.image = [UIImage imageNamed:entry.pictureUrl];
    _timeEntryView.text = entry.description;
    _timeEntryView.center = CGPointMake(imageView.center.x-scrollView.contentOffset.x, imageView.center.y);
    _timeEntryView.transform = CGAffineTransformMakeScale(imageView.frame.size.width/1024, imageView.frame.size.height/690);   
    [UIView animateWithDuration:.2
                          delay:0
                        options:UIViewAnimationCurveEaseInOut
                     animations:^{
                         _timeEntryView.center = CGPointMake(512, 345);
                         _timeEntryView.transform = CGAffineTransformIdentity;
                         _timeEntryView.alpha = 1;
                     }
                     completion:^(BOOL finished){
                         [_timeEntryView addGestureRecognizer:_tapGesture];
                     }];
}


#pragma mark - ImageBrowserItemLayerDelegate
- (CGRect)getImageLayerFrameByImageSize:(CGSize)imageSize andBoundsSize:(CGSize)boundsSize {
    CGRect r = CGRectInset(CGRectMake(0, 0, boundsSize.width, boundsSize.height), 8, 8);
    return r;
}

- (UIImage *)getDownsampledImageByBoundsSize:(CGSize)boundsSize originalImage:(UIImage *)image {
    float ratioD = boundsSize.width/boundsSize.height;
    float ratioA = image.size.width / image.size.height;
    CGRect rect;
    if (ratioA > ratioD) {
        float widthD = boundsSize.width * image.size.height / boundsSize.height;
        rect = CGRectMake((image.size.width-widthD)/2, 0, widthD, image.size.height);
    }
    else {
        float heightD = image.size.width * boundsSize.height / boundsSize.width;
        rect = CGRectMake(0, (image.size.height-heightD)/2, image.size.width, heightD);
    }
    image = [image imageAtRect:rect];
    image = [image imageByScalingProportionallyToSize:CGSizeMake(boundsSize.width*1.9f, boundsSize.height*1.9f)];
    return image;
}

@end