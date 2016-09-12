//
//  ZXZDatePicker.h
//  beilu
//
//  Created by YKJ2 on 16/4/6.
//  Copyright © 2016年 YKJ2. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZXZDatePicker;
@protocol ZXZDatePickerDelegate <NSObject>
@optional
- (void)datePicker:(ZXZDatePicker *)datePicker didSelectDate:(NSString *)date;  //确定事件，返回选中日期
- (void)cancelSelectInZXZDatePicker:(ZXZDatePicker *)datePicker;                //取消事件
@end


@interface ZXZDatePicker : UIView
@property (weak, nonatomic) id<ZXZDatePickerDelegate> delegate;
- (instancetype)init;                           //默认日期
- (instancetype)initWithDate:(NSString *)str;   //跳到指定日期
- (void)showDatePicker;     //显示
- (void)hideDatePicker;     //隐藏
@end
