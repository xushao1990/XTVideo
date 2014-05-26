//
//  XTVideoPlayer.m
//  XTVideoPlayer
//
//  Created by tage on 14-5-20.
//  Copyright (c) 2014年 NULL. All rights reserved.
//

#import "XTVideoPlayer.h"
#import "XTVideoPlayerToolView.h"
#import "NYSliderPopover.h"

@interface XTVideoPlayer ()<XTVideoPlayerToolViewDelegate,XTVideoPlayerViewDelegate>

@property (nonatomic, strong) XTVideoModel *currentVidelModel;
@property (nonatomic, weak) id <XTVideoPlayerDelegate> delegate;
@property (nonatomic, strong) NSString *currentVideoURL;
@property (nonatomic, strong) XTVideoPlayerView *playerView;
@property (nonatomic, strong) NYSliderPopover *slider;
@property (nonatomic, strong) UIProgressView *progressView;
@property (nonatomic, strong) UIButton *nextVideo;
@property (nonatomic, strong) UIButton *previousVideo;
@property (nonatomic, strong) UIButton *stopCurrent;
@property (nonatomic, strong) UILabel *totalTimeLabel;
@property (nonatomic, strong) UILabel *currentTimeLabel;
@property (nonatomic, strong) AVPlayerItem *currentPlayerItem;
@property (nonatomic, strong) UISlider *voiceSlider;
@property (nonatomic, strong) UIButton *backButton;

@end

@implementation XTVideoPlayer

- (id)initWithFrame:(CGRect)frame
{
    return nil;
}

- (id)initWithFrame:(CGRect)frame videoModel:(XTVideoModel *)model delegate:(id <XTVideoPlayerDelegate>)delegate
{
    self = [super initWithFrame:frame];
    if (self) {
//        AVAudioSession *session = [AVAudioSession sharedInstance];
//        
//        [[NSNotificationCenter defaultCenter] addObserver: self
//                                                 selector: @selector(handleRouteChange:)
//                                                     name: AVAudioSessionRouteChangeNotification
//                                                   object: session];
//        [[NSNotificationCenter defaultCenter] addObserver: self
//                                                 selector: @selector(handleInterruption:)
//                                                     name: AVAudioSessionInterruptionNotification
//                                                   object: session];
//        [[NSNotificationCenter defaultCenter] addObserver: self
//                                                 selector: @selector(handleMediaServicesWereReset:)
//                                                     name: AVAudioSessionMediaServicesWereResetNotification
//                                                   object: session];
        
        self.backgroundColor = [UIColor blackColor];
        
        self.currentVidelModel = model;
        
        self.currentVideoURL = model.normalQualityURL;
        
        self.delegate = delegate;
        
        [self addBasicView];
        
        [self addHardKeyVolumeListener];

    }
    return self;
}

