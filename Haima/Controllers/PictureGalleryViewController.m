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


#define PIC_WIDTH 145
#define PIC_HEIGHT 115

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
        UIImageView *view = [[UIImageView alloc] initWithFrame:CGRectMake(100+(PIC_WIDTH+20)*col,
                                                                          20+(PIC_HEIGHT+20)*row,
                                                                          PIC_WIDTH,
                                                                          PIC_HEIGHT)];
        view.tag = i+1;
        view.image = [[UIImage imageNamed:[NSString stringWithFormat:@"media-%d.JPG", i+1]]
                      imageByScalingProportionallyToSize:CGSizeMake(PIC_WIDTH, PIC_HEIGHT)];
        view.layer.borderColor = [UIColor whiteColor].CGColor;
        view.layer.borderWidth = 5;
        view.layer.shadowColor = [UIColor blackColor].CGColor;
        view.layer.shadowOpacity = 0.3f;
        view.layer.shadowOffset = CGSizeMake(2.0f, 2.0f);
        view.layer.shadowRadius = 2.0f;
        view.layer.masksToBounds = NO;
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