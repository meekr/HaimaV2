//
//  ChampionViewController.m
//  Haima
//
//  Created by Lei Perry on 4/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ChampionViewController.h"

@implementation ChampionViewController

- (id)init
{
    UIViewController *detailController1 = [[[UIViewController alloc] init] autorelease];
    detailController1.view.backgroundColor = [UIColor orangeColor];
    
    UIViewController *detailController2 = [[[UIViewController alloc] init] autorelease];
    detailController2.view.backgroundColor = [UIColor greenColor];
    
    UIViewController *detailController3 = [[[UIViewController alloc] init] autorelease];
    detailController3.view.backgroundColor = [UIColor blueColor];
    
    UIViewController *detailController4 = [[[UIViewController alloc] init] autorelease];
    detailController4.view.backgroundColor = [UIColor cyanColor];
    
    UIViewController *detailController5 = [[[UIViewController alloc] init] autorelease];
    detailController5.view.backgroundColor = [UIColor yellowColor];
    
    UIViewController *detailController6 = [[[UIViewController alloc] init] autorelease];
    detailController6.view.backgroundColor = [UIColor magentaColor];
    
    NSArray *items = [[NSArray arrayWithObjects:
                       [NSDictionary dictionaryWithObjectsAndKeys:@"CTCC介绍", @"title", detailController1, @"viewController", nil],
                       [NSDictionary dictionaryWithObjectsAndKeys:@"7年CTCC征程", @"title", detailController2, @"viewController", nil],
                       [NSDictionary dictionaryWithObjectsAndKeys:@"夺冠之路", @"title", detailController3, @"viewController", nil],
                       [NSDictionary dictionaryWithObjectsAndKeys:@"四大车手", @"title", detailController4, @"viewController", nil],
                       [NSDictionary dictionaryWithObjectsAndKeys:@"精彩视频", @"title", detailController5, @"viewController", nil],
                       [NSDictionary dictionaryWithObjectsAndKeys:@"图片欣赏", @"title", detailController6, @"viewController", nil],
                       nil] retain];
    
    if (self = [super initWithMenuBarItems:items alignment:UITextAlignmentLeft referenceX:240])
    {
        
    }
    [items release];
    return self;
}

- (void)dealloc
{
    [super dealloc];
}

@end
