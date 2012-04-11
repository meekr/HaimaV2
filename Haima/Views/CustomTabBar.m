//
//  CustomTabBar.m
//  Haima
//
//  Created by Lei Perry on 4/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CustomTabBar.h"

#define SELECTED_ITEM_TAG 2394860
#define TAB_BAR_HORIZONTAL_OFFSET 130

@interface CustomTabBar()
- (UIButton *)buttonAtIndex:(NSUInteger)itemIndex width:(CGFloat)width;
@end

@implementation CustomTabBar
@synthesize buttons = _buttons;

- (id)initWithItemCount:(NSUInteger)itemCount itemSize:(CGSize)itemSize tag:(NSInteger)objectTag delegate:(NSObject <CustomTabBarDelegate>*)customTabBarDelegate
{
    if (self = [super init])
    {
        // The tag allows callers withe multiple controls to distinguish between them
        self.tag = objectTag;
        
        // Set the delegate
        delegate = customTabBarDelegate;
        
        // Add the background image
        UIView *backgroundView = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, 1024, 78)] autorelease];
        backgroundView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"tab-bar-background"]];
        [self addSubview:backgroundView];
        
        self.frame = CGRectMake(0, 0, 1024, 768);
        
        // Initalize the array we use to store our buttons
        self.buttons = [[[NSMutableArray alloc] initWithCapacity:itemCount] autorelease];
        
        // horizontalOffset tracks the proper x value as we add buttons as subviews
        CGFloat horizontalOffset = TAB_BAR_HORIZONTAL_OFFSET;
        
        // Iterate through each item
        for (NSUInteger i=0; i<itemCount; i++)
        {
            // Create a button
            UIButton* button = [self buttonAtIndex:i width:itemSize.width];
            
            // Register for touch events
            [button addTarget:self action:@selector(touchDownAction:) forControlEvents:UIControlEventTouchDown];
            [button addTarget:self action:@selector(touchUpInsideAction:) forControlEvents:UIControlEventTouchUpInside];
            
            // Add the button to our buttons array
            [_buttons addObject:button];
            
            // Set the button's x offset
            button.frame = CGRectMake(horizontalOffset, 7, button.frame.size.width, button.frame.size.height);
            
            // Add the button as our subview
            [self addSubview:button];
            
            // Advance the horizontal offset
            horizontalOffset = horizontalOffset + itemSize.width + 16;
        }
    }
    
    return self;
}

- (void)dimAllButtonsExcept:(UIButton*)selectedButton
{
    for (UIButton* button in _buttons)
    {
        if (button == selectedButton)
        {
            button.selected = YES;
            button.highlighted = button.selected ? NO : YES;
            button.tag = SELECTED_ITEM_TAG;
            
//            NSUInteger selectedIndex = [buttons indexOfObjectIdenticalTo:button];
        }
        else
        {
            button.selected = NO;
            button.highlighted = NO;
            button.tag = 0;
        }
    }
}

- (void)touchDownAction:(UIButton*)button
{
    [self dimAllButtonsExcept:button];
    
    if ([delegate respondsToSelector:@selector(touchDownAtItemAtIndex:)])
        [delegate touchDownAtItemAtIndex:[_buttons indexOfObject:button]];
}

- (void)touchUpInsideAction:(UIButton*)button
{
    [self dimAllButtonsExcept:button];
    
    if ([delegate respondsToSelector:@selector(touchUpInsideItemAtIndex:)])
        [delegate touchUpInsideItemAtIndex:[_buttons indexOfObject:button]];
}

- (void)selectItemAtIndex:(NSInteger)index
{
    // Get the right button to select
    UIButton* button = [_buttons objectAtIndex:index];
    
    [self dimAllButtonsExcept:button];
}

// Create a button at the provided index
- (UIButton *)buttonAtIndex:(NSUInteger)itemIndex width:(CGFloat)width
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0.0, 0.0, width, 70);
    UIImage *rawButtonImage = [delegate imageFor:self atIndex:itemIndex];
    UIImage *selButtonImage = [delegate highlightImageFor:self atIndex:itemIndex];
    [button setImage:rawButtonImage forState:UIControlStateNormal];
    [button setImage:selButtonImage forState:UIControlStateHighlighted];
    [button setImage:selButtonImage forState:UIControlStateSelected];
    return button;
}

- (void)dealloc
{
    [super dealloc];
    [_buttons release];
}


@end