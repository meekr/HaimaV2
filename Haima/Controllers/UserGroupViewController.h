//
//  UserGroupViewController.h
//  Haima
//
//  Created by Lei Perry on 4/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

@interface UserGroupViewController : UIViewController<UIScrollViewDelegate>
{
    UIScrollView *_scrollView;
    UIImageView *_detailInfo;
    
    CGSize _szDetailPanel;
    CGPoint _ptDetailStart;
    CGPoint _ptDetailEnd;
}

@end