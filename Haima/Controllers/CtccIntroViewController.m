//
//  CtccIntroViewController.m
//  Haima
//
//  Created by Lei Perry on 4/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CtccIntroViewController.h"

@implementation CtccIntroViewController


#pragma mark - View lifecycle

// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
    [super loadView];
    
    UIImageView *view = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 1024, 570)];
    view.image = [UIImage imageNamed:@"ctcc-intro"];
    [self.view addSubview:view];
    [view release];
}

@end