//
//  MaintenanceViewController.m
//  Haima
//
//  Created by Lei Perry on 4/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MaintenanceViewController.h"

@implementation MaintenanceViewController

#pragma mark - View lifecycle

- (void)loadView
{
    UIImageView *view = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 1024, 690)];
    view.image = [UIImage imageNamed:@"price-table-bg"];
    view.userInteractionEnabled = YES;
    self.view = view;
    [view release];
    
    UIScrollView *content = [[[UIScrollView alloc] initWithFrame:CGRectMake(34, 163, 963, 454)] autorelease];

    
    UIImage *contentImage = [UIImage imageNamed:@"price-table-content"];
    UIImageView *contentImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, contentImage.size.width, contentImage.size.height)];
    contentImageView.image = contentImage;
    [content addSubview:contentImageView];
    [contentImageView release];
    
    content.contentSize = CGSizeMake(contentImage.size.width, contentImage.size.height);
    [self.view addSubview:content];
}

- (void)dealloc
{
    [super dealloc];
}

@end