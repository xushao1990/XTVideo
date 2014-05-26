//
//  XTVideoPlayer.h
//  XTVideoPlayer
//
//  Created by tage on 14-5-20.
//  Copyright (c) 2014年 NULL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XTVideoPlayerView.h"
#import "XTVideoModel.h"

@class XTVideoPlayer;

@protocol XTVideoPlayerDelegate <NSObject>

- (void)videoPlayerDidSelectedNextVideo:(XTVideoPlayer *)aVideoPlayer;

- (void)videoPlayerDidSelectedBackButton:(XTVideoPlayer *)aVideoPlayer;

@end

@interface XTVideoPlayer : UIView

- (id)initWithFrame:(CGRect)frame videoModel:(XTVideoModel *)model delegate:(id <XTVideoPlayerDelegate>)delegate;

- (void)play;

- (void)playWithURL:(NSString *)url;

@end
