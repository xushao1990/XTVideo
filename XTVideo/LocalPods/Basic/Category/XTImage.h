//
//  XTTImage.h
//  GT
//
//  Created by tage on 13-9-9.
//  Copyright (c) 2013年 Targtime. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XTImage : UIImage

/**
 *  返回名字为imageName的图片，不会做Retina的适配
 *
 */
+ (UIImage *)XTNormalImageNamed:(NSString *)imageName;
/**
 *  返回名字为imageName@2x的图片，不会做非Retina的适配
 *
 */
+ (UIImage *)XTRetinaImageNamed:(NSString *)imageName;

/**
 *  Retina屏下返回名字为imageName@2x的图片
 *
 *  非Retina屏下返回名字为imageName@的图片
 */

+ (UIImage *)XTImageNamed:(NSString *)imageName;

/**
 *  返回bundle包下的图片
 */

+ (UIImage *)XTImageWithBundleName:(NSString *)bundleName imageName:(NSString *)imageName;

@end
