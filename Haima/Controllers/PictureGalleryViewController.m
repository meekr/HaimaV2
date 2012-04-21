//
//  PictureGalleryViewController.m
//  Haima
//
//  Created by Lei Perry on 4/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PictureGalleryViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "UIImage+bitrice.h"
#import "PictureGalleryDetailViewController.h"
#import "ImageBrowserItemView.h"


#define PIC_WIDTH 150
#define PIC_HEIGHT 130

@implementation PictureGalleryViewController

- (void)loadView {
    [super loadView];
    [self.navigationController setNavigationBarHidden:YES];
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.view.frame];
    scrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    scrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:scrollView];
    
    UITapGestureRecognizer *gesture = [[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapOnPicture:)] autorelease];
    [self.view addGestureRecognizer:gesture];
    
    for (int i=0; i<15; i++) {
        int row = i / 5;
        int col = i % 5;
        
        CGRect rect = CGRectMake(100+(PIC_WIDTH+10)*col,
                                 20+(PIC_HEIGHT+10)*row,
                                 PIC_WIDTH,
                                 PIC_HEIGHT);
        ImageBrowserItemView *view= [ImageBrowserItemView
                                         itemViewWithFrame:rect
                                         imageURL:[NSURL fileURLWithPath:[NSString stringWithFormat:@"media-%d.JPG", i+1]]];
        view.backgroundColor = [UIColor clearColor];
        view.tag = i+1;
        [scrollView addSubview:view];
    }

    [scrollView release];
}

- (void)viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:YES];
    [super viewWillAppear:animated];
}

- (void)tapOnPicture:(UITapGestureRecognizer *)gesture {
    UIView *scrollView = [self.view.subviews objectAtIndex:0];
    int tapIndex;
    for (int i=0; i<15; i++) {
        UIView *image = [scrollView viewWithTag:i+1];
        CGPoint point = [gesture locationInView:image];
        if (CGRectContainsPoint(image.bounds, point)) {
            tapIndex = i;
            break;
        }
    }
    
    PictureGalleryDetailViewController *vc = [[PictureGalleryDetailViewController alloc] init];
    vc.currentIndex = tapIndex;
    [self.navigationController pushViewController:vc animated:NO];
}

- (void)dealloc {
    [super dealloc];
}

@end