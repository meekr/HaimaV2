//
//  CustomTabBar.h
//  Haima
//
//  Created by Lei Perry on 4/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

@class CustomTabBar;
@protocol CustomTabBarDelegate

- (UIImage *)imageFor:(CustomTabBar *)tabBar atIndex:(NSUInteger)itemIndex;
- (UIImage *)highlightImageFor:(CustomTabBar *)tabBar atIndex:(NSUInteger)itemIndex;

@optional
- (void)touchUpInsideItemAtIndex:(NSUInteger)itemIndex;
- (void)touchDownAtItemAtIndex:(NSUInteger)itemIndex;
@end


@interface CustomTabBar : UIView
{
    NSObject <CustomTabBarDelegate> *delegate;
}

@property (nonatomic, retain) NSMutableArray* buttons;

- (id)initWithItemCount:(NSUInteger)itemCount itemSize:(CGSize)itemSize tag:(NSInteger)objectTag delegate:(NSObject <CustomTabBarDelegate>*)customTabBarDelegate;

- (void)selectItemAtIndex:(NSInteger)index;

@end