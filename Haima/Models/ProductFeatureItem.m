//
//  ProductFeatureItem.m
//  Haima
//
//  Created by Lei Perry on 4/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ProductFeatureItem.h"

@implementation ProductFeatureItem

@synthesize name = _name;
@synthesize description = _description;
@synthesize spotId = _spotId;

- (void)dealloc
{
    [_name release];
    [_description release];
    [super dealloc];
}

@end