- (void)addBasicView
{
    _playerView = [[XTVideoPlayerView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame)) origionVideoURL:_currentVideoURL videoType:VideoTypeUnSupportHLS];
    _playerView.delegate = self;
    [self addSubview:_playerView];
    
    NSArray *nibs = [[NSBundle mainBundle]loadNibNamed:@"XTVideoPlayerToolView"owner:self options:nil];
    XTVideoPlayerToolView *toolView = nibs[0];
    toolView.delegate = self;
    [toolView setCenter:CGPointMake(CGRectGetWidth(self.bounds) / 2, CGRectGetHeight(self.bounds) - 50)];
    [self addSubview:toolView];

    UIImage *thumbImage = [UIImage imageNamed:@"slider-metal-handle.png"];

    _slider = [[NYSliderPopover alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.bounds) - 100, 30)];
    [_slider addTarget:self action:@selector(sliderValueChangedBegin:) forControlEvents:UIControlEventTouchDown];
    [_slider addTarget:self action:@selector(sliderValueChanged:) forControlEvents:UIControlEventValueChanged];
    [_slider addTarget:self action:@selector(sliderValueChangedEnd:) forControlEvents:(UIControlEventTouchUpInside | UIControlEventTouchCancel)];
    [_slider setCenter:CGPointMake(CGRectGetWidth(self.bounds) / 2, CGRectGetHeight(self.bounds) - 15)];
    [_slider setThumbImage:thumbImage forState:UIControlStateHighlighted];
    [_slider setThumbImage:thumbImage forState:UIControlStateNormal];
    [_slider setMinimumTrackTintColor:[UIColor whiteColor]];
    [self addSubview:_slider];
    
    _progressView = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
    _progressView.frame = CGRectMake(CGRectGetMinX(_slider.frame) + 5, CGRectGetMinY(_slider.frame), CGRectGetWidth(_slider.frame) - 10, CGRectGetHeight(_slider.frame));
    _progressView.progressTintColor = [UIColor whiteColor];
    _progressView.trackTintColor = [UIColor clearColor];
    _progressView.center = CGPointMake(_progressView.center.x, _progressView.center.y + 14);
    [self addSubview:_progressView];
    
    _totalTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_slider.frame), CGRectGetMinY(_slider.frame), 50, 30)];
    _totalTimeLabel.font = [UIFont systemFontOfSize:11];
    _totalTimeLabel.textColor = [UIColor whiteColor];
    _totalTimeLabel.backgroundColor = [UIColor clearColor];
    [self addSubview:_totalTimeLabel];
    
    _currentTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(_slider.frame) - 50, CGRectGetMinY(_slider.frame), 50, 30)];
    _currentTimeLabel.font = [UIFont systemFontOfSize:11];
    _currentTimeLabel.textColor = [UIColor whiteColor];
    _currentTimeLabel.backgroundColor = [UIColor clearColor];
    _currentTimeLabel.textAlignment = NSTextAlignmentRight;
    _currentTimeLabel.text = @"00:00";
    [self addSubview:_currentTimeLabel];
    
    _voiceSlider = [[UISlider alloc] initWithFrame:CGRectMake(100, 100, 100, 20)];
    [_voiceSlider addTarget:self action:@selector(voiceSliderValueChange:) forControlEvents:UIControlEventValueChanged];
    [_voiceSlider setThumbImage:thumbImage forState:UIControlStateHighlighted];
    [_voiceSlider setThumbImage:thumbImage forState:UIControlStateNormal];
    [_voiceSlider setMinimumTrackTintColor:[UIColor blackColor]];
    _voiceSlider.transform = CGAffineTransformMakeRotation(-M_PI_2);
    _voiceSlider.hidden = YES;
    [self addSubview:_voiceSlider];
    
    _backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_backButton addTarget:self action:@selector(doBackAction) forControlEvents:UIControlEventTouchUpInside];
    _backButton.frame = CGRectMake(0, 20, 50, 40);
    [_backButton setBackgroundColor:[UIColor redColor]];
    [self addSubview:_backButton];
}

- (void)doBackAction
{
    AudioSessionRemovePropertyListenerWithUserData(kAudioSessionProperty_CurrentHardwareOutputVolume, volumeListenerCallback, (__bridge void *)self);
    [_playerView pause];
    if (_delegate && [_delegate respondsToSelector:@selector(videoPlayerDidSelectedBackButton:)]) {
        [_delegate videoPlayerDidSelectedBackButton:self];
    }
}

#pragma mark - playerViewDelegateMethod

- (void)videoPlayerView:(XTVideoPlayerView *)playerView didCatchTotalTime:(NSString *)time
{//设置总时间
    _totalTimeLabel.text = time;
}

- (void)videoPlayerView:(XTVideoPlayerView *)playerView bufferProgress:(float)progress
{//设置缓冲进度
    [_progressView setProgress:progress animated:YES];
}

- (void)videoPlayerView:(XTVideoPlayerView *)playerView playProgress:(float)progress playTime:(NSString *)time
{//设置播放进度、播放时间
    [_slider setValue:progress animated:YES];
    _currentTimeLabel.text = time;
}

- (void)sliderValueChanged:(NYSliderPopover *)sender
{//手指滑动进度条时更新popView的值
    [self updateSliderPopoverText:sender];
}

- (void)sliderValueChangedBegin:(NYSliderPopover *)sender
{//开始拖动进度条时视频播放停止
    [_playerView pause];
    [[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:kNotificationKeyStopButtonShouldChangeImage object:@YES]];
}

- (void)sliderValueChangedEnd:(NYSliderPopover *)sender
{//停止拖动进度条时根据总时间和进度获取滑到的时间点
    double currentTime = floor([_playerView totalPlayTime] * sender.value);
    //转换成CMTime才能给player来控制播放进度
    CMTime dragedCMTime = CMTimeMake(currentTime, 1);
    __weak typeof(self) weakSelf = self;
    [_playerView.player seekToTime:dragedCMTime completionHandler:
     ^(BOOL finish)
     {
         [weakSelf.playerView.player play];
         [[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:kNotificationKeyStopButtonShouldChangeImage object:@NO]];
     }];
}

- (void)voiceSliderValueChange:(UISlider *)slider
{
    MPMusicPlayerController *mpc = [MPMusicPlayerController applicationMusicPlayer];
    [mpc setVolume:slider.value];
}

