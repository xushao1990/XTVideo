//
//  Configuration.h
//  XTVideo
//
//  Created by tage on 14-5-14.
//  Copyright (c) 2014年 XT. All rights reserved.
//

#ifndef XTVideo_Configuration_h
#define XTVideo_Configuration_h

#define kHTTPServerPort (12345)

#define kHTTPServerHost [NSString stringWithFormat:@"http://127.0.0.1:%d/",kHTTPServerPort]

#define kDataSourceURL @"http://v.iphone.1006.tv/mainpage2/lolvideo/?cid=16&channel=1"

#define kVideoFilePath [kRootDocumentsPath stringByAppendingPathComponent:@"Videos"]

#define kVideoTempFilePath [NSTemporaryDirectory() stringByAppendingPathComponent:@"Incomplete"]


#endif
