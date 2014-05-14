//
//  NetUtil.m
//  KG4-0
//
//  Created by zhuyw on 11-5-18.
//  Copyright 2011年 TargTime. All rights reserved.
//

#import "NetUtil.h"

@implementation NetUtil

+ (NSString *)connect4UTF8:(NSString *)urlString type:(NSString *)type {
    NSURL *url = [NSURL URLWithString:urlString];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    [request setHTTPMethod:type];
    NSURLResponse *response = nil;
    NSError *error = nil;
    NSData *result = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    //    [request release];
    NSString *resultString = [[NSString alloc] initWithData:result encoding:NSUTF8StringEncoding];
    return resultString;
}

+ (NSString *)connect4GBK:(NSString *)urlString {
    NSURL *url = [NSURL URLWithString:urlString];
    NSData *data = [NSData dataWithContentsOfURL:url];
    NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    NSString *retStr = [[NSString alloc] initWithData:data encoding:enc];
    
    return retStr;
}

//+ (NSString *)connect4GBK:(NSString *)urlString {
//	NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
//
//    NSURL *url = [NSURL URLWithString:[urlString stringByReplacingPercentEscapesUsingEncoding:enc]];
//    NSData *data = [NSData dataWithContentsOfURL:url];
//
//    NSString *retStr = [[NSString alloc] initWithData:data encoding:enc];
//
//    return [retStr autorelease];
//}


+ (NSString *)get:(NSString *)url {
    return [self connect4GBK:url];
}

+ (NSString *)post:(NSString *)url {
    return [self connect4GBK:url];
}

+ (NSString *)urlEncodeValue:(NSString *)str {
	return @"";
}

+ (NSString *)URLencode:(NSString *)originalString enCoding:(CFStringEncoding)anEnCoding {
    //!  @  $  &  (  )  =  +  ~  `  ;  '  :  ,  /  ?
    //%21%40%24%26%28%29%3D%2B%7E%60%3B%27%3A%2C%2F%3F
    NSArray *escapeChars = [NSArray arrayWithObjects:@";" , @"/" , @"?" , @":" ,
                            @"@" , @"&" , @"=" , @"+" ,    @"$" , @"," ,
                            @"!", @"'", @"(", @")", @"*", nil];
	
    NSArray *replaceChars = [NSArray arrayWithObjects:@"%3B" , @"%2F", @"%3F" , @"%3A" ,
                             @"%40" , @"%26" , @"%3D" , @"%2B" , @"%24" , @"%2C" ,
                             @"%21", @"%27", @"%28", @"%29", @"%2A", nil];
	
    NSInteger len = [escapeChars count];
	
	NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(anEnCoding);
    NSMutableString *temp = [[originalString
                              stringByAddingPercentEscapesUsingEncoding:enc]
                             mutableCopy];
	
    int i;
    for (i = 0; i < len; i++) {
		
        [temp replaceOccurrencesOfString:[escapeChars objectAtIndex:i]
                              withString:[replaceChars objectAtIndex:i]
                                 options:NSLiteralSearch
                                   range:NSMakeRange(0, [temp length])];
    }
	
    NSString *outStr = [NSString stringWithString: temp];
	
    return outStr;
}

+ (NSString *)URLencode4UTF8:(NSString *)originalString {
    //	return [self URLencode:originalString enCoding:kCFStringEncodingUTF8];
	//!  @  $  &  (  )  =  +  ~  `  ;  '  :  ,  /  ?
    //%21%40%24%26%28%29%3D%2B%7E%60%3B%27%3A%2C%2F%3F
    NSArray *escapeChars = [NSArray arrayWithObjects:@";" , @"/" , @"?" , @":" ,
                            @"@" , @"&" , @"=" , @"+" ,    @"$" , @"," ,
                            @"!", @"'", @"(", @")", @"*", nil];
	
    NSArray *replaceChars = [NSArray arrayWithObjects:@"%3B" , @"%2F", @"%3F" , @"%3A" ,
                             @"%40" , @"%26" , @"%3D" , @"%2B" , @"%24" , @"%2C" ,
                             @"%21", @"%27", @"%28", @"%29", @"%2A", nil];
	
    NSInteger len = [escapeChars count];
	
	NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingUTF8);
    NSMutableString *temp = [[originalString
                              stringByAddingPercentEscapesUsingEncoding:enc]
                             mutableCopy];
	
    int i;
    for (i = 0; i < len; i++) {
		
        [temp replaceOccurrencesOfString:[escapeChars objectAtIndex:i]
                              withString:[replaceChars objectAtIndex:i]
                                 options:NSLiteralSearch
                                   range:NSMakeRange(0, [temp length])];
    }
	
    NSString *outStr = [NSString stringWithString: temp];
	
    return outStr;
}

