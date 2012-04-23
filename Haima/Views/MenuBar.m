//
//  MenuBar.m
//  Haima
//
//  Created by Lei Perry on 4/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MenuBar.h"

#define SELECTED_MENU_ITEM_TAG 2394861

@interface MenuBar()
- (UIButton *)buttonWithTitle:(NSString *)title;
@end


@implementation MenuBar

@synthesize buttons = _buttons;

- (id)initWithItemCount:(NSUInteger)itemCount tag:(NSInteger)objectTag delegate:(NSObject<MenuBarDelegate> *)menuBarDelegate alignment:(UITextAlignment)alignment referenceX:(NSUInteger)referenceX
{
    if (self = [super init])
    {
        // The tag allows callers withe multiple controls to distinguish between them
//        self.tag = objectTag;
        
        // Set the delegate
        delegate = menuBarDelegate;
        
        // Add the background image
        UIView *backgroundView = [[[UIView alloc] initWithFrame:self.bounds] autorelease];
        backgroundView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        backgroundView.backgroundColor = [UIColor colorWithHue:213.0/255 saturation:6.0/255 brightness:68.0/255 alpha:0.54];
        [self addSubview:backgroundView];
        
        // Initalize the array we use to store our buttons
        self.buttons = [[[NSMutableArray alloc] initWithCapacity:itemCount] autorelease];
        
        int totalWidth = 0;
        // Iterate through each item
        for (NSUInteger i=0; i<itemCount; i++)
        {
            // Create a button
            UIButton* button = [self buttonWithTitle:[delegate titleAtIndex:i]];
            
            // Register for touch events
            [button addTarget:self action:@selector(touchDownAction:) forControlEvents:UIControlEventTouchDown];
            [button addTarget:self action:@selector(touchUpInsideAction:) forControlEvents:UIControlEventTouchUpInside];
            
            // Add the button to our buttons array
            [_buttons addObject:button];
            
            // Add the button as our subview
            [self addSubview:button];
            
            totalWidth += button.frame.size.width;
        }
        
        int horizontalOffset = referenceX;
        if (alignment == UITextAlignmentRight)
            horizontalOffset = referenceX - totalWidth - (buttons.count-1)*14;
        
        for (UIButton *button in _buttons) {
            button.frame = CGRectMake(horizontalOffset, button.frame.origin.y, button.frame.size.width, button.frame.size.height);
            horizontalOffset += button.frame.size.width + 14;
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
            button.tag = SELECTED_MENU_ITEM_TAG;
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
    UIButton* button = [_buttons objectAtIndex:index];    
    [self dimAllButtonsExcept:button];
}

- (UIButton *)buttonWithTitle:(NSString *)title
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:[[UIImage imageNamed:@"menu-bar-item-bg"] stretchableImageWithLeftCapWidth:5 topCapHeight:0] forState:UIControlStateNormal];
    [button setTitle:title forState:UIControlStateNormal];
    [button.titleLabel setFont:[UIFont boldSystemFontOfSize:11.5]];
    CGSize size = [title sizeWithFont:[UIFont boldSystemFontOfSize:11.5]];
    button.frame = CGRectMake(0, 1, size.width+14, 26);
    
    return button;
}

- (void)dealloc
{
    [super dealloc];
    [_buttons release];
}

@end
