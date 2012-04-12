//
//  UserGroupViewController.m
//  Haima
//
//  Created by Lei Perry on 4/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "UserGroupViewController.h"


@implementation UserGroupViewController

- (void)loadView
{
    _szDetailPanel = CGSizeMake(554, 306);
    _ptDetailStart = CGPointMake(330, 350);
    _ptDetailEnd = CGPointMake(740, 350);
    
    [super loadView];
    
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 188, 1024, 315)];
    _scrollView.delegate = self;
    _scrollView.pagingEnabled = YES;
    _scrollView.clipsToBounds = NO;
    _scrollView.contentSize = CGSizeMake(self.view.frame.size.width, 315*4);
    [self.view addSubview:_scrollView];
    
    CGFloat x = 160;
    // content item size: 722x315
    UIImageView *item = [[[UIImageView alloc] initWithFrame:CGRectMake(x, 0, 722, 315)] autorelease];
    item.image = [UIImage imageNamed:@"gongwuyuan"];
    item.tag = 0;
    [_scrollView addSubview:item];
    
    item = [[[UIImageView alloc] initWithFrame:CGRectMake(x, 315, 722, 315)] autorelease];
    item.image = [UIImage imageNamed:@"chuangyezhe"];
    item.tag = 1;
    [_scrollView addSubview:item];
    
    item = [[[UIImageView alloc] initWithFrame:CGRectMake(x, 315*2, 722, 315)] autorelease];
    item.image = [UIImage imageNamed:@"jiaoshi"];
    item.tag = 2;
    [_scrollView addSubview:item];
    
    item = [[[UIImageView alloc] initWithFrame:CGRectMake(x, 315*3, 722, 315)] autorelease];
    item.image = [UIImage imageNamed:@"bailing"];
    item.tag = 3;
    [_scrollView addSubview:item];
    
    // tap gesture
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGesture:)];
    [_scrollView addGestureRecognizer:tapGesture];
    [tapGesture release];
    
    
    //
    // detail information 554x306
    //
    _detailInfo = [[UIImageView alloc] initWithFrame:CGRectZero];
    _detailInfo.alpha = 0;
    _detailInfo.clipsToBounds = YES;
    _detailInfo.center = _ptDetailStart;
    _detailInfo.userInteractionEnabled = YES;
    [self.view addSubview:_detailInfo];
    
    UIButton *closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    closeButton.frame = CGRectMake(510, 0, 44, 44);
    closeButton.showsTouchWhenHighlighted = YES;
    [closeButton setImage:[UIImage imageNamed:@"close-cross-button"] forState:UIControlStateNormal];
    [closeButton addTarget:self action:@selector(closeDetailAction:) forControlEvents:UIControlEventTouchUpInside];
    [_detailInfo addSubview:closeButton];
}

- (void)handleTapGesture:(UIGestureRecognizer *)gestureRecognizer {
    if (_detailInfo.alpha == 0) {
        _scrollView.userInteractionEnabled = NO;
        int currentIndex = _scrollView.contentOffset.y / 315;
        switch (currentIndex) {
            case 0:
                _detailInfo.image = [UIImage imageNamed:@"gongwuyuan-INFO"];
                break;
            case 1:
                _detailInfo.image = [UIImage imageNamed:@"chuangyezhe-INFO"];
                break;
            case 2:
                _detailInfo.image = [UIImage imageNamed:@"jiaoshi-INFO"];
                break;
            case 3:
                _detailInfo.image = [UIImage imageNamed:@"bailing-INFO"];
                break;
        }
        
        [UIView animateWithDuration:.2
                              delay:0
                            options:UIViewAnimationCurveEaseInOut
                         animations:^{
                             _detailInfo.alpha = 1;
                             _detailInfo.frame = CGRectMake(_ptDetailEnd.x - _szDetailPanel.width/2,
                                                            _ptDetailEnd.y - _szDetailPanel.height/2,
                                                            _szDetailPanel.width,
                                                            _szDetailPanel.height);
                             _detailInfo.center = _ptDetailEnd;
                         }
                         completion:^(BOOL finished){
                         }];
    }
}

- (void)closeDetailAction:(UIButton*)button {
    [UIView animateWithDuration:.2
                          delay:0
                        options:UIViewAnimationCurveEaseInOut
                     animations:^{
                         _detailInfo.alpha = 0;
                         _detailInfo.center = _ptDetailStart;
                         _detailInfo.frame = CGRectMake(_ptDetailStart.x, _ptDetailStart.y, 0, 0);
                     }
                     completion:^(BOOL finished){
                         _scrollView.userInteractionEnabled = YES;
                     }];
}

     
- (void)viewDidLoad {
    [super viewDidLoad];
    
    _scrollView.contentOffset = CGPointMake(0, 315);
    [self scrollViewDidEndDecelerating:_scrollView];
}

- (void)dealloc {
    [_scrollView release];
    [_detailInfo release];
    [super dealloc];
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    int currentIndex = scrollView.contentOffset.y / 315;
    for (int i=0; i<4; i++) {
        UIImageView *view = [_scrollView.subviews objectAtIndex:i];
        view.alpha = (i==currentIndex ? 1 : 0.3);    
    }
}

@end