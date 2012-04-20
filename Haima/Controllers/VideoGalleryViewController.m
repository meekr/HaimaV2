//
//  VideoGalleryViewController.m
//  Haima
//
//  Created by Lei Perry on 4/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "VideoGalleryViewController.h"
#import <MediaPlayer/MediaPlayer.h>


@implementation VideoGalleryViewController

- (void)loadView
{
    [super loadView];
    
    UIImageView *view = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 1024, 570)];
    view.image = [UIImage imageNamed:@"champion-video-bg"];
    [self.view addSubview:view];
    [view release];
    
    UIImage *buttonImage = [UIImage imageNamed:@"champion-video-play-button"];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(670, 55, buttonImage.size.width, buttonImage.size.height);
    [button setImage:buttonImage forState:UIControlStateNormal];
    [button addTarget:self action:@selector(playVideo1:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(670, 296, buttonImage.size.width, buttonImage.size.height);
    [button setImage:buttonImage forState:UIControlStateNormal];
    [button addTarget:self action:@selector(playVideo2:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (void)playVideo1:(UIButton *)button {
    NSString *url = [[NSBundle mainBundle]
                     pathForResource:@"2011 Tour"
                     ofType:@"mp4"];
    MPMoviePlayerController *player = [[MPMoviePlayerController alloc] 
                                       initWithContentURL:[NSURL fileURLWithPath:url]];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(movieFinishedCallback:)
                                                 name:MPMoviePlayerPlaybackDidFinishNotification
                                               object:player];
    
    player.view.backgroundColor = [UIColor clearColor];
    player.view.frame = CGRectMake(534, 17, 396, 216);
    [self.view addSubview:player.view];
    [player play];
}

- (void)playVideo2:(UIButton *)button {
    NSString *url = [[NSBundle mainBundle]
                     pathForResource:@"CTCC clip"
                     ofType:@"mp4"];
    MPMoviePlayerController *player = [[MPMoviePlayerController alloc] 
                                       initWithContentURL:[NSURL fileURLWithPath:url]];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(movieFinishedCallback:)
                                                 name:MPMoviePlayerPlaybackDidFinishNotification
                                               object:player];
    
    player.view.backgroundColor = [UIColor clearColor];
    player.view.frame = CGRectMake(534, 254, 396, 216);
    [self.view addSubview:player.view];
    [player play];
}

- (void)movieFinishedCallback:(NSNotification*)notification {
    MPMoviePlayerController *player = [notification object];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:MPMoviePlayerPlaybackDidFinishNotification
                                                  object:player];
    [player stop];
    [player.view removeFromSuperview];
    [player autorelease];
}

@end
