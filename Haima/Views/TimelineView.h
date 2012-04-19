//
//  TimelineView.h
//  Haima
//
//  Created by Lei Perry on 4/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

@interface TimelineView : UIView

@property (nonatomic, retain) NSArray *timelineEntries;

- (id)initWithFrame:(CGRect)frame andEntries:(NSArray *)entries;

@end