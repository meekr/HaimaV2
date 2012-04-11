//
//  BrandHistoryViewController.m
//  Haima
//
//  Created by Lei Perry on 4/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "BrandHistoryViewController.h"

@implementation BrandHistoryViewController

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
}

- (void)dealloc
{
    [super dealloc];
}

@end