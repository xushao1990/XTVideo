//
//  XTTInitView.m
//  GT
//
//  Created by tage on 13-11-11.
//  Copyright (c) 2013年 kaakoo. All rights reserved.
//

#import "XTNormalView.h"

@implementation XTNormalView

+ (UIImageView *)XTImageViewWithNormalImage:(UIImage *)image highlightedImage:(UIImage *)highlightedImage frame:(CGRect)rect
{
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:rect];
    if (image) {
        imageView.image = image;
    }
    if (highlightedImage) {
        imageView.highlightedImage = highlightedImage;
    }
    return imageView;
}

+ (UIButton *)XTCustomImageButtonWithFrame:(CGRect)rect customImage:(UIImage *)customImage selectImage:(UIImage *)selectImage
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = rect;
    [button setImage:customImage forState:UIControlStateNormal];
    [button setImage:selectImage forState:UIControlStateHighlighted];
    return button;
}

@end
