//
//  IntroductionViewController.m
//  Haima
//
//  Created by Lei Perry on 4/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "IntroductionViewController.h"
#import "BrandHistoryViewController.h"
#import "UserGroupViewController.h"
#import "ProductAdvantageViewController.h"
#import "UIController.h"

@implementation IntroductionViewController

- (id)init
{
    BrandHistoryViewController *vc1 = [[[BrandHistoryViewController alloc] init] autorelease];
    
    UserGroupViewController *vc2 = [[[UserGroupViewController alloc] init] autorelease];
    
    ProductAdvantageViewController *vc3 = [[[ProductAdvantageViewController alloc] init] autorelease];
    
    NSArray *items = [[NSArray arrayWithObjects:
                    [NSDictionary dictionaryWithObjectsAndKeys:@"品牌故事", @"title", vc1, @"viewController", nil],
                    [NSDictionary dictionaryWithObjectsAndKeys:@"用户群体", @"title", vc2, @"viewController", nil],
                    [NSDictionary dictionaryWithObjectsAndKeys:@"产品优势", @"title", vc3, @"viewController", nil],
                    nil] retain];
    
    if (self = [super initWithMenuBarItems:items alignment:UITextAlignmentLeft referenceX:144])
    {
        
    }
    [items release];
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self touchDownAtItemAtIndex:0];
}

- (void)dealloc
{
    [super dealloc];
}

- (void)touchDownAtItemAtIndex:(NSUInteger)itemIndex {
    if (itemIndex == 2)
        [[UIController sharedUIController] hideBackgroundImage];
    else
        [[UIController sharedUIController] showBackgroundImage];
    
    [super touchDownAtItemAtIndex:itemIndex];
}

@end
