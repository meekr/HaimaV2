//
//  StarDriverViewController.m
//  Haima
//
//  Created by Lei Perry on 4/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "StarDriverViewController.h"

@implementation StarDriverViewController

- (void)loadView
{
    [super loadView];
    
    NSArray *array = [NSArray arrayWithObjects:NSStringFromCGRect(CGRectMake(68, 54, 224, 312)),
                      NSStringFromCGRect(CGRectMake(230, 25, 226, 312)),
                      NSStringFromCGRect(CGRectMake(404, 80, 214, 284)), nil];
    for (int i=0; i<array.count; i++) {
        UIButton *button = [[[UIButton alloc] initWithFrame:CGRectFromString([array objectAtIndex:i])] autorelease];
        button.tag = i+1;
        [button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"star-driver-%d", i+1]] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"star-driver-%d", i+1]] forState:UIControlStateSelected];
        [button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"star-driver-%d", i+1]] forState:UIControlStateHighlighted];
        [button addTarget:self action:@selector(switchDriverInfo:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
    }
    
    UIImageView *info = [[[UIImageView alloc] initWithFrame:CGRectMake(571, 20, 395, 410)] autorelease];
    info.tag = 99;
    info.userInteractionEnabled = YES;
    info.image = [UIImage imageNamed:@"star-driver-info-bg"];
    [self.view addSubview:info];

    UIScrollView *scroll = [[[UIScrollView alloc] initWithFrame:CGRectMake(620, 70, 303, 292)] autorelease];
    _driverInfoView = [[UIImageView alloc] init];
    [scroll addSubview:_driverInfoView];
    [self.view addSubview:scroll];
}

- (void)switchDriverInfo:(UIButton *)button {
    [self.view bringSubviewToFront:button];
    for (int i=0; i<3; i++) {
        UIButton *btn = (UIButton *)[self.view viewWithTag:i+1];
        btn.alpha = 0.5;
    }
    button.alpha = 1;
    
    UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"star-driver-%d-info", button.tag]];
    _driverInfoView.image = image;
    _driverInfoView.frame = CGRectMake(0, 0, image.size.width, image.size.height);
    UIScrollView *scroll = (UIScrollView *)[_driverInfoView superview];
    scroll.contentSize = CGSizeMake(image.size.width, image.size.height);
    [scroll scrollsToTop];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *button = (UIButton *)[self.view viewWithTag:1];
    [self switchDriverInfo:button];
}


- (void)dealloc
{
    [_driverInfoView release];
    [super dealloc];
}

@end