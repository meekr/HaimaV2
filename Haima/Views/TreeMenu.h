//
//  TreeMenu.h
//  Haima
//
//  Created by Lei Perry on 4/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "DataController.h"
#import "ProductFeature.h"
#import "ProductFeatureCategory.h"
#import "ProductFeatureItem.h"


@protocol TreeMenuDelegate

- (void)returnToHome;
- (void)showDetailForFeatureItem:(ProductFeatureItem *)featureItem;

@end

@interface TreeMenu : UIView
{
    
}

@property (nonatomic, assign) NSObject<TreeMenuDelegate> *delegate;
@property (nonatomic, retain) ProductFeature *feature;

@property (nonatomic, retain) NSMutableArray *categoryViews;
@property (nonatomic, retain) NSMutableArray *categoryItemContainers;
@property (nonatomic, retain) NSMutableArray *itemViews;

@end