- (void)updateSliderPopoverText:(NYSliderPopover *)sender
{
    sender.popover.textLabel.text = [NSString stringWithFormat:@"%.1f%%", sender.value * 100];
}

- (void)videoPlayerToolViewDidSelectedNextVideo:(XTVideoPlayerToolView *)videoPlayerToolView
{
    [self currentPlayItemPlayDeltaTime:30];
}

- (void)videoPlayerToolViewDidSelectedPreviousVideo:(XTVideoPlayerToolView *)videoPlayerToolView
{
    [self currentPlayItemPlayDeltaTime:-30];
}

- (void)videoPlayerToolViewDidSelectedStopVideo:(XTVideoPlayerToolView *)videoPlayerToolView button:(UIButton *)sender
{
    if (_playerView.isPlaying) {
        [_playerView pause];
        [[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:kNotificationKeyStopButtonShouldChangeImage object:@YES]];
    }else{
        [_playerView play];
        [[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:kNotificationKeyStopButtonShouldChangeImage object:@NO]];
    }
}

- (void)videoPlayerToolViewDidSelectedVideoQuality:(XTVideoPlayerToolView *)videoPlayerToolView
{
    [self none];
}

- (void)videoPlayerToolViewDidSelectedVideoVoice:(XTVideoPlayerToolView *)videoPlayerToolView button:(UIButton *)sender
{
    if (_voiceSlider.hidden) {
        CGPoint p = [videoPlayerToolView convertPoint:sender.center toView:self];
        _voiceSlider.center = CGPointMake(p.x, p.y - 70);
        [_voiceSlider setValue:[[MPMusicPlayerController applicationMusicPlayer] volume] animated:YES];
        _voiceSlider.hidden = NO;
    }else{
        _voiceSlider.hidden = YES;
    }
}

- (void)play
{
    [_playerView play];
}

- (void)playWithURL:(NSString *)url
{

}

/**
 *  从相差delta的时刻开始播放
 *
 */

- (void)currentPlayItemPlayDeltaTime:(int)deltaTime
{
    CMTime time = [self currentPlayItemPlayTimeWithDeltaTime:deltaTime];
    [self currentPlayItemPlayToTime:time];
}

/**
 *  播放器从time时刻开始播放
 *
 */

- (void)currentPlayItemPlayToTime:(CMTime)time
{
    __weak typeof(self) weakSelf = self;
    [_playerView.player seekToTime:time completionHandler:
     ^(BOOL finish)
     {
         [weakSelf.slider setValue:weakSelf.playerView.currentPlayTime / weakSelf.playerView.totalPlayTime animated:YES];
          weakSelf.currentTimeLabel.text = [weakSelf.playerView _currentPlayTime];
         if (weakSelf.playerView.isPlaying) {
             [weakSelf.playerView.player play];
         }
     }];
}

/**
 *  根据deltaTime得到响应的CMTime,如果小于0或者大于总时间返回现在的
 *
 *  @param deltaTime 时间差
 *
 *  @return 与当前播放时间相差deltaTime的CMTime
 */

- (CMTime)currentPlayItemPlayTimeWithDeltaTime:(int)deltaTime
{
    CMTime currentTime = _playerView.player.currentItem.currentTime;
    float currentDuration = (CGFloat)currentTime.value/currentTime.timescale;
    CGFloat newTime = currentDuration + deltaTime;
    if (newTime < [_playerView totalPlayTime] && newTime > 0) {
        CMTime dragedCMTime = CMTimeMake(newTime, 1);
        return dragedCMTime;
    }
    return CMTimeMake(newTime - deltaTime, 1);
}

- (void)none
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Message" message:@"尚未实现" delegate:nil cancelButtonTitle:@"YES" otherButtonTitles:nil, nil];
    [alert show];
}


