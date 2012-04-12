//
//  ProductAdvantageViewController.h
//  Haima
//
//  Created by Lei Perry on 4/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TreeMenu.h"

@interface ProductAdvantageViewController : UIViewController<TreeMenuDelegate>
{
    
}

@property (nonatomic, retain)UIView *homeScreen;
@property (nonatomic, retain)TreeMenu *featureMenu;

@end
