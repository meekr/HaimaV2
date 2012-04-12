//
//  ProductFeatureCategory.m
//  Haima
//
//  Created by Lei Perry on 4/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ProductFeatureCategory.h"

@implementation ProductFeatureCategory

@synthesize name = _name;
@synthesize items = _items;
@synthesize showItems;

- (void)dealloc
{
    [_name release];
    [_items release];
    [super dealloc];
}

@end