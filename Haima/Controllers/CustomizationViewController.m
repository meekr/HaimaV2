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


#define SELECTION_ITEM_WIDTH 160
#define SELECTION_ITEM_HEIGHT 130

@interface CustomizationViewController ()

- (void)layoutMySelection;

@end

@implementation CustomizationViewController

@synthesize coverflow = _coverflow;
@synthesize covers = _covers;


- (void)loadView {
    [super loadView];
    
    _tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapOnPreview:)];
    _selectionDoubleTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapOnSelection:)];
    _selectionDoubleTapGesture.numberOfTapsRequired = 2;


    _coverflow = [[TKCoverflowView alloc] initWithFrame:CGRectMake(0, 120, 1024, 490)];
	_coverflow.coverflowDelegate = self;
	_coverflow.dataSource = self;
	_coverflow.coverSpacing = 100;
    _coverflow.coverSize = CGSizeMake(COVER_FLOW_ITEM_WIDTH, COVER_FLOW_ITEM_HEIGHT);
	[self.view addSubview:_coverflow];
    
    _mySelectionView = [[UIScrollView alloc] initWithFrame:CGRectMake(400, 500, 624, 160)];
    _mySelectionView.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:_mySelectionView];
    [_mySelectionView addGestureRecognizer:_selectionDoubleTapGesture];
    
    _previewImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 1024, 768)];
    _previewImageView.userInteractionEnabled = YES;
    _previewImageView.alpha = 0;
    [self.view addSubview:_previewImageView];
    
    
    _mySelection = [[NSMutableArray alloc] init];
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

- (void)tapOnSelection:(UITapGestureRecognizer *)gesture {
    CGPoint p = [gesture locationInView:_mySelectionView];
    UIImageView *v;
    for (UIImageView *view in _mySelection) {
        if (CGRectContainsPoint(view.frame, p)) {
            v = view;
            _doubleTappedSelectionTag = v.tag;
            break;
        }
    }
    
    // animation
    UIImageView *selCopy = [[UIImageView alloc] initWithImage:v.image];
    selCopy.tag = 1099;
    selCopy.frame = [_mySelectionView convertRect:v.frame toView:self.view];
    [self.view addSubview:selCopy];
    [selCopy release];
    
    
    CGPoint point = CGPointMake(60, 650);
    UIBezierPath *movePath = [UIBezierPath bezierPath];
    [movePath moveToPoint:selCopy.center];
    [movePath addQuadCurveToPoint:point
                     controlPoint:CGPointMake(512, 345)];
    
    CAKeyframeAnimation *moveAnim = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    moveAnim.path = movePath.CGPath;
    moveAnim.removedOnCompletion = YES;
    
    CABasicAnimation *scaleAnim = [CABasicAnimation animationWithKeyPath:@"transform"];
    scaleAnim.fromValue = [NSValue valueWithCGAffineTransform:CGAffineTransformIdentity];
    scaleAnim.toValue = [NSValue valueWithCGAffineTransform:CGAffineTransformMakeScale(0.1, 0.1)];
    scaleAnim.removedOnCompletion = YES;
    
    CABasicAnimation *opacityAnim = [CABasicAnimation animationWithKeyPath:@"alpha"];
    opacityAnim.fromValue = [NSNumber numberWithFloat:1.0];
    opacityAnim.toValue = [NSNumber numberWithFloat:0.1];
    opacityAnim.removedOnCompletion = YES;
    
    CAAnimationGroup *animGroup = [CAAnimationGroup animation];
    animGroup.animations = [NSArray arrayWithObjects:moveAnim, scaleAnim, opacityAnim, nil];
    animGroup.duration = 0.5;
    animGroup.delegate = self;
    [selCopy.layer addAnimation:animGroup forKey:nil];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    UIView *view = [self.view viewWithTag:1099];
    [view removeFromSuperview];
    
    UIView *selection = [_mySelectionView viewWithTag:_doubleTappedSelectionTag];
    if (selection) {
        [selection removeFromSuperview];
    }
    
    for (UIView *v in _mySelection) {
        if (v.tag == _doubleTappedSelectionTag) {
            [_mySelection removeObject:v];
            break;
        }
    }
    
    _doubleTappedSelectionTag = -1;
    [self layoutMySelection];
}

- (void)layoutMySelection {
    float targetWidth = MAX((_mySelection.count)*(SELECTION_ITEM_WIDTH+10)+10, _mySelectionView.frame.size.width);
    
    for (int i=0; i<_mySelection.count; i++) {
        UIView *v = [_mySelection objectAtIndex:i];
        float targetX = targetWidth-(i+1)*(SELECTION_ITEM_WIDTH+10);
        v.frame = CGRectMake(targetX, v.frame.origin.y, v.frame.size.width, v.frame.size.height);
    }
    _mySelectionView.contentSize = CGSizeMake(targetWidth, _mySelectionView.frame.size.height);
    [_mySelectionView setContentOffset:CGPointMake(0, 0) animated:YES];
}

- (void)dealloc
{
    [_tapGesture release];
    [_selectionDoubleTapGesture release];
    [_previewImageView release];
    [_coverflow release];
    [_covers release];
    [_mySelection release];
    [_mySelectionView release];
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
    UIView *existedView = [_mySelectionView viewWithTag:index+1];
    if (existedView)
        return;
    
	TKCoverflowCoverView *cover = [coverflowView coverAtIndex:index];
    UIImageView *coverCopy = [[[UIImageView alloc] initWithImage:cover.image] autorelease];
    coverCopy.tag = 1099;
    coverCopy.frame = [self.view convertRect:cover.frame fromView:cover.superview];
    [self.view addSubview:coverCopy];

    float centerX = MAX(_mySelectionView.frame.origin.x+_mySelectionView.frame.size.width-(_mySelection.count+0.5)*(SELECTION_ITEM_WIDTH+10)-5, SELECTION_ITEM_WIDTH/2+10);
    float centerY = _mySelectionView.frame.origin.y+_mySelectionView.frame.size.height/2;
    CGRect r = CGRectMake(centerX-SELECTION_ITEM_WIDTH/2, centerY-SELECTION_ITEM_HEIGHT/2, SELECTION_ITEM_WIDTH, SELECTION_ITEM_HEIGHT);
    UIImageView *newItem = [[[UIImageView alloc] initWithFrame:[self.view convertRect:r toView:_mySelectionView]] autorelease];
    newItem.userInteractionEnabled = YES;
    newItem.tag = index+1;
    newItem.image = coverCopy.image;
    
    [UIView animateWithDuration:.2
                          delay:0
                        options:UIViewAnimationCurveEaseInOut
                     animations:^{
                         coverCopy.frame = r;
                     }
                     completion:^(BOOL finished){
                         [_mySelectionView addSubview:newItem];
                         [_mySelection addObject:newItem];
                         [self layoutMySelection];
                         [coverCopy removeFromSuperview];
                     }];
}

@end