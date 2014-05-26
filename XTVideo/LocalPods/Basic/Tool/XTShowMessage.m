//
//  XTShowMessage.m
//  CocoapodTest
//
//  Created by tage on 14-4-10.
//  Copyright (c) 2014年 cn.kaakoo. All rights reserved.
//

#import "XTShowMessage.h"

@implementation XTShowMessage

+ (void)XTShowTheMessage:(NSString *)string view:(UIView *)view
{
    NSString *key = NSStringFromClass([XTShowMessage class]);
    
    BOOL canshowMessage = [[NSUserDefaults standardUserDefaults] boolForKey:key];
    
    if (!canshowMessage) {
        
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:key];
        
        UIView *messageView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 80)];
        
        messageView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.8];
        
        messageView.layer.cornerRadius = 5;
        
        CGRect rect;
        
        if (view) {
            
            [view addSubview:messageView];
            
            rect = view.frame;
            
        }else{
            
            [[[UIApplication sharedApplication] keyWindow] addSubview:messageView];
            
            rect = [[UIApplication sharedApplication] keyWindow].frame;
        }
        
        messageView.center = CGPointMake(CGRectGetWidth(rect)/2, CGRectGetHeight(rect)/2);
        
        UILabel *label = [[UILabel alloc] initWithFrame:messageView.bounds];
        
        label.backgroundColor = [UIColor clearColor];
        
        label.textColor = [UIColor whiteColor];
        
        label.textAlignment = NSTextAlignmentCenter;
        
        label.font = [UIFont systemFontOfSize:16];
        
        label.text = string;
        
        [messageView addSubview:label];
        
        label.center = CGPointMake(CGRectGetWidth(messageView.bounds) / 2, CGRectGetHeight(messageView.bounds) / 2);
        
        
        double delayInSeconds = 1.0;
        
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
        
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            
            [messageView removeFromSuperview];
            
            [[NSUserDefaults standardUserDefaults] setBool:NO forKey:key];
            
        });
    }
}

@end
