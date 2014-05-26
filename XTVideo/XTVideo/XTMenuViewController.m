//
//  XTViewController.m
//  XTVideo
//
//  Created by tage on 14-5-19.
//  Copyright (c) 2014年 NULL. All rights reserved.
//

#import "XTMenuViewController.h"
#import "XTListViewController.h"
#import "XTPickerView.h"

@interface XTMenuViewController ()

@property (weak, nonatomic) IBOutlet UIButton *M3U8Btn;

@property (weak, nonatomic) IBOutlet UIButton *MP4Btn;

@property (weak, nonatomic) IBOutlet UIPickerView *picker;

@property (nonatomic, strong) NSMutableArray *mp4Datasource;

@property (nonatomic, strong) NSMutableArray *m3u8Datasource;

@end

@implementation XTMenuViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"列表";
    [self downloadVideoURL:@"14"];
}
- (IBAction)showM3U8:(UIButton *)sender {
    [self pushListWithType:VideoTypeSupportHLS array:_m3u8Datasource];
}
- (IBAction)showMP4:(UIButton *)sender {
    [self pushListWithType:VideoTypeUnSupportHLS array:_mp4Datasource];
}
- (IBAction)cache:(UIButton *)sender {
    [self.navigationController pushViewController:[[NSClassFromString(@"XTCacheViewController") alloc] init] animated:YES];
}

- (void)pushListWithType:(VideoType)type array:(NSArray *)array
{
    XTListViewController *listVC = [[XTListViewController alloc] initWithType:type objects:array];
    [self.navigationController pushViewController:listVC animated:YES];
}

- (NSMutableArray *)mp4Datasource
{
    if (!_mp4Datasource) {
        _mp4Datasource = @[].mutableCopy;
    }
    return _mp4Datasource;
}

- (NSMutableArray *)m3u8Datasource
{
    if (!_m3u8Datasource) {
        _m3u8Datasource = @[].mutableCopy;
    }
    return _m3u8Datasource;
}

- (void)resetDataSource:(NSMutableArray *)origion dataSource:(NSArray *)source
{
    [origion removeAllObjects];
    [origion addObjectsFromArray:source];
}

- (void)downloadVideoURL:(NSString *)page
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSError *error;
        NSData *data = [NSURLConnection sendSynchronousRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:kDataSourceURL] cachePolicy:0 timeoutInterval:10] returningResponse:nil error:&error];
        if (error) {
            DLog(@"%@",error);
        }else{
            NSMutableArray *mp4TempArray = @[].mutableCopy;
            NSMutableArray *m3u8TempArray = @[].mutableCopy;
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
            if (error) {
                DLog(@"%@",error);
            }else{
                for (NSDictionary *subDic in dic[@"result"][[page intValue]][@"list"]) {//16有MP415有M3U8，2014年05月20日
                    NSString *videoURL = subDic[@"video_addr"];
                    if ([videoURL hasSuffix:@"mp4"]) {
                        [mp4TempArray addObject:@{@"title": subDic[@"name"],@"url":videoURL}];
                    }else if ([videoURL hasSuffix:@"m3u8"]) {
                        [m3u8TempArray addObject:@{@"title": subDic[@"name"],@"url":videoURL}];
                    }
                }
                [self resetDataSource:self.mp4Datasource dataSource:mp4TempArray];
                [self resetDataSource:self.m3u8Datasource dataSource:m3u8TempArray];
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (!self.mp4Datasource.count) {
                        [self resetButton:_MP4Btn state:NO title:@"暂无MP4"];
                    }else{
                        [self resetButton:_MP4Btn state:YES title:@"MP4"];
                    }
                    if (!self.m3u8Datasource.count) {
                        [self resetButton:_M3U8Btn state:NO title:@"暂无M3U8"];
                    }else{
                        [self resetButton:_M3U8Btn state:YES title:@"M3U8"];
                    }
                });
            }
        }
    });
}

- (void)resetButton:(UIButton *)sender state:(BOOL)aBool title:(NSString *)title
{
    [sender setTitle:title
            forState:UIControlStateNormal];
    [sender setTitleColor:aBool ? [UIColor blueColor] : [UIColor redColor]
                 forState:UIControlStateNormal];
}

- (IBAction)picker:(UIButton *)sender {
    
    __weak typeof(self)weakSelf = self;
    [XTPickerView pickViewShowWithSubmitBlock:^(NSString *string) {
        [weakSelf downloadVideoURL:string];
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
