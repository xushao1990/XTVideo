//
//  NSObject+Extension.m
//  CocoapodTest
//
//  Created by tage on 14-4-9.
//  Copyright (c) 2014年 cn.kaakoo. All rights reserved.
//

#import "NSObject+Extension.h"

@implementation NSObject (Extension)

- (void)performBlock:(void(^)())block afterDelay:(NSTimeInterval)delay {
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), block);
}

- (float)windowHeight
{
    return CGRectGetHeight([[UIApplication sharedApplication] keyWindow].bounds);
}

- (UIWindow *)appWindowView
{
    return [[UIApplication sharedApplication] keyWindow];
}

@end
