//
//  ProductAdvantageViewController.m
//  Haima
//
//  Created by Lei Perry on 4/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ProductAdvantageViewController.h"
#import "DataController.h"

@implementation ProductAdvantageViewController

@synthesize homeScreen = _homeScreen;
@synthesize featureMenu = _featureMenu;
@synthesize featureDetail = _featureDetail;

- (void)loadView
{
    UIView *view = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.view = view;
    [view release];
    
    UIImage *bgImage = [UIImage imageNamed:@"bg-brand-history"];
    UIImageView *bg = [[UIImageView alloc] initWithImage:bgImage];
    bg.frame = CGRectMake(0, 40, bgImage.size.width, bgImage.size.height);
    bg.alpha = 0.08;
    [self.view addSubview:bg];
    [bg release];

    // navigate home
    bgImage = [UIImage imageNamed:@"product-navigate-bg"];
    self.homeScreen = [[[UIView alloc] initWithFrame:CGRectMake(240, 170, bgImage.size.width, bgImage.size.height)] autorelease];
    [self.view addSubview:self.homeScreen];
    
    UIImageView *homeBg = [[UIImageView alloc] initWithImage:bgImage];
    [self.homeScreen addSubview:homeBg];
    [homeBg release];
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(50, 12, 265, 163)];
    button.backgroundColor = [UIColor clearColor];
    [button setBackgroundImage:[UIImage imageNamed:@"product-navigate-button-manifest"] forState:UIControlStateNormal];
    [button setShowsTouchWhenHighlighted:YES];
    [button addTarget:self action:@selector(button1Action:) forControlEvents:UIControlEventTouchUpInside];
    [self.homeScreen addSubview:button];
    [button release];
    
    button = [[UIButton alloc] initWithFrame:CGRectMake(320, 12, 265, 163)];
    button.backgroundColor = [UIColor clearColor];
    [button setBackgroundImage:[UIImage imageNamed:@"product-navigate-button-control"] forState:UIControlStateNormal];
    [button setShowsTouchWhenHighlighted:YES];
    [button addTarget:self action:@selector(button2Action:) forControlEvents:UIControlEventTouchUpInside];
    [self.homeScreen addSubview:button];
    [button release];
    
    button = [[UIButton alloc] initWithFrame:CGRectMake(50, 177, 265, 163)];
    button.backgroundColor = [UIColor clearColor];
    [button setBackgroundImage:[UIImage imageNamed:@"product-navigate-button-safety"] forState:UIControlStateNormal];
    [button setShowsTouchWhenHighlighted:YES];
    [button addTarget:self action:@selector(button3Action:) forControlEvents:UIControlEventTouchUpInside];
    [self.homeScreen addSubview:button];
    [button release];
    
    button = [[UIButton alloc] initWithFrame:CGRectMake(320, 177, 265, 163)];
    button.backgroundColor = [UIColor clearColor];
    [button setBackgroundImage:[UIImage imageNamed:@"product-navigate-button-quality"] forState:UIControlStateNormal];
    [button setShowsTouchWhenHighlighted:YES];
    [button addTarget:self action:@selector(button4Action:) forControlEvents:UIControlEventTouchUpInside];
    [self.homeScreen addSubview:button];
    [button release];
    
    
    // feature menu
    self.featureMenu = [[[TreeMenu alloc] initWithFrame:CGRectMake(280, 170, 400, 400)] autorelease];
    self.featureMenu.alpha = 0;
    self.featureMenu.delegate = self;
    [self.view addSubview:self.featureMenu];
    
    
    // feature item detail
    self.featureDetail = [[[UIImageView alloc] initWithFrame:CGRectMake(340, 150, 500, 360)] autorelease];
    self.featureDetail.image = [[UIImage imageNamed:@"feature-detail-frame"] stretchableImageWithLeftCapWidth:240 topCapHeight:60];
    self.featureDetail.userInteractionEnabled = YES;
    self.featureDetail.alpha = 0;
    [self.view addSubview:self.featureDetail];
    
    UILabel *label = [[[UILabel alloc] initWithFrame:CGRectMake(20, 67, self.featureDetail.frame.size.width-30, self.featureDetail.frame.size.height-80)] autorelease];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont systemFontOfSize:18];
    label.textColor = [UIColor darkGrayColor];
    label.numberOfLines = 0;
    [label sizeToFit];
    [self.featureDetail addSubview:label];
    
    UIButton *closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    closeButton.frame = CGRectMake(self.featureDetail.frame.size.width - 24, -18, 44, 44);
    closeButton.showsTouchWhenHighlighted = YES;
    [closeButton setImage:[UIImage imageNamed:@"feature-detail-frame-close"] forState:UIControlStateNormal];
    [closeButton addTarget:self action:@selector(closeDetailAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.featureDetail addSubview:closeButton];
}

