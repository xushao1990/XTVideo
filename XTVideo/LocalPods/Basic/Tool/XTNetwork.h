//
//  XTNetwork.h
//  MTLL
//
//  Created by tage on 14-4-25.
//  Copyright (c) 2014年 XT. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    
    XTNetworkCacheTypeDefault = 0,//默认会读取本地缓存
    
    XTNetworkCacheTypeIgnoreCache = 1,//忽略本地缓存
    
    XTNetworkCacheTypeRetryTwice = 3
    
}XTNetworkCacheType;


typedef void(^XTNetworkSuccessBlock)(NSData *data);

typedef void(^XTNetworkFaildBlock)(NSError *error);

@interface XTNetwork : NSObject

- (void)startDownloadWithURL:(NSString *)url option:(XTNetworkCacheType)option success:(XTNetworkSuccessBlock)success faild:(XTNetworkFaildBlock)faild;

- (void)cancleDownload;

@end
