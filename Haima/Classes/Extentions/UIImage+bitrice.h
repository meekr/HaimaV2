//
//  UIImage+bitrice.h
//  Haima
//
//  Created by Lei Perry on 4/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//


@interface UIImage (bitrice)

+ (UIImage*)imageByCropping:(UIImage *)imageToCrop toRect:(CGRect)rect;

- (UIImage *)imageAtRect:(CGRect)rect;
- (UIImage *)imageByScalingProportionallyToMinimumSize:(CGSize)targetSize;
- (UIImage *)imageByScalingProportionallyToSize:(CGSize)targetSize;
- (UIImage *)imageByScalingToSize:(CGSize)targetSize;

@end