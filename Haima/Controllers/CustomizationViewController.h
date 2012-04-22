//
//  CustomizationViewController.h
//  Haima
//
//  Created by Lei Perry on 4/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TKCoverflowView.h"
#import "TKCoverflowCoverView.h"

@interface CustomizationViewController : UIViewController<TKCoverflowViewDelegate,TKCoverflowViewDataSource>
{
    UITapGestureRecognizer *_tapGesture;
    UIImageView *_previewImageView;
}

@property (retain,nonatomic) TKCoverflowView *coverflow; 
@property (retain,nonatomic) NSMutableArray *covers;

@end