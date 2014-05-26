//
//  XTDownloadPlayHandle.m
//  XTVideo
//
//  Created by tage on 14-5-20.
//  Copyright (c) 2014年 NULL. All rights reserved.
//

#import "XTDownloadPlayHandle.h"

@implementation XTDownloadPlayHandle

+ (void)downloadPlayWithURL:(NSString *)videoURL canLocalPlay:(XTDownloadPlayBlock)block
{
    NSString *file = [[videoURL cachedFileName] stringByAppendingString:@".mp4"];
    static BOOL showed = NO;
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:videoURL] cachePolicy:0 timeoutInterval:3600];
    XTMP4DownloadRequestOperation *downloader = [[XTMP4DownloadRequestOperation alloc] initWithRequest:request targetPath:[kVideoFilePath stringByAppendingPathComponent:file] shouldResume:YES];
    __weak typeof(downloader) weakDownloader = downloader;
    [downloader setProgressiveDownloadProgressBlock:^(AFDownloadRequestOperation *operation, NSInteger bytesRead, long long totalBytesRead, long long totalBytesExpected, long long totalBytesReadForFile, long long totalBytesExpectedToReadForFile) {
        float f = totalBytesReadForFile / (float)totalBytesExpectedToReadForFile;
        DLog(@"%f",f);
        if (f > 0.1) {
            if (!showed) {
                NSString *file = [kHTTPServerHost stringByAppendingFormat:@"tmp/Incomplete/%@",weakDownloader.tempPath.lastPathComponent];
                if (block) {
                    block (file);
                }
                showed = YES;
            }
        }
    }];
    [downloader setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        DLog();
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        DLog(@"failed%@",error);
    }];
    [downloader start];
}

@end
