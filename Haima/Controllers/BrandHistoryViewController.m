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
#import <QuartzCore/QuartzCore.h>

#define TIME_OFFSET_PREFIX 1
#define TIME_OFFSET_SUFFIX 9
#define PIXELS_PER_TIME_OFFSET 15

#define VERTICAL_MIDDLE_Y 345

#define PICTURE_WIDTH 170.0f
#define PICTURE_HEIGHT 100.0f


@implementation BrandHistoryViewController


- (void)setupTimeline {
    NSArray *entries = [[DataController sharedDataController] getTimelineEntries];
    
    // calculate total width
    TimelineEntry *lastEntry = [entries lastObject];
    int width = (TIME_OFFSET_PREFIX+lastEntry.timeOffset+TIME_OFFSET_SUFFIX) * PIXELS_PER_TIME_OFFSET;
    _scrollView.contentSize = CGSizeMake(width, _scrollView.frame.size.height);
    
    UIView *container = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, _scrollView.frame.size.height)];

    int factor = -1;
    int lastTimeOffset = 0;
    for (int i=0; i<entries.count; i++) {
        TimelineEntry *entry = [entries objectAtIndex:i];
        int centerX = (entry.timeOffset + TIME_OFFSET_PREFIX) * PIXELS_PER_TIME_OFFSET;
        if (entry.timeOffset - lastTimeOffset < 12)
            factor = -1 * factor;
        lastTimeOffset = entry.timeOffset;
        UIImage *timeLabelBg = [UIImage imageNamed:(factor > 0 ? @"time-label-bg-1" : @"time-label-bg")];
    
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(0, 0, timeLabelBg.size.width, timeLabelBg.size.height);
        button.center = CGPointMake(centerX - timeLabelBg.size.width/2, VERTICAL_MIDDLE_Y-factor*14);
        button.userInteractionEnabled = NO;
        [button setBackgroundImage:timeLabelBg forState:UIControlStateNormal];
        [container addSubview:button];
        
        float targetY = factor > 0 ? 0 : 4;
        UILabel *buttonText = [[[UILabel alloc] initWithFrame:CGRectMake(0, targetY, button.frame.size.width, 20)] autorelease];
        buttonText.backgroundColor = [UIColor clearColor];
        buttonText.font = [UIFont systemFontOfSize:13];
        buttonText.textAlignment = UITextAlignmentCenter;
        buttonText.textColor = [UIColor colorWithRed:31.0/255 green:85.0/255 blue:110.0/255 alpha:1];
        buttonText.text = entry.timeLabel;
        [button addSubview:buttonText];
        
        UIImage *pictureImage = [UIImage imageNamed:entry.pictureUrl];
        float ratioD = PICTURE_WIDTH / PICTURE_HEIGHT;
        float ratioA = pictureImage.size.width / pictureImage.size.height;
        CGRect rect;
        if (ratioA > ratioD) {
            float widthD = PICTURE_WIDTH * pictureImage.size.height / PICTURE_HEIGHT;
            rect = CGRectMake((pictureImage.size.width-widthD)/2, 0, widthD, pictureImage.size.height);
        }
        else {
            float heightD = pictureImage.size.width * PICTURE_HEIGHT / PICTURE_WIDTH;
            rect = CGRectMake(0, (pictureImage.size.height-heightD)/2, pictureImage.size.width, heightD);
        }
        pictureImage = [pictureImage imageAtRect:rect];
        pictureImage = [pictureImage imageByScalingProportionallyToSize:CGSizeMake(PICTURE_WIDTH, PICTURE_HEIGHT)];
                            
        UIImageView *picture = [[[UIImageView alloc] initWithImage:pictureImage] autorelease];
        picture.frame = CGRectMake(0, 0, PICTURE_WIDTH, PICTURE_HEIGHT);
        picture.center = CGPointMake(centerX - timeLabelBg.size.width/2, VERTICAL_MIDDLE_Y + factor * 150);
        picture.layer.borderColor = [UIColor whiteColor].CGColor;
        picture.layer.borderWidth = 5;
        picture.layer.shadowColor = [UIColor blackColor].CGColor;
        picture.layer.shadowOpacity = 0.3f;
        picture.layer.shadowOffset = CGSizeMake(4.0f, 4.0f);
        picture.layer.shadowRadius = 2.0f;
        picture.layer.masksToBounds = NO;
        [container addSubview:picture];
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
    
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 1024, 690)];
    [self.view addSubview:_scrollView];
    [self setupTimeline];
}

- (void)dealloc
{
    [_scrollView release];
    [super dealloc];
}

@end