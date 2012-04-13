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
    
    UIImageView *view = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 1024, 570)];
    view.image = [UIImage imageNamed:@"star-driver-bg"];
    [self.view addSubview:view];
    [view release];
    
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

- (void)starDriverClicked:(UIButton *)button {
    NSLog(@"click: %d", button.tag);
}

- (void)dealloc
{
    [super dealloc];
}

@end