//
//  VideoListView.m
//  XTVideo
//
//  Created by tage on 14-5-15.
//  Copyright (c) 2014年 XT. All rights reserved.
//

#import "XTVideoListView.h"
#import "XTVideoListCell.h"

@interface XTVideoListView ()<XTVideoListCellDelegate>

@property (nonatomic, strong) PSCollectionView *listView;

@property (nonatomic, weak) id <XTVideoListViewDelegate> delegate;

@property (nonatomic, strong) NSArray *dataSource;

@property (nonatomic) VideoType type;

@end

@implementation XTVideoListView

- (instancetype)initWithFrame:(CGRect)frame type:(VideoType)type dataSource:(NSArray *)dataSource delegate:(id<XTVideoListViewDelegate>)delegate
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        _delegate = delegate;
        _dataSource = dataSource;
        _type = type;
        [self addListView];
    }
    return self;
}

- (void)addListView
{
    _listView = ({
        PSCollectionView *collectionView = [[PSCollectionView alloc] initWithFrame:self.bounds];
        collectionView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        collectionView.alwaysBounceVertical = YES;
        collectionView.numColsPortrait = 1;
        collectionView.collectionViewDataSource = self;
        collectionView.collectionViewDelegate = self;
        collectionView;
    });
    [self addSubview:_listView];
}

- (NSInteger)numberOfRowsInCollectionView:(PSCollectionView *)collectionView
{
    return _dataSource.count;
}

- (PSCollectionViewCell *)collectionView:(PSCollectionView *)collectionView cellForRowAtIndex:(NSInteger)index
{
    XTVideoListCell *cell = (XTVideoListCell *)[collectionView dequeueReusableViewForClass:[XTVideoListCell class]];
    if (!cell) {
        cell = [[XTVideoListCell alloc] initWithFrame:CGRectZero delegate:self];
    }
    [cell collectionView:collectionView fillCellWithObject:_dataSource[index] atIndex:index];
    return cell;
}

- (CGFloat)collectionView:(PSCollectionView *)collectionView heightForRowAtIndex:(NSInteger)index
{
    return [XTVideoListCell rowHeightForObject:_dataSource[index] inColumnWidth:collectionView.colWidth];
}

#pragma mark - VideoListCellDelegateMethods

- (void)videoListCell:(XTVideoListCell *)cell downloadAction:(NSString *)url progressView:(UIProgressView *)progressView
{
    if (_delegate && [_delegate respondsToSelector:@selector(downloadVideoWithURL: progressView:)]) {
        [_delegate downloadVideoWithURL:url progressView:progressView];
    }
}

- (void)videoListCell:(XTVideoListCell *)cell playAction:(NSString *)url
{
    if (_delegate && [_delegate respondsToSelector:@selector(playVideoWithURL:)]) {
        [_delegate playVideoWithURL:url];
    }
}

- (void)videoListCell:(XTVideoListCell *)cell downloadPlayAction:(NSString *)url
{
    if (_delegate && [_delegate respondsToSelector:@selector(downloadPlayVideoWithURL:)]) {
        [_delegate downloadPlayVideoWithURL:url];
    }
}

@end
