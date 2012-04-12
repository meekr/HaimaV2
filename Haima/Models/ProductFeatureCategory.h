//
//  ProductFeatureCategory.h
//  Haima
//
//  Created by Lei Perry on 4/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProductFeatureCategory : NSObject

@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSArray *items;
@property (nonatomic) BOOL showItems;

@end