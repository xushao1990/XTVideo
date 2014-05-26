//
//  VideoListCell.h
//  XTVideo
//
//  Created by tage on 14-5-15.
//  Copyright (c) 2014年 XT. All rights reserved.
//

#import "PSCollectionViewCell.h"

@class XTVideoListCell;

@protocol XTVideoListCellDelegate <NSObject>

- (void)videoListCell:(XTVideoListCell *)cell downloadAction:(NSString *)url progressView:(UIProgressView *)progressView;

- (void)videoListCell:(XTVideoListCell *)cell playAction:(NSString *)url;

- (void)videoListCell:(XTVideoListCell *)cell downloadPlayAction:(NSString *)url;

@end

@interface XTVideoListCell : PSCollectionViewCell

- (id)initWithFrame:(CGRect)frame delegate:(id <XTVideoListCellDelegate>)delegate;

@end
