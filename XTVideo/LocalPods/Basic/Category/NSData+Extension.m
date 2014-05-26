//
//  NSData+Extension.m
//  CocoapodTest
//
//  Created by tage on 14-4-9.
//  Copyright (c) 2014年 cn.kaakoo. All rights reserved.
//

#import "NSData+Extension.h"
#import <CommonCrypto/CommonDigest.h>
#import <ImageIO/ImageIO.h>

@implementation NSData (Extension)

- (NSData*) MD5 {
	unsigned int outputLength = CC_MD5_DIGEST_LENGTH;
	unsigned char output[outputLength];
	
	CC_MD5(self.bytes, (unsigned int) self.length, output);
	return [NSMutableData dataWithBytes:output length:outputLength];
}

- (NSData*) SHA1 {
	unsigned int outputLength = CC_SHA1_DIGEST_LENGTH;
	unsigned char output[outputLength];
	
	CC_SHA1(self.bytes, (unsigned int) self.length, output);
	return [NSMutableData dataWithBytes:output length:outputLength];
}

- (NSData*) SHA256 {
	unsigned int outputLength = CC_SHA256_DIGEST_LENGTH;
	unsigned char output[outputLength];
	
	CC_SHA256(self.bytes, (unsigned int) self.length, output);
	return [NSMutableData dataWithBytes:output length:outputLength];
}

- (NSString *)dataIdentify
{
    if (self) {
        NSInteger length = self.length;
        if (length >= 6) {
            NSData *firstData = [self subdataWithRange:NSMakeRange(length / 2, 3)];
            NSData *secendData = [self subdataWithRange:NSMakeRange(length - 6, 3)];
            NSData *thirdData = [self subdataWithRange:NSMakeRange(3, 3)];
            NSMutableData *signData = [NSMutableData data];
            [signData appendData:firstData];
            [signData appendData:secendData];
            [signData appendData:thirdData];
            NSInteger dataHash = [signData hash];
            return [NSString stringWithFormat:@"%ld",(long)dataHash];
        }else{
            return [NSString stringWithFormat:@"%lu",(unsigned long)self.hash];
        }
    }
    return @"";
}

- (UIImage *)praseGIFDataFirstImage
{
    CGImageSourceRef src = CGImageSourceCreateWithData((__bridge CFDataRef)self, NULL);
    UIImage *image;
    if (src)
    {
        size_t l = CGImageSourceGetCount(src);
        
        if (l > 0) {
            
            CGImageRef img = CGImageSourceCreateImageAtIndex(src, 0, NULL);
            
            image = [UIImage imageWithCGImage:img];
            
            CGImageRelease(img);
        }
        
        CFRelease(src);
    }
    
    if (image) {
        return image;
    }
    return nil;
}

@end
