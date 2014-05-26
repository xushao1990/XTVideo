//
//  XTAppDelegate.m
//  XTVideo
//
//  Created by tage on 14-5-19.
//  Copyright (c) 2014年 NULL. All rights reserved.
//

#import "XTAppDelegate.h"

@implementation XTAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [self serverConfig];
    return YES;
}

- (void)serverConfig
{
    DLog(@"%@",kRootDocumentsPath);
    
    _httpServer = [[HTTPServer alloc] init];
    
    [_httpServer setType:@"_http._tcp."];
    
    [_httpServer setPort:kHTTPServerPort];
    
    [FileUtil createFolder:kVideoFilePath];
    
    DLog(@"%@",kVideoTempFilePath);
    
    [_httpServer setDocumentRoot:NSHomeDirectory()];
    
    [self startHttpServer];
}

- (void)startHttpServer
{
	NSError *error;
	if([_httpServer start:&error]){
		NSLog(@"Started HTTP Server on port %hu", [_httpServer listeningPort]);
	}else{
		NSLog(@"Error starting HTTP Server: %@", error);
	}
}

							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end