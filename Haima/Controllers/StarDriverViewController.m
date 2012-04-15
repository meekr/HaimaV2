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
        button.tag = i;
        [button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"star-driver-%d", i+1]] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"star-driver-%d", i+1]] forState:UIControlStateSelected];
        [button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"star-driver-%d", i+1]] forState:UIControlStateHighlighted];
        [button addTarget:self action:@selector(switchDriverInfo:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
    }
    
    UIImageView *info = [[[UIImageView alloc] initWithFrame:CGRectMake(571, 20, 395, 410)] autorelease];
    info.tag = 4;
    info.image = [UIImage imageNamed:@"star-driver-info-bg"];
    [self.view addSubview:info];
    
//    UIImageView *view = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 1024, 570)];
//    view.image = [UIImage imageNamed:@"star-driver-bg"];
//    [self.view addSubview:view];
//    [view release];
    
//    int x = 121;
//    int y = 219;
//    for (int i=1; i<=4; i++) {
//        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
//        button.frame = CGRectMake(x, y, 183, 268);
//        button.tag = i;
//        [button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"star-driver-%d", i]] forState:UIControlStateNormal];
//        [button addTarget:self action:@selector(starDriverClicked:) forControlEvents:UIControlEventTouchUpInside];
//        [self.view addSubview:button];
//        x += 198;
//    }
}

- (void)switchDriverInfo:(UIButton *)button {
    [self.view bringSubviewToFront:button];
    for (int i=0; i<3; i++) {
        UIButton *btn = (UIButton *)[self.view viewWithTag:i];
        btn.alpha = 0.5;
    }
    button.alpha = 1;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *button = (UIButton *)[self.view viewWithTag:0];
    [self switchDriverInfo:button];
}


- (void)dealloc
{
    [super dealloc];
}

@end