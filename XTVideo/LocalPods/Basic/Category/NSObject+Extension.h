//
//  NSObject+Extension.h
//  CocoapodTest
//
//  Created by tage on 14-4-9.
//  Copyright (c) 2014年 cn.kaakoo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Extension)

- (void)performBlock:(void(^)())block afterDelay:(NSTimeInterval)delay;

- (float)windowHeight;

- (UIWindow *)appWindowView;

@end
