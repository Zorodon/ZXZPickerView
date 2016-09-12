//
//  ZXZDatePicker.m
//  beilu
//
//  Created by YKJ2 on 16/4/6.
//  Copyright © 2016年 YKJ2. All rights reserved.
//

#import "ZXZDatePicker.h"

#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

@interface ZXZDatePicker()
@property (strong, nonatomic) UIDatePicker *datePicker;
@property (strong, nonatomic) UIView *backgroundView;
@end

@implementation ZXZDatePicker
- (instancetype)init {
    self = [super init];
    if (self) {
        NSDateFormatter *format = [[NSDateFormatter alloc] init];
        [format setDateFormat:@"yyyy-MM-dd"];//日期格式
        NSDate *date = [format dateFromString:@"1990-01-01"];
        if (date&&self.datePicker){
            self.datePicker.date = date;
        }
    }
    return self;
}
- (instancetype)initWithDate:(NSString *)str{
    self = [self initWithFrame:CGRectZero];
    if (self) {
        NSDateFormatter *format = [[NSDateFormatter alloc] init];
        [format setDateFormat:@"yyyy-MM-dd"];//日期格式
        NSDate *date = [format dateFromString:str];
        if (date&&self.datePicker){
            self.datePicker.date = date;
        }
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initView];
    }
    return self;
}
//初始化界面
- (void)initView {
    //遮罩层布局
    self.backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    self.backgroundView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
    [[UIApplication sharedApplication].keyWindow addSubview:self.backgroundView];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];//点击背景取消
    [self.backgroundView addGestureRecognizer:tap];
    //主体布局
    self.frame = CGRectMake(0, kScreenHeight+100, kScreenWidth, 260);
    self.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
    [self.backgroundView addSubview:self];
    
    self.datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(10, 260-216, kScreenWidth-20, 216)];
    self.datePicker.backgroundColor = [UIColor whiteColor];
    self.datePicker.datePickerMode = UIDatePickerModeDate;//日期类型
//        self.datePicker.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;//可以自定义高度
    [self addSubview:self.datePicker];
    //取消按钮
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    cancelBtn.frame = CGRectMake(10, 10, 80, 30);
    cancelBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(cancelAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:cancelBtn];
    //确定按钮
    UIButton *doneBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    doneBtn.frame = CGRectMake(kScreenWidth-10-80, 10, 80, 30);
    doneBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [doneBtn setTitle:@"确定" forState:UIControlStateNormal];
    [doneBtn addTarget:self action:@selector(doneAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:doneBtn];
}

- (void)showDatePicker {
    if (self.backgroundView) {
        self.backgroundView.alpha = 0;
        [UIView animateWithDuration:0.3 animations:^{
            self.backgroundView.alpha = 1;
            self.frame = CGRectMake(0, kScreenHeight-260, kScreenWidth, 260);
        }];
    }
}
- (void)hideDatePicker {
    if (self.backgroundView) {
        [UIView animateWithDuration:0.3 animations:^{
            self.backgroundView.alpha = 0;
            self.frame = CGRectMake(0, kScreenHeight-260, kScreenWidth, 260);
        } completion:^(BOOL finished) {
            [self.backgroundView removeFromSuperview];
        }];
    }
}

#pragma mark - Action
- (void)tapAction:(UITapGestureRecognizer *)gesture {
    CGPoint loc = [gesture locationInView:self.backgroundView];
    if (loc.y<kScreenHeight-260) {
        [self cancelAction:nil];
    }
}
- (void)cancelAction:(id)sender {
    [self hideDatePicker];
    if (self.delegate && [self.delegate respondsToSelector:@selector(cancelSelectInZXZDatePicker:)]) {
        [self.delegate cancelSelectInZXZDatePicker:self];
    }
}
- (void)doneAction:(id)sender {
    [self hideDatePicker];
    if (self.delegate && [self.delegate respondsToSelector:@selector(datePicker:didSelectDate:)]) {
        NSDateFormatter *format = [[NSDateFormatter alloc] init];
        [format setDateFormat:@"yyyy-MM-dd"];//日期格式
        NSString *str = [format stringFromDate:self.datePicker.date];
        [self.delegate datePicker:self didSelectDate:str];
    }
}
@end
