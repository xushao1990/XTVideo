//
//  XTVideoPlayerToolView.h
//  XTVideoPlayer
//
//  Created by tage on 14-5-21.
//  Copyright (c) 2014年 NULL. All rights reserved.
//

#import <UIKit/UIKit.h>


@class XTVideoPlayerToolView;

@protocol XTVideoPlayerToolViewDelegate <NSObject>

- (void)videoPlayerToolViewDidSelectedNextVideo:(XTVideoPlayerToolView *)videoPlayerToolView;

- (void)videoPlayerToolViewDidSelectedPreviousVideo:(XTVideoPlayerToolView *)videoPlayerToolView;

- (void)videoPlayerToolViewDidSelectedStopVideo:(XTVideoPlayerToolView *)videoPlayerToolView button:(UIButton *)sender;

- (void)videoPlayerToolViewDidSelectedVideoQuality:(XTVideoPlayerToolView *)videoPlayerToolView;

- (void)videoPlayerToolViewDidSelectedVideoVoice:(XTVideoPlayerToolView *)videoPlayerToolView button:(UIButton *)sender;

@end

@interface XTVideoPlayerToolView : UIView

@property (nonatomic, weak) id <XTVideoPlayerToolViewDelegate> delegate;

@end
