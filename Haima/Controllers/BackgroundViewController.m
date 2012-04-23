//
//  BackgroundViewController.m
//  Haima
//
//  Created by Lei Perry on 4/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "BackgroundViewController.h"

@implementation BackgroundViewController

#pragma mark - View lifecycle

// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
    UIImageView *bgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg.jpg"]];
    bgView.frame = CGRectMake(0, 0, 1024, 768);
    self.view = bgView;
    [bgView release];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationLandscapeLeft);
}

@end
