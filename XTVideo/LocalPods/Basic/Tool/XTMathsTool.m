//
//  XTMathsTool.m
//  Pods
//
//  Created by tage on 14-4-17.
//
//

#import "XTMathsTool.h"

@implementation XTMathsTool

- (double)spaceToItem:(UIView *)toItem fromItem:(UIView *)fromItem
{
    CGPoint fromPoint = fromItem.center;
    CGPoint toPoint = toItem.center;
    float fx = fromPoint.x - toPoint.x;
    float fy = fromPoint.y - toPoint.y;
    return sqrt(fx * fx + fy * fy);
}

@end