/*

-(void)handleMediaServicesWereReset:(NSNotification*)notification{
    //  If the media server resets for any reason, handle this notification to reconfigure audio or do any housekeeping, if necessary
    //    • No userInfo dictionary for this notification
    //      • Audio streaming objects are invalidated (zombies)
    //      • Handle this notification by fully reconfiguring audio
    NSLog(@"handleMediaServicesWereReset: %@ ",[notification name]);
}


-(void)handleInterruption:(NSNotification*)notification{
    NSInteger reason = 0;
    NSString* reasonStr=@"";
    if ([notification.name isEqualToString:@"AVAudioSessionInterruptionNotification"]) {
        //Posted when an audio interruption occurs.
        reason = [[[notification userInfo] objectForKey:@" AVAudioSessionInterruptionTypeKey"] integerValue];
        if (reason == AVAudioSessionInterruptionTypeBegan) {
            //       Audio has stopped, already inactive
            //       Change state of UI, etc., to reflect non-playing state
        }
        
        if (reason == AVAudioSessionInterruptionTypeEnded) {
            //       Make session active
            //       Update user interface
            //       AVAudioSessionInterruptionOptionShouldResume option
            reasonStr = @"AVAudioSessionInterruptionTypeEnded";
            NSNumber* seccondReason = [[notification userInfo] objectForKey:@"AVAudioSessionInterruptionOptionKey"] ;
            switch ([seccondReason integerValue]) {
                case AVAudioSessionInterruptionOptionShouldResume:
                    //          Indicates that the audio session is active and immediately ready to be used. Your app can resume the audio operation that was interrupted.
                    break;
                default:
                    break;
            }
        }
        
        
        if ([notification.name isEqualToString:@"AVAudioSessionDidBeginInterruptionNotification"]) {
            //      Posted after an interruption in your audio session occurs.
            //      This notification is posted on the main thread of your app. There is no userInfo dictionary.
        }
        if ([notification.name isEqualToString:@"AVAudioSessionDidEndInterruptionNotification"]) {

            //      Posted after an interruption in your audio session ends.
            //      This notification is posted on the main thread of your app. There is no userInfo dictionary.
        }
        if ([notification.name isEqualToString:@"AVAudioSessionInputDidBecomeAvailableNotification"]) {

            //      Posted when an input to the audio session becomes available.
            //      This notification is posted on the main thread of your app. There is no userInfo dictionary.
        }
        if ([notification.name isEqualToString:@"AVAudioSessionInputDidBecomeUnavailableNotification"]) {

            //      Posted when an input to the audio session becomes unavailable.
            //      This notification is posted on the main thread of your app. There is no userInfo dictionary.
        }
        
    };
    NSLog(@"handleInterruption: %@ reason %@",[notification name],reasonStr);
}

-(void)handleRouteChange:(NSNotification*)notification{
    AVAudioSession *session = [ AVAudioSession sharedInstance ];
    NSString* seccReason = @"";
    NSInteger  reason = [[[notification userInfo] objectForKey:AVAudioSessionRouteChangeReasonKey] integerValue];
    //  AVAudioSessionRouteDescription* prevRoute = [[notification userInfo] objectForKey:AVAudioSessionRouteChangePreviousRouteKey];
    switch (reason) {
        case AVAudioSessionRouteChangeReasonNoSuitableRouteForCategory:
            seccReason = @"The route changed because no suitable route is now available for the specified category.";
            break;
        case AVAudioSessionRouteChangeReasonWakeFromSleep:
            seccReason = @"The route changed when the device woke up from sleep.";
            break;
        case AVAudioSessionRouteChangeReasonOverride:
            seccReason = @"The output route was overridden by the app.";
            break;
        case AVAudioSessionRouteChangeReasonCategoryChange:
            seccReason = @"The category of the session object changed.";
            break;
        case AVAudioSessionRouteChangeReasonOldDeviceUnavailable:
            seccReason = @"The previous audio output path is no longer available.";
            break;
        case AVAudioSessionRouteChangeReasonNewDeviceAvailable:
            seccReason = @"A preferred new audio output path is now available.";
            break;
        case AVAudioSessionRouteChangeReasonUnknown:
        default:
            seccReason = @"The reason for the change is unknown.";
            break;
    }
    AVAudioSessionPortDescription *input = [[session.currentRoute.inputs count]?session.currentRoute.inputs:nil objectAtIndex:0];
    if (input.portType == AVAudioSessionPortHeadsetMic) {
        DLog();
    }
    DLog(@"%@",seccReason);
}*/

#pragma mark - 声音监控

- (void)addHardKeyVolumeListener
{
    AudioSessionInitialize(NULL, NULL, NULL, NULL);
    AudioSessionSetActive(true);
    AudioSessionAddPropertyListener(kAudioSessionProperty_CurrentHardwareOutputVolume ,                                                     volumeListenerCallback,(__bridge void *)self);
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateVolume:) name:@"UpdateVolume" object:nil];
}

void volumeListenerCallback (void *inUserData,
                             AudioSessionPropertyID inPropertyID,
                             UInt32 inPropertyValueSize,
                             const void *inPropertyValue)
{
    if (inPropertyID != kAudioSessionProperty_CurrentHardwareOutputVolume) return;
    Float32 value = *(Float32 *)inPropertyValue;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"UpdateVolume" object:@(value)];
}

- (void)updateVolume:(NSNotification *)sender
{
    [_voiceSlider setValue:[sender.object floatValue] animated:YES];
}

- (void)dealloc
{
    DLog();
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"UpdateVolume" object:nil];
}
@end
