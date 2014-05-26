//
//  XTVideoPlayerView.m
//  XTVideoPlayer
//
//  Created by tage on 14-5-20.
//  Copyright (c) 2014年 NULL. All rights reserved.
//

#import "XTVideoPlayerView.h"

@interface XTVideoPlayerView ()

@property (nonatomic, strong) AVPlayerLayer *playerLayer;

@property (nonatomic) VideoType type;

@end

@implementation XTVideoPlayerView

- (id)initWithFrame:(CGRect)frame origionVideoURL:(NSString *)videoURL videoType:(VideoType)type
{
    if (self = [super initWithFrame:frame]) {
        self.type = type;
        [self initPlayerLayer:videoURL];
    }
    return self;
}

- (void)initPlayerLayer:(NSString *)videoURL
{
    if (_player) {
        [_player pause];
        [self currentPlayerItemRemoveKVO];
        _player = nil;
    }
    if (_playerLayer) {
        [_playerLayer removeFromSuperlayer];
        _playerLayer = nil;
    }
    _player = [AVPlayer playerWithPlayerItem:[AVPlayerItem playerItemWithURL:[NSURL URLWithString:videoURL]]];
    _playerLayer = [AVPlayerLayer playerLayerWithPlayer:_player];
    _playerLayer.frame = self.bounds;
    _playerLayer.videoGravity = AVLayerVideoGravityResizeAspect;
    [self.layer addSublayer:_playerLayer];
    [self currentPlayerItemAddKVO];
}

- (void)play
{
    [_player play];
    __weak typeof(self) weakSelf = self;
    [_player addPeriodicTimeObserverForInterval:CMTimeMake(1, 1) queue:NULL usingBlock:^(CMTime time){        
        float currentPlayTime = [weakSelf currentPlayTime];
        float progress = currentPlayTime / [weakSelf totalPlayTime];
        NSString *playTime = [weakSelf timeFormatted:(int)currentPlayTime];
        if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(videoPlayerView:playProgress:playTime:)]) {
            [weakSelf.delegate videoPlayerView:weakSelf playProgress:progress playTime:playTime];
        }
    }];
}

- (void)pause
{
    [_player pause];
}

- (void)replaceCurrentItemWithVideoURL:(NSString *)videoURL videoType:(VideoType)type
{
    if (self.type == type) {
        [_player replaceCurrentItemWithPlayerItem:[AVPlayerItem playerItemWithURL:[NSURL URLWithString:videoURL]]];
    }else{
        [self initPlayerLayer:videoURL];
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"status"])
    {
        AVPlayerItem *playerItem = (AVPlayerItem*)object;
        if (playerItem.status==AVPlayerStatusReadyToPlay) {
            NSString *time =  [self currentPlayItemTotalTime];
            if (_delegate && [_delegate respondsToSelector:@selector(videoPlayerView:didCatchTotalTime:)]) {
                [_delegate videoPlayerView:self didCatchTotalTime:time];
            }
        }
    }
    if ([keyPath isEqualToString:@"loadedTimeRanges"])
    {
        float bufferTime = [self availableDuration];
        float durationTime = CMTimeGetSeconds([self.player.currentItem duration]);
        float progress = bufferTime / durationTime;
        if (_delegate && [_delegate respondsToSelector:@selector(videoPlayerView:bufferProgress:)]) {
            [_delegate videoPlayerView:self bufferProgress:progress];
        }
    }
}

- (BOOL)isPlaying
{
    return [@(_player.rate) boolValue];
}

//获取当前时间
//转成秒数
- (float)currentPlayTime
{
    CMTime currentTime = _player.currentTime;
    return (float)currentTime.value/currentTime.timescale;
}

- (NSString *)_currentPlayTime
{
    return [self timeFormatted:[self currentPlayTime]];
}

- (float)totalPlayTime
{
    CMTime totalTime = _player.currentItem.duration;
    return (float)totalTime.value/totalTime.timescale;
}

//加载进度
- (float)availableDuration
{
    NSArray *loadedTimeRanges = [self.player.currentItem loadedTimeRanges];
    if ([loadedTimeRanges count] > 0) {
        CMTimeRange timeRange = [[loadedTimeRanges objectAtIndex:0] CMTimeRangeValue];
        float startSeconds = CMTimeGetSeconds(timeRange.start);
        float durationSeconds = CMTimeGetSeconds(timeRange.duration);
        return (startSeconds + durationSeconds);
    } else {
        return 0.0f;
    }
}

//视频总时间
- (NSString *)currentPlayItemTotalTime
{
    return [self timeFormatted:[self totalPlayTime]];
}

//将秒数换算成展示用的Text

- (NSString *)timeFormatted:(int)totalSeconds
{
    int seconds = totalSeconds % 60;
    int minutes = (totalSeconds / 60) % 60;
    int hours = totalSeconds / 3600;
    if (hours > 0) {
        return [NSString stringWithFormat:@"%02d:%02d:%02d",hours, minutes, seconds];
    }else{
        return [NSString stringWithFormat:@"%02d:%02d", minutes, seconds];
    }
}

- (void)currentPlayerItemRemoveKVO
{
    if (_player && _player.currentItem) {
        
        [_player.currentItem removeObserver:self
                                            forKeyPath:@"status"
                                               context:nil];
        [_player.currentItem removeObserver:self
                                            forKeyPath:@"loadedTimeRanges"
                                               context:nil];
    }
}

- (void)currentPlayerItemAddKVO
{
    if (_player && _player.currentItem) {
        
        [_player.currentItem addObserver:self
                                         forKeyPath:@"status"
                                            options:NSKeyValueObservingOptionNew
                                            context:nil];
        [_player.currentItem  addObserver:self
                                          forKeyPath:@"loadedTimeRanges"
                                             options:NSKeyValueObservingOptionNew
                                             context:nil];
    }
}

- (void)dealloc
{
    DLog();
}

@end
