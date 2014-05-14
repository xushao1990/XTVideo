//
//  XTTImage.m
//  GT
//
//  Created by tage on 13-9-9.
//  Copyright (c) 2013年 Targtime. All rights reserved.
//

#import "XTImage.h"

@implementation XTImage

+ (UIImage *)XTNormalImageNamed:(NSString *)imageName
{
    NSString *imagePath;
    if ((imagePath = [[NSBundle mainBundle] pathForResource:imageName ofType:@"png"])) {
        UIImage *image = [UIImage imageWithContentsOfFile:imagePath];
        return image;
    }else{
        NSLog(@"图片:%@不存在",imageName);
        return nil;
    }
}

+ (UIImage *)XTRetinaImageNamed:(NSString *)imageName
{
    NSString *string = [NSString stringWithFormat:@"%@%@",imageName,@"@2x"];
    UIImage *image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:string ofType:@"png"]];
    return image;
}

+ (UIImage *)XTImageNamed:(NSString *)imageName
{
    return [self XTImageWithBundleName:nil imageName:imageName];
}

+ (UIImage *)XTImageWithBundleName:(NSString *)bundleName imageName:(NSString *)imageName
{
    NSBundle *bundle = bundleName ? [NSBundle bundleWithURL:[[NSBundle mainBundle] URLForResource:bundleName withExtension:@"bundle"]] : [NSBundle mainBundle];
    
    NSString *fullImageName;
    
    if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)] && [[UIScreen mainScreen] scale] == 2){
        
        fullImageName = [imageName stringByAppendingString:@"@2x"];
        
    }else{
        
        fullImageName = imageName;
    }
        
    if ((fullImageName = [bundle pathForResource:fullImageName ofType:@"png"])) {
        
        return [UIImage imageWithContentsOfFile:fullImageName];

    }else if ((fullImageName = [bundle pathForResource:imageName ofType:@"png"])){
        
        return [UIImage imageWithContentsOfFile:fullImageName];
        
    }else {
        
        NSLog(@"图片:%@不存在",imageName);
        
        return nil;
    }
}


@end
