//
//  XTViewAnimator.m
//  Pods
//
//  Created by tage on 14-4-17.
//
//

#import "XTViewAnimator.h"

@implementation XTViewAnimator

+ (void)shakeAnimation:(UIView *)view
{
    CGFloat rotation = 0.03;
    CABasicAnimation *shake = [CABasicAnimation animationWithKeyPath:@"transform"];
    shake.duration = 0.13;
    shake.autoreverses = YES;
    shake.repeatCount  = MAXFLOAT;
    shake.removedOnCompletion = NO;
    shake.fromValue = [NSValue valueWithCATransform3D:CATransform3DRotate(view.layer.transform,-rotation, 0.0 ,0.0 ,1.0)];
    shake.toValue   = [NSValue valueWithCATransform3D:CATransform3DRotate(view.layer.transform, rotation, 0.0 ,0.0 ,1.0)];
    [view.layer addAnimation:shake forKey:@"shakeAnimation"];
}

@end
