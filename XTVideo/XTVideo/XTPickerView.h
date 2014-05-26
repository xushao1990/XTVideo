//
//  XTPickerView.h
//  XTVideo
//
//  Created by tage on 14-5-20.
//  Copyright (c) 2014年 NULL. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^XTPickerViewSubmitBlock)(NSString *string);

@interface XTPickerView : UIView<UIPickerViewDataSource,UIPickerViewDelegate>

+ (void)pickViewShowWithSubmitBlock:(XTPickerViewSubmitBlock)block;

@end
