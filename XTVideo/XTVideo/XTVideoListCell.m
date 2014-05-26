//
//  VideoListCell.m
//  XTVideo
//
//  Created by tage on 14-5-15.
//  Copyright (c) 2014年 XT. All rights reserved.
//

#import "XTVideoListCell.h"

@interface XTVideoListCell ()

@property (nonatomic, strong) UILabel *nameLabel;

@property (nonatomic, strong) UIButton *downloadButton;

@property (nonatomic, strong) UIButton *playButton;

@property (nonatomic, strong) UIButton *dowloadPlayButton;

@property (nonatomic, strong) UIProgressView *progressView;

@property (nonatomic, weak) id <XTVideoListCellDelegate> delegate;

@end

@implementation XTVideoListCell

- (id)initWithFrame:(CGRect)frame delegate:(id <XTVideoListCellDelegate>)delegate
{
    self = [super initWithFrame:frame];
    if (self) {
        self.delegate = delegate;
        self.backgroundColor = [UIColor clearColor];
        self.layer.borderColor = [UIColor darkGrayColor].CGColor;
        self.layer.borderWidth = 0.5;
        self.layer.cornerRadius = 3;
        self.layer.shadowPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:self.layer.cornerRadius].CGPath;
        _nameLabel = ({
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
            label.backgroundColor = [UIColor clearColor];
            label.numberOfLines = 0;
            label.lineBreakMode = NSLineBreakByWordWrapping;
            label.font = [UIFont systemFontOfSize:15];
            label;
        });
        [self addSubview:_nameLabel];
        _downloadButton = [self currentButton:@selector(download) text:@"下载"];
        [self addSubview:_downloadButton];
        _playButton = [self currentButton:@selector(play) text:@"播放"];
        [self addSubview:_playButton];
        _dowloadPlayButton = [self currentButton:@selector(downloadPlay) text:@"边下边播"];
        [self addSubview:_dowloadPlayButton];
        
        _progressView = ({
            UIProgressView *progress = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
            progress.frame = CGRectZero;
            [self addSubview:progress];
            progress;
        });
    }
    return self;
}

- (void)download
{
    if (_delegate && [_delegate respondsToSelector:@selector(videoListCell:downloadAction:progressView:)]) {
        [_delegate videoListCell:self downloadAction:[self.object valueForKey:@"url"] progressView:_progressView];
    }
}

- (void)play
{
    if (_delegate && [_delegate respondsToSelector:@selector(videoListCell:playAction:)]) {
        [_delegate videoListCell:self playAction:[self.object valueForKey:@"url"]];
    }
}

- (void)downloadPlay
{
    if (_delegate && [_delegate respondsToSelector:@selector(videoListCell:downloadPlayAction:)]) {
        [_delegate videoListCell:self downloadPlayAction:[self.object valueForKey:@"url"]];
    }
}

- (UIButton *)currentButton:(SEL)action text:(NSString *)title
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.layer.borderWidth = 0.3;
    button.layer.borderColor = [UIColor lightGrayColor].CGColor;
    button.layer.cornerRadius = 3;
    button.layer.shadowPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:self.layer.cornerRadius].CGPath;
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    return button;
}

- (void)prepareForReuse
{
    [super prepareForReuse];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    NSString *name = [self.object valueForKey:@"title"];
    _nameLabel.frame = [name boundingRectWithSize:CGSizeMake(CGRectGetWidth(self.bounds), MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:15]} context:nil];
    _nameLabel.text = name;
    _progressView.frame = CGRectMake(CGRectGetMinX(_nameLabel.frame), CGRectGetMaxY(_nameLabel.frame) + 5, CGRectGetWidth(_nameLabel.frame), 20);
    [_progressView setProgress:0.3];
    _downloadButton.frame = CGRectMake(10, CGRectGetMaxY(_nameLabel.frame) + 30, 80, 40);
    _playButton.frame = CGRectMake(110, CGRectGetMinY(_downloadButton.frame), 80, 40);
    _dowloadPlayButton.frame = CGRectMake(210, CGRectGetMinY(_playButton.frame), 80, 40);

}

- (void)collectionView:(PSCollectionView *)collectionView fillCellWithObject:(id)object atIndex:(NSInteger)index
{
    [super collectionView:collectionView fillCellWithObject:object atIndex:index];
}

+ (CGFloat)rowHeightForObject:(id)object inColumnWidth:(CGFloat)columnWidth
{
    NSString *name = [object valueForKey:@"title"];
    CGRect rect = [name boundingRectWithSize:CGSizeMake(columnWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:15]} context:nil];
    return CGRectGetHeight(rect) + 40 + 40;
}

@end
