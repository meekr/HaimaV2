//
//  PictureGalleryDetailViewController.m
//  Haima
//
//  Created by Lei Perry on 4/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PictureGalleryDetailViewController.h"
#import "UIImage+bitrice.h"
#import "ImageBrowserItemView.h"

@implementation PictureGalleryDetailViewController

@synthesize currentIndex = _currentIndex;

- (void)loadView {
    [super loadView];
    self.view.backgroundColor = [UIColor yellowColor];
    
    CGRect rect = CGRectMake(120, 0, 1024-240, 768-198);
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:rect];
    scrollView.contentSize = CGSizeMake(rect.size.width*15, rect.size.height);
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.pagingEnabled = YES;
    [self.view addSubview:scrollView];
    
    for (int i=0; i<15; i++) {
        CGRect r = CGRectMake(i*rect.size.width, 0, rect.size.width, rect.size.height);
        NSLog(@"%@", NSStringFromCGRect(r));
        ImageBrowserItemView *view= [ImageBrowserItemView
                                     itemViewWithFrame:r
                                     imageURL:[NSURL fileURLWithPath:[NSString stringWithFormat:@"media-%d.JPG", i+1]]];
//        UIView *view = [[[UIView alloc] initWithFrame:r] autorelease];
        view.backgroundColor = [UIColor blueColor];
        view.tag = i+1;
        UILabel *l = [[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 300, 30)] autorelease];
        l.text = [NSString stringWithFormat:@"AAAAAA %d", i];
        [view addSubview:l];
        [scrollView addSubview:view];
        
        
//        UIImageView *view = [[UIImageView alloc] initWithFrame:CGRectMake(i*rect.size.width, 0, rect.size.width, rect.size.height)];
//        view.tag = i+1;
//        view.image = [UIImage imageNamed:[NSString stringWithFormat:@"media-%d.JPG", i+1]];
//        view.image = [view.image imageByScalingProportionallyToSize:rect.size];
//        view.contentMode = UIViewContentModeCenter;
//        view.backgroundColor = [UIColor blueColor];
//        [scrollView addSubview:view];
    }
    
    [scrollView release];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.showsTouchWhenHighlighted = YES;
    button.frame = CGRectMake(rect.origin.x, rect.origin.y, 44, 44);
    [button setBackgroundImage:[UIImage imageNamed:@"return-button"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(returnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIScrollView *scrollView = (UIScrollView *)[self.view.subviews objectAtIndex:0];
    [scrollView setContentOffset:CGPointMake(_currentIndex*scrollView.frame.size.width, 0) animated:YES];
}

- (void)returnAction:(UIButton *)button {
    [self.navigationController popViewControllerAnimated:NO];
}

- (void)handleTapGesture:(UIGestureRecognizer *)gesture {
    
}

- (void)dealloc {
    [super dealloc];
}

@end
