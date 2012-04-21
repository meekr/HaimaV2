//
//  PictureGalleryDetailViewController.h
//  Haima
//
//  Created by Lei Perry on 4/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ImageBrowserItemLayer.h"

@interface PictureGalleryDetailViewController : UIViewController<ImageBrowserItemLayerDelegate>

@property NSUInteger currentIndex;

@end