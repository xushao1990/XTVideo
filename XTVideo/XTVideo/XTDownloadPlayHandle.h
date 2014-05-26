//
//  XTDownloadPlayHandle.h
//  XTVideo
//
//  Created by tage on 14-5-20.
//  Copyright (c) 2014年 NULL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XTMP4DownloadRequestOperation.h"

typedef void(^XTDownloadPlayBlock)(NSString *url);

@interface XTDownloadPlayHandle : NSObject

+ (void)downloadPlayWithURL:(NSString *)videoURL canLocalPlay:(XTDownloadPlayBlock)block;

@end
