//
//  MenuBarViewController.h
//  Haima
//
//  Created by Lei Perry on 4/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MenuBar.h"

@interface MenuBarViewController : UIViewController<MenuBarDelegate>
{
    
}

@property (nonatomic, retain) MenuBar *menuBar;
@property (nonatomic, retain) NSArray *menuBarItems;

- (id)initWithMenuBarItems:(NSArray *)items alignment:(UITextAlignment)alignment referenceX:(NSUInteger)referenceX;

@end
