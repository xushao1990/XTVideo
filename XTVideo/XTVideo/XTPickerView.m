//
//  XTPickerView.m
//  XTVideo
//
//  Created by tage on 14-5-20.
//  Copyright (c) 2014年 NULL. All rights reserved.
//

#import "XTPickerView.h"

@interface XTPickerView ()

@property (nonatomic, copy) XTPickerViewSubmitBlock block;

@property (nonatomic, strong) UIView *whiteView;

@property (nonatomic, copy) NSString *currentValue;

@end

@implementation XTPickerView

+ (void)pickViewShowWithSubmitBlock:(XTPickerViewSubmitBlock)block
{
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    XTPickerView *view = [[XTPickerView alloc] initWithFrame:window.bounds];
    view.block = block;
    [window addSubview:view];
    [view pickerViewShowAnimation];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0];
        self.currentValue = @"1";
        [self addPickerView];
    }
    return self;
}

- (void)addPickerView
{
    _whiteView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(self.frame), 320, 202)];
    _whiteView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_whiteView];
    
    UIButton *cancle = ({
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(10, 0, 50, 40);
        [button addTarget:self action:@selector(cancelAction:) forControlEvents:UIControlEventTouchUpInside];
        [button setTitle:@"取消" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        button;
    });
    [_whiteView addSubview:cancle];
    
    UIButton *submit = ({
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(260, 0, 50, 40);
        [button addTarget:self action:@selector(submitAction:) forControlEvents:UIControlEventTouchUpInside];
        [button setTitle:@"确定" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        button;
    });
    [_whiteView addSubview:submit];
    
    UIPickerView *picker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 40, 320, 162)];
    picker.dataSource = self;
    picker.delegate = self;
    [_whiteView addSubview:picker];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return 20;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    return 100;
}
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 60;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [NSString stringWithFormat:@"%d",(int)row + 1];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    _currentValue = [NSString stringWithFormat:@"%d",(int)row + 1];
}

- (void)cancelAction:(id)sender
{
    [self pickerViewHideAnition];
}

- (void)submitAction:(id)sender
{
    [self pickerViewHideAnition];
    if (self.block) {
        self.block(_currentValue);
    }
}

- (void)pickerViewShowAnimation
{
    [UIView animateWithDuration:0.3 animations:^{
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
       _whiteView.frame = CGRectMake(0, CGRectGetHeight(self.frame) - 202, 320, 202);
    }];
}

- (void)pickerViewHideAnition
{
    [UIView animateWithDuration:0.3 animations:^{
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0];
        _whiteView.center = CGPointMake(CGRectGetMidX(_whiteView.frame), CGRectGetMidY(_whiteView.frame) + CGRectGetHeight(_whiteView.frame));
    }completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (void)dealloc
{
    DLog();
}

@end
