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
    UIView *view = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, 1024, 690)] autorelease];
    self.view = view;
    
    UIWebView *webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
	NSString *path = [[NSBundle mainBundle] pathForResource:@"config" ofType:@"html"];
	[webView loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:path]]];
	webView.delegate = self;
    [self.view addSubview:webView];
    
    // turn off bounce
    for (id sv in webView.subviews){
        if ([[sv class] isSubclassOfClass: [UIScrollView class]])
            ((UIScrollView *)sv).bounces = NO;
    }
    
    [webView release];
}

- (void)dealloc
{
    [super dealloc];
}

@end