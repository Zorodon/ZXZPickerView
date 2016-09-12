//
//  CustomPickerView.h
//  beilu
//
//  Created by YKJ2 on 16/4/5.
//  Copyright © 2016年 YKJ2. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZXZPickerView;
@protocol ZXZPickerViewDelegate <NSObject>
@optional
- (void)pickerView:(ZXZPickerView *)pickerView didSelectRow:(NSInteger )row;    //确定事件，返回选中行
- (void)cancelSelectInZXZPickerView:(ZXZPickerView *)pickerView;                //取消事件
@end


@interface ZXZPickerView : UIView
@property (weak, nonatomic) id<ZXZPickerViewDelegate> delegate;
- (instancetype)initWithContent:(NSArray *)array;   //初始化数组
- (instancetype)initWithContent:(NSArray *)array index:(NSInteger)idx;   //初始化数组，跳到指定位置
- (void)showPickerView;     //显示
- (void)hidePickerView;     //隐藏
@end
