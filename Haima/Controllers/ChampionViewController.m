//
//  ChampionViewController.m
//  Haima
//
//  Created by Lei Perry on 4/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ChampionViewController.h"
#import "ChampionRoadViewController.h"
#import "ChampionRouteViewController.h"
#import "StarDriverViewController.h"
#import "CtccIntroViewController.h"
#import "PictureGalleryViewController.h"

#define SELECTED_VIEW_CONTROLLER_TAG 234241

@interface ChampionViewController()

- (void)tabTapped:(UIButton *)button;

@end


@implementation ChampionViewController

@synthesize viewControllerItems = _viewControllerItems;

- (id)init
{
    if (self = [super init]) {
        //
        // initialize view controllers
        //
        CtccIntroViewController *vc1 = [[[CtccIntroViewController alloc] init] autorelease];
        
        ChampionRouteViewController *vc2 = [[[ChampionRouteViewController alloc] init] autorelease];
        
        ChampionRoadViewController *vc3 = [[[ChampionRoadViewController alloc] init] autorelease];
        
        StarDriverViewController *vc4 = [[[StarDriverViewController alloc] init] autorelease];
        
        UIViewController *detailController5 = [[[UIViewController alloc] init] autorelease];
        detailController5.view.backgroundColor = [UIColor yellowColor];
        
        PictureGalleryViewController *vc6Root = [[[PictureGalleryViewController alloc] init] autorelease];
        UINavigationController *vc6 = [[UINavigationController alloc] initWithRootViewController:vc6Root];
        
        self.viewControllerItems = [NSArray arrayWithObjects:
                                    [NSDictionary dictionaryWithObjectsAndKeys:
                                     @"CTCC介绍", @"title",
                                     vc1, @"viewController",
                                     NSStringFromCGRect(CGRectMake(345, 67, 90, 40)), @"frame",
                                     nil],
                                    [NSDictionary dictionaryWithObjectsAndKeys:
                                     @"7年CTCC征程", @"title",
                                     vc2, @"viewController",
                                     NSStringFromCGRect(CGRectMake(445, 67, 110, 40)), @"frame",
                                     nil],
                                    [NSDictionary dictionaryWithObjectsAndKeys:
                                     @"夺冠之路", @"title",
                                     vc3, @"viewController",
                                     NSStringFromCGRect(CGRectMake(562, 67, 74, 40)), @"frame",
                                     nil],
                                    [NSDictionary dictionaryWithObjectsAndKeys:
                                     @"四大车手", @"title",
                                     vc4, @"viewController",
                                     NSStringFromCGRect(CGRectMake(637, 67, 85, 40)), @"frame",
                                     nil],
                                    [NSDictionary dictionaryWithObjectsAndKeys:
                                     @"精彩视频", @"title",
                                     detailController5, @"viewController",
                                     NSStringFromCGRect(CGRectMake(723, 67, 80, 40)), @"frame",
                                     nil],
                                    [NSDictionary dictionaryWithObjectsAndKeys:
                                     @"图片欣赏", @"title",
                                     vc6, @"viewController",
                                     NSStringFromCGRect(CGRectMake(808, 67, 90, 40)), @"frame",
                                     nil],
                                    nil];
        
        //
        // setup ui components
        //
        int tag = 0;
        for (NSDictionary *dict in self.viewControllerItems) {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.tag = tag++;
            button.frame = CGRectFromString([dict objectForKey:@"frame"]);
//            [button setTitle:[dict objectForKey:@"title"] forState:UIControlStateNormal];
            [button setTitleColor:[UIColor darkTextColor] forState:UIControlStateNormal];
            [button.titleLabel setFont:[UIFont systemFontOfSize:15]];
            [button addTarget:self action:@selector(tabTapped:) forControlEvents:UIControlEventTouchUpInside];
            [self.view addSubview:button];
        }
    }
    return self;
}

- (void)loadView {
    UIImageView *view = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 1024, 690)];
    view.image = [UIImage imageNamed:@"champion-bg"];
    view.userInteractionEnabled = YES;
    self.view = view;
    [view release];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *button = (UIButton *)[self.view viewWithTag:0];
    [self tabTapped:button];
}

- (void)tabTapped:(UIButton *)button {
    // Remove the current view controller's view
    UIView* currentView = [self.view viewWithTag:SELECTED_VIEW_CONTROLLER_TAG];
    [currentView removeFromSuperview];
    
    // Get the right view controller
    NSDictionary *data = [self.viewControllerItems objectAtIndex:button.tag];
    UIViewController* viewController = [data objectForKey:@"viewController"];
    
    // Set the view controller's frame to account for the tab bar
    viewController.view.frame = CGRectMake(0, 120, self.view.bounds.size.width, self.view.bounds.size.height-198);
    
    // Se the tag so we can find it later
    viewController.view.tag = SELECTED_VIEW_CONTROLLER_TAG;
    
    // Add the new view controller's view
    [self.view addSubview:viewController.view];
}

- (void)dealloc
{
    [_viewControllerItems release];
    [super dealloc];
}

@end
