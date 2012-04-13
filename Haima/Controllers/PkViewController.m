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
    
    UIScrollView *scrollView = [[[UIScrollView alloc] initWithFrame:CGRectMake(34, 222, 965, 406)] autorelease];
    
    
    UIImage *leftImage = [UIImage imageNamed:@"pk-left"];
    UIImage *rightImage = [UIImage imageNamed:@"pk-right-0"];
    
    UIImageView *leftImageView = [[UIImageView alloc] initWithFrame:CGRectMake(1, 0, leftImage.size.width, leftImage.size.height)];
    leftImageView.image = leftImage;
    [scrollView addSubview:leftImageView];
    [leftImageView release];
    
    UIImageView *rightImageView = [[UIImageView alloc] initWithFrame:CGRectMake(leftImage.size.width+1, 0, rightImage.size.width, rightImage.size.height)];
    rightImageView.tag = 0;
    rightImageView.image = rightImage;
    [scrollView addSubview:rightImageView];
    [rightImageView release];
    
    for (int i=1; i<5; i++) {
        rightImage = [UIImage imageNamed:[NSString stringWithFormat:@"pk-right-%d", i]];
        
        rightImageView = [[UIImageView alloc] initWithFrame:CGRectMake(leftImage.size.width+1, 0, rightImage.size.width, rightImage.size.height)];
        rightImageView.tag = i;
        rightImageView.image = rightImage;
        rightImageView.alpha = 0;
        [scrollView insertSubview:rightImageView atIndex:1];
        [rightImageView release];
    }
    
    scrollView.contentSize = CGSizeMake(scrollView.frame.size.width, leftImage.size.height);
    [self.view addSubview:scrollView];
}

- (void)dealloc
{
    [super dealloc];
}

@end