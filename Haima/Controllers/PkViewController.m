//
//  PkViewController.m
//  Haima
//
//  Created by Lei Perry on 4/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PkViewController.h"

@implementation PkViewController

- (void)loadView
{
    UIImageView *view = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 1024, 690)];
    view.image = [UIImage imageNamed:@"pk-bg"];
    view.userInteractionEnabled = YES;
    self.view = view;
    [view release];
    
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(34, 222, 965, 406)];
    
    
    UIImage *leftImage = [UIImage imageNamed:@"pk-left"];
    UIImage *rightImage = [UIImage imageNamed:@"pk-right-0"];
    
    UIImageView *leftImageView = [[UIImageView alloc] initWithFrame:CGRectMake(1, 0, leftImage.size.width, leftImage.size.height)];
    leftImageView.image = leftImage;
    [_scrollView addSubview:leftImageView];
    [leftImageView release];

    _rightContentView = [[UIView alloc] initWithFrame:CGRectMake(leftImage.size.width+1, 0, rightImage.size.width, rightImage.size.height)];
    [_scrollView addSubview:_rightContentView];
    
    for (int i=0; i<5; i++) {
        UIImage *rightImage = [UIImage imageNamed:[NSString stringWithFormat:@"pk-right-%d", i]];
        
        UIImageView *rightImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, rightImage.size.width, rightImage.size.height)];
        rightImageView.image = rightImage;
        rightImageView.alpha = i==0 ? 1 : 0;
        [_rightContentView addSubview:rightImageView];
        [rightImageView release];
    }
    
    _scrollView.contentSize = CGSizeMake(_scrollView.frame.size.width, leftImage.size.height);
    [self.view addSubview:_scrollView];
    
    
    // model selection combo
    NSArray *models = [NSArray arrayWithObjects:@"帝豪EC7", @"比亚迪G3", @"奔腾B50", @"日产阳光", @"现代悦动", nil];
    
    UIImage *comboBg = [UIImage imageNamed:@"pk-combo-bg"];
    _comboButton = [[UIButton buttonWithType:UIButtonTypeCustom] retain];
    _comboButton.frame = CGRectMake(771, 147, comboBg.size.width, comboBg.size.height);
    [_comboButton setTitle:[models objectAtIndex:0] forState:UIControlStateNormal];
    [_comboButton setBackgroundImage:comboBg forState:UIControlStateNormal];
    [_comboButton setBackgroundImage:comboBg forState:UIControlStateHighlighted];
    [_comboButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_comboButton.titleLabel setFont:[UIFont boldSystemFontOfSize:14]];
    [_comboButton addTarget:self action:@selector(comboTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_comboButton];
    
    _comboList = [[UIImageView alloc] initWithFrame:CGRectMake(771, 175, comboBg.size.width, 0)];
    _comboList.clipsToBounds = YES;
    _comboList.userInteractionEnabled = YES;
    _comboList.image = [[UIImage imageNamed:@"pk-combo-list-bg"] stretchableImageWithLeftCapWidth:10 topCapHeight:10];
    [self.view addSubview:_comboList];
    
    for (int i=0; i<models.count; i++) {
        UIButton *item = [UIButton buttonWithType:UIButtonTypeCustom];
        item.frame = CGRectMake(0, i*27, _comboList.frame.size.width, 27);
        [item setTitle:[models objectAtIndex:i] forState:UIControlStateNormal];
        [item setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [item.titleLabel setFont:[UIFont boldSystemFontOfSize:14]];
        [item setBackgroundImage:[UIImage imageNamed:@"pk-combo-item-selected"] forState:UIControlStateHighlighted];
        [item addTarget:self action:@selector(comboListItemTapped:) forControlEvents:UIControlEventTouchUpInside];
        [_comboList addSubview:item];
    }
}

- (void)comboTapped:(UIButton *)button {
    int targetH = (_comboList.frame.size.height == 0 ? 135 : 0);
    [UIView animateWithDuration:.2
                          delay:0
                        options:UIViewAnimationCurveEaseInOut
                     animations:^{
                         _comboList.frame = CGRectMake(_comboList.frame.origin.x,
                                                       _comboList.frame.origin.y,
                                                       _comboList.frame.size.width,
                                                       targetH);
                     }
                     completion:^(BOOL finished){
                     }];
}

- (void)comboListItemTapped:(UIButton *)button {
    int index = [_comboList.subviews indexOfObject:button];
    for (int i=0; i<5; i++) {
        UIView *view = [_rightContentView.subviews objectAtIndex:i];
        if (i == index) {
            [UIView animateWithDuration:.2
                                  delay:0
                                options:UIViewAnimationCurveEaseInOut
                             animations:^{
                                 view.alpha = 1;
                             }
                             completion:^(BOOL finished){
                             }];
        }
        else if (view.alpha == 1) {
            [UIView animateWithDuration:.2
                                  delay:0
                                options:UIViewAnimationCurveEaseInOut
                             animations:^{
                                 view.alpha = 0;
                             }
                             completion:^(BOOL finished){
                             }];
        }
    }
    [_comboButton setTitle:button.titleLabel.text forState:UIControlStateNormal];
    [UIView animateWithDuration:.2
                          delay:0
                        options:UIViewAnimationCurveEaseInOut
                     animations:^{
                         _comboList.frame = CGRectMake(_comboList.frame.origin.x,
                                                       _comboList.frame.origin.y,
                                                       _comboList.frame.size.width,
                                                       0);
                     }
                     completion:^(BOOL finished){
                     }];
}

- (void)dealloc
{
    [_comboButton release];
    [_comboList release];
    [_scrollView release];
    [_rightContentView release];
    [super dealloc];
}

@end