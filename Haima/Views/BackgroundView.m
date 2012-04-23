//
//  BackgroundView.m
//  Unity-iPhone
//
//  Created by Lei Perry on 4/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "BackgroundView.h"

@implementation BackgroundView

- (UIView *)unityView {
    if (_unityView == nil) {
        UIWindow *window = [[UIApplication sharedApplication] keyWindow];
        for (UIView *view in window.subviews) {
            if (view.tag == 1) {
                _unityView = view;
                break;
            }
        }
    }
    return _unityView;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    
    [self.unityView touchesBegan:touches withEvent:event];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesMoved:touches withEvent:event];
    
    [self.unityView touchesMoved:touches withEvent:event];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesEnded:touches withEvent:event];
    
    [self.unityView touchesEnded:touches withEvent:event];
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesCancelled:touches withEvent:event];
    
    [self.unityView touchesCancelled:touches withEvent:event];
}

@end