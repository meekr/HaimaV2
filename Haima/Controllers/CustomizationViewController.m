//
//  CustomizationViewController.m
//  Haima
//
//  Created by Lei Perry on 4/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CustomizationViewController.h"
#import "UIImage+bitrice.h"
#import "Constants.h"

@implementation CustomizationViewController

@synthesize coverflow = _coverflow;
@synthesize covers = _covers;


- (void)loadView {
    [super loadView];
    
    _coverflow = [[TKCoverflowView alloc] initWithFrame:CGRectMake(0, 120, 1024, 490)];
	_coverflow.coverflowDelegate = self;
	_coverflow.dataSource = self;
	_coverflow.coverSpacing = 100;
    _coverflow.coverSize = CGSizeMake(COVER_FLOW_ITEM_WIDTH, COVER_FLOW_ITEM_HEIGHT);
	[self.view addSubview:_coverflow];
    
    _previewImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 1024, 768)];
    _previewImageView.userInteractionEnabled = YES;
    _previewImageView.alpha = 0;
    [self.view addSubview:_previewImageView];
    
    _tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapOnPreview:)];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _covers = [[NSMutableArray alloc] init];
    for (int i=1; i<20; i++) {
        [_covers addObject:[UIImage imageNamed:[NSString stringWithFormat:@"customization-%d.jpg", i]]];
    }
    [_coverflow setNumberOfCovers:_covers.count];
    [_coverflow bringCoverAtIndexToFront:[_covers count]/2 animated:YES];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)tapOnPreview:(UITapGestureRecognizer *)gesture {
    [_previewImageView removeGestureRecognizer:_tapGesture];
    [UIView animateWithDuration:.2
                          delay:0
                        options:UIViewAnimationCurveEaseInOut
                     animations:^{
                         _previewImageView.alpha = 0;
                         _previewImageView.transform = CGAffineTransformMakeScale(COVER_FLOW_ITEM_WIDTH/1024, COVER_FLOW_BASELINE/768);;
                         _previewImageView.center = CGPointMake(512, 345);
                     }
                     completion:^(BOOL finished){
                         [_previewImageView removeFromSuperview];
                         _coverflow.userInteractionEnabled = YES;
                     }];
}

- (void)dealloc
{
    [_tapGesture release];
    [_previewImageView release];
    [_coverflow release];
    [_covers release];
    [super dealloc];
}

#pragma mark - TKCoverflowViewDelegate,TKCoverflowViewDataSource
- (void)coverflowView:(TKCoverflowView*)coverflowView coverAtIndexWasBroughtToFront:(int)index {
}

- (TKCoverflowCoverView *)coverflowView:(TKCoverflowView *)coverflowView coverAtIndex:(int)index {
	TKCoverflowCoverView *cover = [coverflowView dequeueReusableCoverView];
	if (cover == nil) {
		CGRect rect = CGRectMake(0, 0, COVER_FLOW_ITEM_WIDTH, 600);
        cover = [[TKCoverflowCoverView alloc] initWithFrame:rect]; // 224
		cover.baseline = COVER_FLOW_BASELINE;
	}
    
    CGRect rect = CGRectMake(0, 0, COVER_FLOW_ITEM_WIDTH, COVER_FLOW_BASELINE);

    // load image in other thread
    dispatch_queue_t main_queue = dispatch_get_main_queue();
    dispatch_queue_t request_queue = dispatch_queue_create("com.app.biterice", NULL);
    
    dispatch_async(request_queue, ^{
        UIImage *image = [_covers objectAtIndex:index%[_covers count]];
        image = [image imageByScalingProportionallyToSize:rect.size];

        dispatch_sync(main_queue, ^{
            cover.image = image;
        });
        dispatch_release(request_queue);
    });
	
	return cover;
}

- (void) coverflowView:(TKCoverflowView*)coverflowView coverAtIndexWasTapped:(int)index {
    _previewImageView.image = [_covers objectAtIndex:index];
    _previewImageView.transform = CGAffineTransformMakeScale(COVER_FLOW_ITEM_WIDTH/1024, COVER_FLOW_BASELINE/768);
    _coverflow.userInteractionEnabled = NO;
    [self.view addSubview:_previewImageView];
    [UIView animateWithDuration:.2
                          delay:0
                        options:UIViewAnimationCurveEaseInOut
                     animations:^{
                         _previewImageView.alpha = 1;
                         _previewImageView.transform = CGAffineTransformMakeScale(1, 690.0/768);
                         _previewImageView.center = CGPointMake(512, 345);
                     }
                     completion:^(BOOL finished){
                         [_previewImageView addGestureRecognizer:_tapGesture];
                     }];
}

- (void) coverflowView:(TKCoverflowView*)coverflowView coverAtIndexWasDoubleTapped:(int)index {
	TKCoverflowCoverView *cover = [coverflowView coverAtIndex:index];
	if (cover == nil) return;
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:1];
	[UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:cover cache:YES];
	[UIView commitAnimations];
	
	NSLog(@"Index: %d",index);
}

@end