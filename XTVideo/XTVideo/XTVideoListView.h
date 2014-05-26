//
//  VideoListView.h
//  XTVideo
//
//  Created by tage on 14-5-15.
//  Copyright (c) 2014年 XT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <PSCollectionView.h>

@protocol XTVideoListViewDelegate <NSObject>

- (void)playVideoWithURL:(NSString *)videoURL;

- (void)downloadVideoWithURL:(NSString *)videoURL progressView:(UIProgressView *)progressView;

- (void)downloadPlayVideoWithURL:(NSString *)videoURL;

@end

@interface XTVideoListView : UIView<PSCollectionViewDataSource,PSCollectionViewDelegate>


- (instancetype)initWithFrame:(CGRect)frame type:(VideoType)type dataSource:(NSArray *)array delegate:(id <XTVideoListViewDelegate>)delegate;

@end
