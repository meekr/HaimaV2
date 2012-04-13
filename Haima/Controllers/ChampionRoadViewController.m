//
//  ChampionRoadViewController.m
//  Haima
//
//  Created by Lei Perry on 4/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ChampionRoadViewController.h"

@implementation ChampionRoadViewController

- (void)loadView
{
    UIImageView *view = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 1024, 690)];
    view.image = [UIImage imageNamed:@"champion-road"];
    self.view = view;
    [view release];
}

@end