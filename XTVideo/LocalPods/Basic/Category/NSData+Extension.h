//
//  NSData+Extension.h
//  CocoapodTest
//
//  Created by tage on 14-4-9.
//  Copyright (c) 2014年 cn.kaakoo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (Extension)

- (NSData*) MD5;

- (NSData*) SHA1;

- (NSData*) SHA256;

- (NSString *)dataIdentify;

#pragma mark - 取出gif的第一帧

- (UIImage *)praseGIFDataFirstImage;

@end
