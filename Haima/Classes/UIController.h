//
//  UIController.h
//  Haima
//
//  Created by Lei Perry on 4/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//


@interface UIController : NSObject

+ (UIController *)sharedUIController;

- (void)showBackgroundImage;
- (void)hideBackgroundImage;

@end