//
//  XTVideoPlayerView.h
//  XTVideoPlayer
//
//  Created by tage on 14-5-20.
//  Copyright (c) 2014年 NULL. All rights reserved.
//

#import <UIKit/UIKit.h>

#define URLTest1 @"http://220.181.91.29/vhot2.qqvideo.tc.qq.com/n0129n9b10s.mp4?vkey=94B15D2AECA48D1026066A6DDA3336943E49B938011D59FE8E62A23746C647EB17BBF2C298F3C8138C220FB7D31941C0F69F10F1F29EF153&br=62534&platform=0&fmt=mp4&level=0&type=mp4"

#define URLTest2 @"http://v.youku.com/player/getM3U8/vid/XNzE0Mjk3ODAw/type/flv/v.m3u8"

#define URLTest3 @"http://vr.tudou.com/v2proxy/v2.m3u8?it=192438918&st=2"


@class XTVideoPlayerView;

@protocol XTVideoPlayerViewDelegate <NSObject>

//获取到总时间
- (void)videoPlayerView:(XTVideoPlayerView *)playerView didCatchTotalTime:(NSString *)time;

//缓冲进度
- (void)videoPlayerView:(XTVideoPlayerView *)playerView bufferProgress:(float)progress;

//播放进度
- (void)videoPlayerView:(XTVideoPlayerView *)playerView playProgress:(float)progress playTime:(NSString *)time;

@end



@interface XTVideoPlayerView : UIView

@property (nonatomic, strong) AVPlayer *player;

@property (nonatomic, weak) id <XTVideoPlayerViewDelegate> delegate;

@property (nonatomic, getter = isPlaying) BOOL playing;

- (id)initWithFrame:(CGRect)frame origionVideoURL:(NSString *)videoURL videoType:(VideoType)type;

- (void)replaceCurrentItemWithVideoURL:(NSString *)videoURL videoType:(VideoType)type;

- (void)play;

- (void)pause;

- (float)currentPlayTime;

- (NSString *)_currentPlayTime;

- (float)totalPlayTime;

@end
