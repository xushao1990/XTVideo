//
//  NetUtil.h
//  KG4-0
//
//  Created by zhuyw on 11-5-18.
//  Copyright 2011年 TargTime. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SystemConfiguration/SystemConfiguration.h>
#include <netdb.h>

@interface NetUtil : NSObject {
    
}

+ (NSString *)connect4UTF8:(NSString *)urlString type:(NSString *)type;

+ (NSString *)get:(NSString *)url;

+ (NSString *)post:(NSString *)url;

+ (NSString *)URLencode4UTF8:(NSString *)originalString;

+ (NSString *)URLencode4GBK:(NSString *)originalString;

+ (NSString *)urlEncodeValue:(NSString *)str;

+ (void)getData:(NSString *)urlPath dinPath:(NSString *)dinPath;

+ (BOOL) connectedToNetwork;

+ (NSData *)requestWithURL:(NSString *)urlStr;

+ (NSData *)requestWithURL:(NSString *)urlStr timeoutInterval:(NSTimeInterval)timeoutInterval;

+ (void)asynchronousRequestWithURL:(NSString *)urlStr;

@end
