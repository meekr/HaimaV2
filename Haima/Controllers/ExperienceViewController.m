//
//  ExperienceViewController.m
//  Haima
//
//  Created by Lei Perry on 4/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ExperienceViewController.h"

@implementation ExperienceViewController

- (id)init
{
    UIViewController *vc1 = [[[UIViewController alloc] init] autorelease];
    
    UIViewController *vc2 = [[[UIViewController alloc] init] autorelease];
    
    UIViewController *vc3 = [[[UIViewController alloc] init] autorelease];
    
    UIViewController *vc4 = [[[UIViewController alloc] init] autorelease];
    
    UIViewController *vc5 = [[[UIViewController alloc] init] autorelease];
    
    NSArray *items = [[NSArray arrayWithObjects:
                       [NSDictionary dictionaryWithObjectsAndKeys:@"进入互动", @"title", vc1, @"viewController", nil],
                       [NSDictionary dictionaryWithObjectsAndKeys:@"同级车对比", @"title", vc2, @"viewController", nil],
                       [NSDictionary dictionaryWithObjectsAndKeys:@"精彩视频", @"title", vc3, @"viewController", nil],
                       [NSDictionary dictionaryWithObjectsAndKeys:@"车身X射线", @"title", vc4, @"viewController", nil],
                       [NSDictionary dictionaryWithObjectsAndKeys:@"了解更多", @"title", vc5, @"viewController", nil],
                       nil] retain];
    
    if (self = [super initWithMenuBarItems:items alignment:UITextAlignmentRight referenceX:797])
    {
        
    }
    [items release];
    return self;
}

- (void)loadView {
    [super loadView];
    
    for (int i=1; i<=5; i++) {
        UIButton *button = [[UIButton alloc] init];
        button.frame = CGRectMake(933, 650-i*80, 56, 80);
        button.tag = i;
        [button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"btn-%d", i]] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"btn-%d-over", i]] forState:UIControlStateHighlighted];
        [button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"btn-%d-over", i]] forState:UIControlStateSelected];
        [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
        [button release];
    }
}

- (void)buttonClicked:(UIButton *)button {
    button.selected = YES;
    for (int i=1; i<=5; i++) {
        if (i != button.tag){
            UIButton *btn = (UIButton *)[self.view viewWithTag:i];
            btn.selected = NO;
        }
    }
    NSLog(@"click %d", button.tag);
}

- (void)dealloc
{
    [super dealloc];
}

@end