//
//  ProductAdvantageViewController.m
//  Haima
//
//  Created by Lei Perry on 4/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ProductAdvantageViewController.h"

@implementation ProductAdvantageViewController

@synthesize homeScreen = _homeScreen;

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

    // navigate home
    bgImage = [UIImage imageNamed:@"product-navigate-bg"];
    self.homeScreen = [[[UIView alloc] initWithFrame:CGRectMake(240, 170, bgImage.size.width, bgImage.size.height)] autorelease];
    [self.view addSubview:self.homeScreen];
    
    UIImageView *homeBg = [[UIImageView alloc] initWithImage:bgImage];
    [self.homeScreen addSubview:homeBg];
    [homeBg release];
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(50, 12, 265, 163)];
    button.backgroundColor = [UIColor clearColor];
    [button setBackgroundImage:[UIImage imageNamed:@"product-navigate-button-manifest"] forState:UIControlStateNormal];
    [button setShowsTouchWhenHighlighted:YES];
    [self.homeScreen addSubview:button];
    [button release];
    
    button = [[UIButton alloc] initWithFrame:CGRectMake(320, 12, 265, 163)];
    button.backgroundColor = [UIColor clearColor];
    [button setBackgroundImage:[UIImage imageNamed:@"product-navigate-button-control"] forState:UIControlStateNormal];
    [button setShowsTouchWhenHighlighted:YES];
    [self.homeScreen addSubview:button];
    [button release];
    
    button = [[UIButton alloc] initWithFrame:CGRectMake(50, 177, 265, 163)];
    button.backgroundColor = [UIColor clearColor];
    [button setBackgroundImage:[UIImage imageNamed:@"product-navigate-button-safety"] forState:UIControlStateNormal];
    [button setShowsTouchWhenHighlighted:YES];
    [self.homeScreen addSubview:button];
    [button release];
    
    button = [[UIButton alloc] initWithFrame:CGRectMake(320, 177, 265, 163)];
    button.backgroundColor = [UIColor clearColor];
    [button setBackgroundImage:[UIImage imageNamed:@"product-navigate-button-quality"] forState:UIControlStateNormal];
    [button setShowsTouchWhenHighlighted:YES];
    [self.homeScreen addSubview:button];
    [button release];
}

- (void)dealloc
{
    [_homeScreen release];
    [super dealloc];
}

@end
