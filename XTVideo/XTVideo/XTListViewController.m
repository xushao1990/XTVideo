//
//  ListViewController.m
//  XTVideo
//
//  Created by tage on 14-5-19.
//  Copyright (c) 2014年 XT. All rights reserved.
//

#import "XTListViewController.h"
#import "XTVideoListView.h"
#import "XTDownloadPlayHandle.h"
#import "XTVideoModel.h"
#import "XTVideoPlayer.h"
#import "XTVideoPlayerViewController.h"

#import <MediaPlayer/MediaPlayer.h>

@interface XTListViewController ()<XTVideoListViewDelegate,XTVideoPlayerDelegate>
{
    VideoType type;
    NSArray *_array;
    
    XTVideoListView *_listView;
    
    BOOL statusBarState;
}


@end

@implementation XTListViewController

- (instancetype)initWithType:(VideoType)aType objects:(NSArray *)array
{
    if (self = [super init]) {
        type = aType;
        _array = [NSArray arrayWithArray:array];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    switch (type) {
        case VideoTypeUnSupportHLS:
            self.navigationItem.title = @"MP4";
            break;
        case VideoTypeSupportHLS:
            self.navigationItem.title = @"M3U8";
            break;
        default:
            break;
    }
    
    _listView = ({
        XTVideoListView *listView = [[XTVideoListView alloc] initWithFrame:self.view.bounds type:type dataSource:_array delegate:self];
        listView;
    });
    [self.view addSubview:_listView];
}

- (void)playVideoWithURL:(NSString *)videoURL
{
//    MPMoviePlayerViewController *vc = [[MPMoviePlayerViewController alloc] initWithContentURL:[NSURL URLWithString:@"http://lvs.1006.tv/hls-live/livepkgr/_definst_/liveevent/1006lol.m3u8"]];
//    [self presentViewController:vc animated:YES completion:nil];
//    return;
    
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    [self changeDirection:UIInterfaceOrientationLandscapeRight];
    XTVideoModel *model = [[XTVideoModel alloc] init];
    model.normalQualityURL = videoURL;
    XTVideoPlayer *player = [[XTVideoPlayer alloc] initWithFrame:self.view.bounds videoModel:model delegate:self];
    [self.view addSubview:player];
    
    statusBarState = YES;
    [self updateStatusBar];
}

- (void)videoPlayerDidSelectedNextVideo:(XTVideoPlayer *)aVideoPlayer
{
    
}

- (void)videoPlayerDidSelectedBackButton:(XTVideoPlayer *)aVideoPlayer
{
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [self changeDirection:UIInterfaceOrientationPortrait];
    statusBarState = NO;
    [self updateStatusBar];
    [aVideoPlayer removeFromSuperview];
}

- (void)downloadVideoWithURL:(NSString *)videoURL progressView:(UIProgressView *)progressView
{
    
}

- (void)downloadPlayVideoWithURL:(NSString *)videoURL
{
    [XTDownloadPlayHandle downloadPlayWithURL:videoURL canLocalPlay:^(NSString *url) {
        [self playVideoWithURL:url];
    }];
}

- (void)changeDirection:(UIInterfaceOrientation)o
{
    if ([[UIDevice currentDevice] respondsToSelector:@selector(setOrientation:)]) {
        SEL selector = NSSelectorFromString(@"setOrientation:");
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[UIDevice instanceMethodSignatureForSelector:selector]];
        [invocation setSelector:selector];
        [invocation setTarget:[UIDevice currentDevice]];
        int val = o;
        [invocation setArgument:&val atIndex:2];
        [invocation invoke];
    }
}

- (void)updateStatusBar
{
    if ([self respondsToSelector:@selector(setNeedsStatusBarAppearanceUpdate)]) {
        [UIView animateWithDuration:0.3f animations:^{
            [self performSelector:@selector(setNeedsStatusBarAppearanceUpdate)];
        }];
    }
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    if (statusBarState) {
        return UIStatusBarStyleLightContent;
    }
    return UIStatusBarStyleDefault;
}

@end
