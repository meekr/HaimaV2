//
//  TimeEntryView.m
//  Haima
//
//  Created by Lei Perry on 4/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TimeEntryView.h"
#import "UIImage+bitrice.h"


@implementation TimeEntryView

@synthesize image = _image;
@synthesize text = _text;

- (void)setup {
    imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 1024, 690)];
    [self addSubview:imageView];
    
    labelView = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 1024, 20)];
    labelView.backgroundColor = [UIColor colorWithRed:0.3 green:0.3 blue:0.3 alpha:0.7];
    labelView.font = [UIFont boldSystemFontOfSize:22];
    labelView.numberOfLines = 0;
    labelView.textColor = [UIColor whiteColor];
    [self addSubview:labelView];
}

- (id)init {
    if (self = [super init]) {
        [self setup];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setImage:(UIImage *)image {
    NSLog(@"before image size: %@", NSStringFromCGSize(image.size));
//    image = [image imageByScalingProportionallyToSize:CGSizeMake(1024, 690)];
    image = [image imageByScalingToSize:CGSizeMake(1024, 690)];
    NSLog(@"after image size: %@", NSStringFromCGSize(image.size));
    if (image != _image) {
        [_image release];
        _image = [image retain];
        imageView.image = image;
        
        imageView.frame = CGRectMake((1024-image.size.width)/2, (690-image.size.height)/2, image.size.width, image.size.height);
        NSLog(@"image frame: %@", NSStringFromCGRect(imageView.frame));
    }
}

- (void)setText:(NSString *)text {
    if (text != _text) {
        [_text release];
        _text = [text retain];
        labelView.text = text;
        
        CGSize size = [text sizeWithFont:labelView.font
                                   constrainedToSize:CGSizeMake(imageView.frame.size.width, 999)
                                       lineBreakMode:UILineBreakModeWordWrap];
        labelView.frame = CGRectMake(imageView.frame.origin.x, imageView.frame.origin.y, imageView.frame.size.width, size.height+20);
        NSLog(@"label frame: %@", NSStringFromCGRect(labelView.frame));
    }
}

- (void)dealloc {
    [_image release];
    [_text release];
    [imageView release];
    [labelView release];
    [super dealloc];
}

@end