- (void)presentFeatureMenu
{
    [UIView animateWithDuration:.2
                          delay:0
                        options:UIViewAnimationCurveEaseInOut
                     animations:^{
                         self.homeScreen.alpha = 0;
                         self.featureMenu.alpha = 1;
                         self.featureMenu.frame = CGRectMake(0, self.featureMenu.frame.origin.y, self.featureMenu.frame.size.width, self.featureMenu.frame.size.height);
                     }
                     completion:^(BOOL finished){
                     }];
}

- (void)button1Action:(UIButton*)button
{
    ProductFeature *feature = [[DataController sharedDataController] getFeatureByIndex:0];
    self.featureMenu.feature = feature;
    [self presentFeatureMenu];
}

- (void)button2Action:(UIButton*)button
{
    ProductFeature *feature = [[DataController sharedDataController] getFeatureByIndex:1];
    self.featureMenu.feature = feature;
    [self presentFeatureMenu];
}

- (void)button3Action:(UIButton*)button
{
    ProductFeature *feature = [[DataController sharedDataController] getFeatureByIndex:2];
    self.featureMenu.feature = feature;
    [self presentFeatureMenu];
}

- (void)button4Action:(UIButton*)button
{
    ProductFeature *feature = [[DataController sharedDataController] getFeatureByIndex:3];
    self.featureMenu.feature = feature;
    [self presentFeatureMenu];
}

- (void)closeDetailAction:(UIButton*)button {
    [UIView animateWithDuration:.2
                          delay:0
                        options:UIViewAnimationCurveEaseInOut
                     animations:^{
                         self.featureDetail.alpha = 0;
                     }
                     completion:^(BOOL finished){
                     }];
}

- (void)dealloc
{
    [_homeScreen release];
    [_featureMenu release];
    [_featureDetail release];
    [super dealloc];
}


#pragma mark - TreeMenuDelegate
- (void)returnToHome
{
    [self closeDetailAction:nil];
    
    [UIView animateWithDuration:.2
                          delay:0
                        options:UIViewAnimationCurveEaseInOut
                     animations:^{
                         self.homeScreen.alpha = 1;
                         self.featureMenu.alpha = 0;
                         self.featureMenu.frame = CGRectMake(280, self.featureMenu.frame.origin.y, self.featureMenu.frame.size.width, self.featureMenu.frame.size.height);
                     }
                     completion:^(BOOL finished){
                     }];
}

- (void)showDetailForFeatureItem:(ProductFeatureItem *)featureItem
{
    UILabel *label = [self.featureDetail.subviews objectAtIndex:0];
    label.text = featureItem.description;
    label.frame = CGRectMake(20, 67, self.featureDetail.frame.size.width-30, self.featureDetail.frame.size.height-80);
    label.numberOfLines = 0;
    [label sizeToFit];
    
    if (self.featureDetail.alpha == 0) {
        [UIView animateWithDuration:.2
                              delay:0
                            options:UIViewAnimationCurveEaseInOut
                         animations:^{
                             self.featureDetail.alpha = 1;
                         }
                         completion:^(BOOL finished){
                         }];
    }
}

@end