+ (NSString *)URLencode4GBK:(NSString *)originalString {
    if (originalString == nil) {
        return @"";
    }
	return [self URLencode:originalString enCoding:kCFStringEncodingGB_18030_2000];
}

//+ (NSString *)URLencode:(NSString *)originalString {
//    //!  @  $  &  (  )  =  +  ~  `  ;  '  :  ,  /  ?
//    //%21%40%24%26%28%29%3D%2B%7E%60%3B%27%3A%2C%2F%3F
//    NSArray *escapeChars = [NSArray arrayWithObjects:@";" , @"/" , @"?" , @":" ,
//                            @"@" , @"&" , @"=" , @"+" ,    @"$" , @"," ,
//                            @"!", @"'", @"(", @")", @"*", nil];
//
//    NSArray *replaceChars = [NSArray arrayWithObjects:@"%3B" , @"%2F", @"%3F" , @"%3A" ,
//                             @"%40" , @"%26" , @"%3D" , @"%2B" , @"%24" , @"%2C" ,
//                             @"%21", @"%27", @"%28", @"%29", @"%2A", nil];
//
//    NSInteger len = [escapeChars count];
//
//	NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
//    NSMutableString *temp = [[originalString
//                              stringByAddingPercentEscapesUsingEncoding:enc]
//                             mutableCopy];
//
//    int i;
//    for (i = 0; i < len; i++) {
//
//        [temp replaceOccurrencesOfString:[escapeChars objectAtIndex:i]
//                              withString:[replaceChars objectAtIndex:i]
//                                 options:NSLiteralSearch
//                                   range:NSMakeRange(0, [temp length])];
//    }
//
//    NSString *outStr = [NSString stringWithString: temp];
//
//    return outStr;
//}

+ (void)getData:(NSString *)urlPath dinPath:(NSString *)dinPath {
	NSURL *url = [NSURL URLWithString:urlPath];
	NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
	NSURLResponse *response;
	NSError *error;
	NSData* result = [NSURLConnection sendSynchronousRequest:theRequest returningResponse:&response error:&error];
    //	if ([response suggestedFilename]) {
    //		savePath = [DEST_PATH stringByAppendingString:[response suggestedFilename]];
    //	}
	
	[result writeToFile:dinPath atomically:YES];
}

+ (BOOL)connectedToNetwork {
    // Create zero addy
    struct sockaddr_in zeroAddress;
    bzero(&zeroAddress, sizeof(zeroAddress));
    zeroAddress.sin_len = sizeof(zeroAddress);
    zeroAddress.sin_family = AF_INET;
    
    // Recover reachability flags
    SCNetworkReachabilityRef defaultRouteReachability = SCNetworkReachabilityCreateWithAddress(NULL, (struct sockaddr *)&zeroAddress);
    SCNetworkReachabilityFlags flags;
    
    BOOL didRetrieveFlags = SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags);
    CFRelease(defaultRouteReachability);
    
    if (!didRetrieveFlags)
    {
        printf("Error. Could not recover network reachability flags\n");
        return NO;
    }
    
    BOOL isReachable = ((flags & kSCNetworkFlagsReachable) != 0);
    BOOL needsConnection = ((flags & kSCNetworkFlagsConnectionRequired) != 0);
    return (isReachable && !needsConnection) ? YES : NO;
}

+ (NSData *)requestWithURL:(NSString *)urlStr {
    return [self requestWithURL:urlStr timeoutInterval:10];
}

+ (NSData *)requestWithURL:(NSString *)urlStr timeoutInterval:(NSTimeInterval)timeoutInterval {
    // 1.创建URL
    NSURL *url = [NSURL URLWithString:urlStr];
    
    // 2.通过URL创建网络请求
    NSError        *error = nil;
    NSURLResponse  *response = nil;
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url
                                                 cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
                                             timeoutInterval:timeoutInterval];
    
    // 3.连接服务器
    NSData *received = [NSURLConnection sendSynchronousRequest:request
                                             returningResponse:&response
                                                         error:&error];
    
    if (error) {
        return nil;
    }
    
    return received;
}

+ (void)asynchronousRequestWithURL:(NSString *)urlStr
{
    // 1.创建URL
    NSURL *url = [NSURL URLWithString:urlStr];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:
     ^(NSURLResponse *response, NSData *data, NSError *error) {
         //
     }];
}

@end
