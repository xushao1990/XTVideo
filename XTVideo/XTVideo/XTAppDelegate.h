//
//  XTAppDelegate.h
//  XTVideo
//
//  Created by tage on 14-5-19.
//  Copyright (c) 2014年 NULL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <HTTPServer.h>

@interface XTAppDelegate : UIResponder <UIApplicationDelegate>

@property (nonatomic, strong) HTTPServer *httpServer;

@property (strong, nonatomic) UIWindow *window;

@end
