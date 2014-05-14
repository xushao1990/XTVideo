//
//  XTTInitView.h
//  GT
//
//  Created by tage on 13-11-11.
//  Copyright (c) 2013年 kaakoo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XTNormalView : NSObject

/**
 *  返回ImageView
 *
 */
+ (UIImageView *)XTImageViewWithNormalImage:(UIImage *)image highlightedImage:(UIImage *)highlightedImage frame:(CGRect)rect;
/**
 *  返回Button
 *
 */
+ (UIButton *)XTCustomImageButtonWithFrame:(CGRect)rect customImage:(UIImage *)customImage selectImage:(UIImage *)selectImage;

@end
