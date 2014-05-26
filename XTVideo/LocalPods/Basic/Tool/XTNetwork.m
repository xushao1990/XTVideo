//
//  XTNetwork.m
//  MTLL
//
//  Created by tage on 14-4-25.
//  Copyright (c) 2014年 XT. All rights reserved.
//

#import "XTNetwork.h"
#import <XTMacroHeader.h>
#import <XTCategoryHeader.h>
#import "FileUtil.h"


@interface XTNetwork ()

@property (nonatomic) XTNetworkCacheType type;

@property (nonatomic , strong) NSURLConnection *connection;

@property (nonatomic , copy) XTNetworkSuccessBlock successBlock;

@property (nonatomic , copy) XTNetworkFaildBlock faildBlock;

@property (nonatomic , strong) NSMutableData *receivedData;

@end

#define XTNETWORKCACHEFILEPATH [kRootCachePath stringByAppendingPathComponent:@"XTNetworkCache"]

@implementation XTNetwork

- (instancetype)init
{
    if (self = [super init]) {
        [FileUtil createFolder:XTNETWORKCACHEFILEPATH];
    }
    return self;
}

- (void)startDownloadWithURL:(NSString *)url option:(XTNetworkCacheType)option success:(XTNetworkSuccessBlock)success faild:(XTNetworkFaildBlock)faild
{
    _receivedData = nil;
    
    _successBlock = nil;
    
    _faildBlock = nil;
    
    [_connection cancel];
    
    _connection = nil;
    
    self.type = option;
    
    if (self.type != XTNetworkCacheTypeIgnoreCache) {
        NSString *oldpath = [XTNETWORKCACHEFILEPATH stringByAppendingPathComponent:[url cachedFileName]];
        if ([FileUtil fileExit:oldpath]) {
            success ([NSData dataWithContentsOfFile:oldpath]);
            return;
        }
    }
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url] cachePolicy:1 timeoutInterval:8];
    
    _connection = [[NSURLConnection alloc] initWithRequest:request delegate:self startImmediately:NO];
    
    if (success) {
        _successBlock = success;
    }
    if (faild) {
        _faildBlock = faild;
    }
    
    [_connection start];

}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    _receivedData = [NSMutableData data];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [_receivedData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    [_receivedData writeToFile:[XTNETWORKCACHEFILEPATH stringByAppendingPathComponent:[[[connection.originalRequest URL] absoluteString] cachedFileName]] atomically:YES];
    if (_successBlock) {
        _successBlock (_receivedData);
    }
}

static int requestCount = 0;

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    if (self.type == XTNetworkCacheTypeRetryTwice && requestCount == 0) {
        [_connection start];
        requestCount ++;
    }
    if (_faildBlock) {
        requestCount = 0;
        _faildBlock (error);
    }
}

- (void)cancleDownload
{
    if (_connection) {
        [_connection cancel];
    }
}

- (void)dealloc
{
}


@end
