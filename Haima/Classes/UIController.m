//
//  UIController.m
//  Haima
//
//  Created by Lei Perry on 4/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "UIController.h"
#import "SynthesizeSingleton.h"
#import "Constants.h"

@implementation UIController

SYNTHESIZE_SINGLETON_FOR_CLASS(UIController);


- (void)showBackgroundImage {
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    UIView *view = [window viewWithTag:APP_BACKGROUND_VIEW_TAG];
    if (view)
        view.alpha = 1;
    
    UIView *v = [window viewWithTag:APP_UNITY_VIEW_TAG];
    if (v) {
        v.exclusiveTouch = NO;
        v.multipleTouchEnabled = NO;
        v.hidden = YES;
    }
}

- (void)hideBackgroundImage {
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    UIView *view = [window viewWithTag:APP_BACKGROUND_VIEW_TAG];
    if (view)
        view.alpha = 0;
    
    UIView *v = [window viewWithTag:APP_UNITY_VIEW_TAG];
    if (v) {
        v.exclusiveTouch = YES;
        v.multipleTouchEnabled = YES;
        v.hidden = NO;
    }
}

@end