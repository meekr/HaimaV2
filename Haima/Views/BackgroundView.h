//
//  BackgroundView.h
//  Unity-iPhone
//
//  Created by Lei Perry on 4/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

@interface BackgroundView : UIView
{
    UIView *_unityView;
}

@property (nonatomic, readonly) UIView *unityView;

@end