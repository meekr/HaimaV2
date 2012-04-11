//
//  CustomTabBarViewController.h
//  Haima
//
//  Created by Lei Perry on 4/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CustomTabBar.h"

@interface CustomTabBarViewController : UIViewController<CustomTabBarDelegate>
{
}

@property (nonatomic, retain) CustomTabBar *tabBar;

@end
