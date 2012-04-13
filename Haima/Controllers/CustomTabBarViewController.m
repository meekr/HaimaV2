//
//  CustomTabBarViewController.m
//  Haima
//
//  Created by Lei Perry on 4/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CustomTabBarViewController.h"
#import "IntroductionViewController.h"
#import "ChampionViewController.h"
#import "CalculatorViewController.h"
#import "MaintenanceViewController.h"
#import "PkViewController.h"

#define SELECTED_VIEW_CONTROLLER_TAG 98456345

static NSArray* tabBarItems = nil;

@implementation CustomTabBarViewController

@synthesize tabBar = _tabBar;


- (id)init
{
    if ((self = [super init]))
    {
        IntroductionViewController *vc1 = [[[IntroductionViewController alloc] init] autorelease];
        
        ChampionViewController *vc2 = [[[ChampionViewController alloc] init] autorelease];
        
        PkViewController *vc3 = [[[PkViewController alloc] init] autorelease];
        
        MaintenanceViewController *vc4 = [[[MaintenanceViewController alloc] init] autorelease];
        
        UIViewController *detailController5 = [[[UIViewController alloc] init] autorelease];
        
        CalculatorViewController *vc6 = [[[CalculatorViewController alloc] init] autorelease];
        
        UIViewController *detailController7 = [[[UIViewController alloc] init] autorelease];
        
        UIViewController *detailController8 = [[[UIViewController alloc] init] autorelease];
        
        tabBarItems = [[NSArray arrayWithObjects:
                        [NSDictionary dictionaryWithObjectsAndKeys:@"tab-icon-intro", @"image", vc1, @"viewController", nil],
                        [NSDictionary dictionaryWithObjectsAndKeys:@"tab-icon-champion", @"image", vc2, @"viewController", nil],
                        [NSDictionary dictionaryWithObjectsAndKeys:@"tab-icon-pk", @"image", vc3, @"viewController", nil],
                        [NSDictionary dictionaryWithObjectsAndKeys:@"tab-icon-maintain", @"image", vc4, @"viewController", nil],
                        [NSDictionary dictionaryWithObjectsAndKeys:@"tab-icon-promo", @"image", detailController5, @"viewController", nil],
                        [NSDictionary dictionaryWithObjectsAndKeys:@"tab-icon-calculator", @"image", vc6, @"viewController", nil],
                        [NSDictionary dictionaryWithObjectsAndKeys:@"tab-icon-custom", @"image", detailController7, @"viewController", nil],
                        [NSDictionary dictionaryWithObjectsAndKeys:@"tab-icon-experience", @"image", detailController8, @"viewController", nil],
                        nil] retain];
    }
    return self;
}

- (void)loadView
{
    UIView *background = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1024, 768)];
    self.view = background;
    [background release];

    // Create a custom tab bar passing in the number of items, the size of each item and setting ourself as the delegate
    self.tabBar = [[[CustomTabBar alloc] initWithItemCount:tabBarItems.count itemSize:CGSizeMake(80, 78) tag:0 delegate:self] autorelease];
    
    // Place the tab bar at the bottom of our view
    _tabBar.frame = CGRectMake(0, self.view.frame.size.height-78, self.view.frame.size.width, 78);
    [self.view addSubview:_tabBar];
}

#pragma mark -
#pragma mark CustomTabBarDelegate

- (UIImage *)imageFor:(CustomTabBar*)tabBar atIndex:(NSUInteger)itemIndex
{
    NSDictionary* data = [tabBarItems objectAtIndex:itemIndex];
    return [UIImage imageNamed:[data objectForKey:@"image"]];
}

- (UIImage *)highlightImageFor:(CustomTabBar *)tabBar atIndex:(NSUInteger)itemIndex
{
    NSDictionary* data = [tabBarItems objectAtIndex:itemIndex];
    return [UIImage imageNamed:[NSString stringWithFormat:@"%@-selected", [data objectForKey:@"image"]]];
}

- (void)touchDownAtItemAtIndex:(NSUInteger)itemIndex
{
    // Remove the current view controller's view
    UIView* currentView = [self.view viewWithTag:SELECTED_VIEW_CONTROLLER_TAG];
    [currentView removeFromSuperview];
    
    // Get the right view controller
    NSDictionary *data = [tabBarItems objectAtIndex:itemIndex];
    UIViewController* viewController = [data objectForKey:@"viewController"];
    
    // Set the view controller's frame to account for the tab bar
    viewController.view.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height-78);
    
    // Se the tag so we can find it later
    viewController.view.tag = SELECTED_VIEW_CONTROLLER_TAG;
    
    // Add the new view controller's view
    [self.view insertSubview:viewController.view belowSubview:_tabBar];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationLandscapeLeft
            || interfaceOrientation == UIInterfaceOrientationLandscapeRight);
}

- (void)dealloc
{
    [super dealloc];
    [_tabBar release];
}

@end
