//
//  TreeMenu.m
//  Haima
//
//  Created by Lei Perry on 4/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TreeMenu.h"

#define TAG_TITLE 201
#define TAG_RETURN_BUTTON 202

@implementation TreeMenu

@synthesize feature = _feature;
@synthesize categoryViews = _categoryViews;
@synthesize categoryItemContainers = _categoryItemContainers;
@synthesize itemViews = _itemViews;
@synthesize delegate;

- (void)setup
{
    self.categoryViews = [NSMutableArray array];
    self.categoryItemContainers = [NSMutableArray array];
    self.itemViews = [NSMutableArray array];
    
    UIImage *bgImage = [UIImage imageNamed:@"category-tree-bg"];
    UIImageView *bgView = [[UIImageView alloc] initWithImage:bgImage];
    bgView.frame = CGRectMake(0, 0, bgImage.size.width, bgImage.size.height);
    [self addSubview:bgView];
    [bgView release];
    
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(52, 13, 200, 30)];
    title.tag = TAG_TITLE;
    title.backgroundColor = [UIColor clearColor];
    title.font = [UIFont systemFontOfSize:28];
    title.textColor = [UIColor colorWithRed:146.0/255 green:165.0/255 blue:202.0/255 alpha:1];
    [self addSubview:title];
    [title release];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(29, 345, 44, 44);
    button.tag = TAG_RETURN_BUTTON;
    [button setBackgroundImage:[UIImage imageNamed:@"return-button"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(returnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:button];
}

- (void)setFeature:(ProductFeature *)feature
{
    if (_feature != feature)
    {
        /*
         * clear previous
         */
        [_feature release];
        
        for (UIView *category in _categoryViews) {
            [category removeFromSuperview];
        }
        for (UIView *itemContainer in _categoryItemContainers) {
            [itemContainer removeFromSuperview];
        }
        for (UIView *item in _itemViews) {
            [item removeFromSuperview];
        }
        [_categoryViews removeAllObjects];
        [_categoryItemContainers removeAllObjects];
        [_itemViews removeAllObjects];
        
        /*
         * create new
         */
        _feature = [feature retain];
        
        CGFloat yOffset = 0;
        for (ProductFeatureCategory *category in feature.categories) {
            // category
            UIButton *cateButton = [UIButton buttonWithType:UIButtonTypeCustom];
            UIImage *cateButtonImage = [UIImage imageNamed:@"category-button-bg"];
            [cateButton setBackgroundImage:cateButtonImage forState:UIControlStateNormal];
            [cateButton addTarget:self action:@selector(toggleCategoryAction:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:cateButton];
            cateButton.frame = CGRectMake(0, 0, cateButtonImage.size.width, cateButtonImage.size.height);
            UILabel *catelabel = [[[UILabel alloc] initWithFrame:CGRectMake(20, 0, cateButton.frame.size.width-22, cateButton.frame.size.height)] autorelease];
            catelabel.backgroundColor = [UIColor clearColor];
            catelabel.text = category.name;
            catelabel.textColor = [UIColor darkTextColor];
            catelabel.font = [UIFont boldSystemFontOfSize:15];
            [cateButton addSubview:catelabel];
            [_categoryViews addObject:cateButton];
            
            UIView *itemContainer = [[[UIView alloc] init] autorelease];
            [self addSubview:itemContainer];
            itemContainer.frame = CGRectMake(50, 0, 300, 0);
            itemContainer.clipsToBounds = YES;
            [_categoryItemContainers addObject:itemContainer];
            
            // item
            yOffset = 0;
            for (ProductFeatureItem *fi in category.items) {
                UIButton *itemButton = [UIButton buttonWithType:UIButtonTypeCustom];
                [itemButton setBackgroundImage:[UIImage imageNamed:@"category-tree-fork"] forState:UIControlStateNormal];
                [itemButton addTarget:self action:@selector(featureItemAction:) forControlEvents:UIControlEventTouchUpInside];
                itemButton.frame = CGRectMake(0, yOffset, itemContainer.frame.size.width, 30);
                [itemContainer addSubview:itemButton];
                
                UILabel *itemView = [[[UILabel alloc] init] autorelease];
                itemView.backgroundColor = [UIColor clearColor];
                itemView.text = fi.name;
                itemView.frame = CGRectMake(16, -2, itemContainer.frame.size.width, 30);
                [itemButton addSubview:itemView];
                yOffset += 30;
            }
        }
        
        // direct feature items
        yOffset = 90;
        for (ProductFeatureItem *fi in feature.items) {
            UIButton *itemButton = [UIButton buttonWithType:UIButtonTypeCustom];
            [itemButton setBackgroundImage:[UIImage imageNamed:@"category-tree-fork"] forState:UIControlStateNormal];
            [itemButton addTarget:self action:@selector(featureItemAction:) forControlEvents:UIControlEventTouchUpInside];
            itemButton.frame = CGRectMake(50, yOffset, 300, 30);
            [self addSubview:itemButton];
            [_itemViews addObject:itemButton];
            
            UILabel *itemView = [[[UILabel alloc] init] autorelease];
            itemView.backgroundColor = [UIColor clearColor];
            itemView.text = fi.name;
            itemView.frame = CGRectMake(16, -2, itemButton.frame.size.width-16, 30);
            [itemButton addSubview:itemView];
            yOffset += 30;
//            
//            
//            UILabel *itemView = [[[UILabel alloc] init] autorelease];
//            itemView.backgroundColor = [UIColor clearColor];
//            itemView.text = fi.name;
//            itemView.frame = CGRectMake(50, yOffset, 200, 20);
//            [self addSubview:itemView];
//            [_itemViews addObject:itemView];
//            yOffset += 30;
        }
        [self setNeedsLayout];
        
        
        // update UI
        UILabel *title = (UILabel *)[self viewWithTag:TAG_TITLE];
        title.text = feature.name;
    }
}

- (id)init
{
    if (self = [super init])
    {
        [self setup];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self setup];
    }
    return self;
}

- (void)returnAction:(UIButton*)button
{
    [delegate returnToHome];
}

- (void)toggleCategoryAction:(UIButton*)button
{
    int index = [_categoryViews indexOfObject:button];
    UIView *itemContainer = [_categoryItemContainers objectAtIndex:index];
    int targetH = (itemContainer.frame.size.height==0 ? [[[_feature.categories objectAtIndex:index] items] count] * 30 : 0);
    [UIView animateWithDuration:.2
                          delay:0
                        options:UIViewAnimationCurveEaseInOut
                     animations:^{
                         itemContainer.frame = CGRectMake(itemContainer.frame.origin.x,
                                                          itemContainer.frame.origin.y,
                                                          itemContainer.frame.size.width,
                                                          targetH);
                     }
                     completion:^(BOOL finished){
                     }];
    
    // collapse other categories
    if (targetH > 0) {
        for (int i=0; i<_categoryItemContainers.count; i++) {
            if (i==index) continue;
            itemContainer = [_categoryItemContainers objectAtIndex:i];
            [UIView animateWithDuration:.2
                                  delay:0
                                options:UIViewAnimationCurveEaseInOut
                             animations:^{
                                 itemContainer.frame = CGRectMake(itemContainer.frame.origin.x,
                                                                  itemContainer.frame.origin.y,
                                                                  itemContainer.frame.size.width,
                                                                  0);
                             }
                             completion:^(BOOL finished){
                             }];
        }
    }
}

- (void)featureItemAction:(UIButton*)button
{
    UIView *itemContainer = [button superview];
    int cateIndex = [_categoryItemContainers indexOfObject:itemContainer];
    ProductFeatureItem *item;
    if (cateIndex >= 0 && cateIndex < _categoryItemContainers.count) {
        int itemIndex = [itemContainer.subviews indexOfObject:button];
        ProductFeatureCategory *category = [_feature.categories objectAtIndex:cateIndex];
        item = [category.items objectAtIndex:itemIndex];
    }
    else {
        int itemIndex = [_itemViews indexOfObject:button];
        item = [_feature.items objectAtIndex:itemIndex];
    }
    [delegate showDetailForFeatureItem:item];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat yOffset = 65;
    for (int i=0; i<_categoryViews.count; i++) {
        UIView *categoryView = [_categoryViews objectAtIndex:i];
        categoryView.frame = CGRectMake(30, yOffset, categoryView.frame.size.width, categoryView.frame.size.height);
        
        yOffset += 40;
        UIView *itemContainer = [_categoryItemContainers objectAtIndex:i];
        itemContainer.frame = CGRectMake(itemContainer.frame.origin.x, yOffset, itemContainer.frame.size.width, itemContainer.frame.size.height);
        yOffset += itemContainer.frame.size.height;
    }
    
//    UIButton *backButton = (UIButton *)[self viewWithTag:TAG_RETURN_BUTTON];
//    CGFloat y = fmaxf(backButton.frame.origin.y, 345);
//    backButton.frame = CGRectMake(backButton.frame.origin.x, y, backButton.frame.size.width, backButton.frame.size.height);
}

- (void)dealloc
{
    [_feature release];
    [_categoryViews release];
    [_categoryItemContainers release];
    [_itemViews release];
    [super dealloc];
}

@end