//
//  PromotionViewController.m
//  Haima
//
//  Created by Lei Perry on 4/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PromotionViewController.h"

@implementation PromotionViewController

- (CGPathRef)renderPaperCurl:(UIView*)imgView {
	CGSize size = imgView.bounds.size;
	CGFloat curlFactor = 15.0f;
	CGFloat shadowDepth = 5.0f;
    
	UIBezierPath *path = [UIBezierPath bezierPath];
	[path moveToPoint:CGPointMake(0.0f, 0.0f)];
	[path addLineToPoint:CGPointMake(size.width, 0.0f)];
	[path addLineToPoint:CGPointMake(size.width, size.height + shadowDepth)];
	[path addCurveToPoint:CGPointMake(0.0f, size.height + shadowDepth)
			controlPoint1:CGPointMake(size.width - curlFactor, size.height + shadowDepth - curlFactor)
			controlPoint2:CGPointMake(curlFactor, size.height + shadowDepth - curlFactor)];
    
	return path.CGPath;
}

- (void)loadView {
    [super loadView];
    
    UIImage *titleBgImage = [UIImage imageNamed:@"promotion-title-bg"];
    UIImageView *titleBg = [[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, titleBgImage.size.width, titleBgImage.size.height)] autorelease];
    titleBg.image = titleBgImage;
    
    titleView = [[UIView alloc] initWithFrame:CGRectMake(36, 105, titleBg.frame.size.width, titleBg.frame.size.height)];
    [self.view addSubview:titleView];
    [titleView addSubview:titleBg];
    
    webView = [[UIWebView alloc] initWithFrame:CGRectMake(356, 88, 640, 525)];
    webView.layer.borderColor = [UIColor colorWithRed:0.7 green:0.7 blue:0.7 alpha:0.5].CGColor;
    webView.layer.borderWidth = 2.0;
    webView.layer.shadowColor = [UIColor blackColor].CGColor;
	webView.layer.shadowOpacity = 0.7f;
	webView.layer.shadowOffset = CGSizeMake(10.0f, 10.0f);
	webView.layer.shadowRadius = 2.0f;
	webView.layer.masksToBounds = NO;
    webView.layer.shadowPath = [self renderPaperCurl:webView];
    [self.view addSubview:webView];
}

- (void)viewDidLoad {
    NSURL *url = [NSURL URLWithString:@"http://haima.com/hk/news.asp"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
}

- (void)dealloc
{
    [titleView release];
    [webView release];
    [super dealloc];
}

@end