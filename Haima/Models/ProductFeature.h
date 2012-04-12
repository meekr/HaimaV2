//
//  ProductFeature.h
//  Haima
//
//  Created by Lei Perry on 4/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProductFeature : NSObject

@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *description;
@property (nonatomic, retain) NSArray *categories;
@property (nonatomic, retain) NSArray *items;

@end