//
//  ProductFeature.m
//  Haima
//
//  Created by Lei Perry on 4/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ProductFeature.h"

@implementation ProductFeature

@synthesize name = _name;
@synthesize description = _description;
@synthesize categories = _categories;
@synthesize items = _items;

- (void)dealloc
{
    [_name release];
    [_description release];
    [_categories release];
    [_items release];
    [super dealloc];
}

@end