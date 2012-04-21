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
    
    CGRect rect = CGRectMake(120, 0, 1024-240, 492);
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:rect];
    scrollView.contentSize = CGSizeMake(rect.size.width*15, rect.size.height);
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.pagingEnabled = YES;
    [self.view addSubview:scrollView];
    
    for (int i=0; i<15; i++) {
        CGRect r = CGRectMake(i*rect.size.width, 0, rect.size.width, rect.size.height);
        ImageBrowserItemView *view= [ImageBrowserItemView
                                     itemViewWithFrame:r
                                     imageURL:nil];
        view.imageDelegate = self;
        view.backgroundColor = [UIColor clearColor];
        view.tag = i+1;
        [scrollView addSubview:view];
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
    
    // load images
    ImageBrowserItemView *view = [scrollView.subviews objectAtIndex:_currentIndex];
    view.imageURL = [NSURL fileURLWithPath:[NSString stringWithFormat:@"media-%d.JPG", _currentIndex+1]];
    
    
    // load other images in other thread
    dispatch_queue_t main_queue = dispatch_get_main_queue();
    dispatch_queue_t request_queue = dispatch_queue_create("com.app.biterice", NULL);
    
    dispatch_async(request_queue, ^{
        for (int i=0; i<15; i++) {
            if (i != _currentIndex) {
                dispatch_sync(main_queue, ^{
                    ImageBrowserItemView *view = [scrollView.subviews objectAtIndex:i];
                    view.imageURL = [NSURL fileURLWithPath:[NSString stringWithFormat:@"media-%d.JPG", i+1]];
                });
            }
            
            if (i==14)
                dispatch_release(request_queue);
        }
    });
}

- (void)returnAction:(UIButton *)button {
    [self.navigationController popViewControllerAnimated:NO];
}

- (void)handleTapGesture:(UIGestureRecognizer *)gesture {
    
}

- (void)dealloc {
    [super dealloc];
}


#pragma mark - ImageBrowserItemLayerDelegate
- (CGRect)getImageLayerFrameByImageSize:(CGSize)imageSize andBoundsSize:(CGSize)boundsSize {
    CGSize s = imageSize;
    CGRect r = CGRectMake(0, 0, boundsSize.width, boundsSize.height);
    CGFloat scale = MIN(r.size.width / s.width, r.size.height / s.height);
    s.width *= scale; s.height *= scale;
    r.origin.x += (r.size.width - s.width) * .5;
    r.size.width = s.width;
    r.origin.y += (r.size.height - s.height) * .5;
    r.size.height = s.height;
    return r;
}


@end
