//
//  MenuBar.h
//  Haima
//
//  Created by Lei Perry on 4/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

@class MenuBar;
@protocol MenuBarDelegate

- (NSString *)titleAtIndex:(NSUInteger)itemIndex;

@optional
- (void)touchUpInsideItemAtIndex:(NSUInteger)itemIndex;
- (void)touchDownAtItemAtIndex:(NSUInteger)itemIndex;
@end


@interface MenuBar : UIView
{
    NSObject <MenuBarDelegate> *delegate;
    NSMutableArray* buttons;
}

@property (nonatomic, retain) NSMutableArray* buttons;

- (id)initWithItemCount:(NSUInteger)itemCount tag:(NSInteger)objectTag delegate:(NSObject <MenuBarDelegate>*)menuBarDelegate alignment:(UITextAlignment)alignment referenceX:(NSUInteger)referenceX;

- (void)selectItemAtIndex:(NSInteger)index;

@end