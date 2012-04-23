//
//  MenuBarViewController.m
//  Haima
//
//  Created by Lei Perry on 4/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MenuBarViewController.h"

#define SELECTED_MENU_VIEW_CONTROLLER_TAG 98456346

@implementation MenuBarViewController

@synthesize menuBar = _menuBar;
@synthesize menuBarItems = _menuBarItems;

- (id)initWithMenuBarItems:(NSArray *)items alignment:(UITextAlignment)alignment referenceX:(NSUInteger)referenceX
{
    if (self = [super init])
    {
        self.menuBarItems = items;
        self.menuBar = [[[MenuBar alloc] initWithItemCount:[items count] tag:1324 delegate:self alignment:alignment referenceX:referenceX] autorelease];
    }
    return self;
}

- (void)loadView
{
    UIView *background = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1024, 690)];
    self.view = background;
    [background release];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _menuBar.frame = CGRectMake(0, self.view.frame.size.height-26, self.view.frame.size.width, 26);
    [self.view addSubview:_menuBar];
}

#pragma mark -
#pragma mark MenuBarDelegate

- (NSString *)titleAtIndex:(NSUInteger)itemIndex;
{
    // Get the right data
    NSDictionary* data = [_menuBarItems objectAtIndex:itemIndex];
    // Return the image for this tab bar item
    return [data objectForKey:@"title"];
}

- (void)touchDownAtItemAtIndex:(NSUInteger)itemIndex
{
    // Remove the current view controller's view
    UIView* currentView = [self.view viewWithTag:SELECTED_MENU_VIEW_CONTROLLER_TAG];
    [currentView removeFromSuperview];
    
    // Get the right view controller
    NSDictionary *data = [_menuBarItems objectAtIndex:itemIndex];
    UIViewController* viewController = [data objectForKey:@"viewController"];
    
    // Set the view controller's frame to account for the tab bar
    viewController.view.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
    
    // Se the tag so we can find it later
    viewController.view.tag = SELECTED_MENU_VIEW_CONTROLLER_TAG;
    
    // Add the new view controller's view
    [self.view insertSubview:viewController.view belowSubview:_menuBar];
}

- (void)dealloc
{
    [super dealloc];
    [_menuBar release];
    [_menuBarItems release];
}

@end