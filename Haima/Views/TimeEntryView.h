//
//  TimeEntryView.h
//  Haima
//
//  Created by Lei Perry on 4/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//


@interface TimeEntryView : UIView
{
    UIImageView *imageView;
    UILabel *labelView;
}

@property (nonatomic, retain) UIImage *image;
@property (nonatomic, retain) NSString *text;

@end