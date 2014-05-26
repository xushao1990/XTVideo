//
//  XTVideoPlayerToolView.m
//  XTVideoPlayer
//
//  Created by tage on 14-5-21.
//  Copyright (c) 2014年 NULL. All rights reserved.
//

#import "XTVideoPlayerToolView.h"

@interface XTVideoPlayerToolView ()

@property (strong, nonatomic) IBOutlet UIButton *stop;

@end



@implementation XTVideoPlayerToolView

-(id)initWithCoder:(NSCoder *)aDecoder
{
    if(self = [super initWithCoder:aDecoder]){
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeStopButtonState:) name:kNotificationKeyStopButtonShouldChangeImage object:nil];
    }
    return self;
}

- (void)changeStopButtonState:(NSNotification *)sender
{
    if ([sender.object boolValue]) {
        [_stop setImage:[UIImage imageNamed:@"repeatVideoStarticon"] forState:UIControlStateNormal];
    }else{
        [_stop setImage:[UIImage imageNamed:@"videoPause"] forState:UIControlStateNormal];
    }
}

- (IBAction)changeVideoQuality:(UIButton *)sender {
    if (_delegate && [_delegate respondsToSelector:@selector(videoPlayerToolViewDidSelectedVideoQuality:)]) {
        [_delegate videoPlayerToolViewDidSelectedVideoQuality:self];
    }
}

- (IBAction)turnBackTime:(UIButton *)sender {
    if (_delegate && [_delegate respondsToSelector:@selector(videoPlayerToolViewDidSelectedPreviousVideo:)]) {
        [_delegate videoPlayerToolViewDidSelectedPreviousVideo:self];
    }
}
- (IBAction)playOrStop:(UIButton *)sender {
    if (_delegate && [_delegate respondsToSelector:@selector(videoPlayerToolViewDidSelectedStopVideo:button:)]) {
        [_delegate videoPlayerToolViewDidSelectedStopVideo:self button:sender];
    }
}
- (IBAction)turnForwardTime:(UIButton *)sender {
    if (_delegate && [_delegate respondsToSelector:@selector(videoPlayerToolViewDidSelectedNextVideo:)]) {
        [_delegate videoPlayerToolViewDidSelectedNextVideo:self];
    }
}
- (IBAction)changeVideoVoice:(UIButton *)sender {
    if (_delegate && [_delegate respondsToSelector:@selector(videoPlayerToolViewDidSelectedVideoVoice:button:)]) {
        [_delegate videoPlayerToolViewDidSelectedVideoVoice:self button:sender];
    }
}

@end
