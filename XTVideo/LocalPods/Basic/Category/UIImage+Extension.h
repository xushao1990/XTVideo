//
//  UIImage+Extension.h
//  CocoapodTest
//
//  Created by tage on 14-4-9.
//  Copyright (c) 2014年 cn.kaakoo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Extension)

#pragma mark - 改变图片大小

//- (UIImage *)imageToFitSize:(CGSize)size method:(MGImageResizingMethod)resizeMethod;

- (UIImage *)imageScaledToFitSize:(CGSize)size; // uses MGImageResizeScale

- (UIImage *)imageCroppedToFitSize:(CGSize)size; // 用这个改变大小后最好要压缩，这个玩意儿改变大小后有时会比原图还大，次奥

#pragma mark - 加roundCorner

- (UIImage *)roundedCornerImage:(NSInteger)cornerSize borderSize:(NSInteger)borderSize;

#pragma mark - Tint

- (UIImage *) imageWithTintColor:(UIColor *)tintColor;

- (UIImage *) imageWithGradientTintColor:(UIColor *)tintColor;

#pragma mark - Effect

- (UIImage *)applyLightEffect;
- (UIImage *)applyExtraLightEffect;
- (UIImage *)applyDarkEffect;
- (UIImage *)applyTintEffectWithColor:(UIColor *)tintColor;

- (UIImage *)applyBlurWithRadius:(CGFloat)blurRadius tintColor:(UIColor *)tintColor saturationDeltaFactor:(CGFloat)saturationDeltaFactor maskImage:(UIImage *)maskImage;


@end
