//
//  CustomPickerView.m
//  beilu
//
//  Created by YKJ2 on 16/4/5.
//  Copyright © 2016年 YKJ2. All rights reserved.
//

#import "ZXZPickerView.h"

#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

@interface ZXZPickerView()<UIPickerViewDelegate,UIPickerViewDataSource>
@property (strong, nonatomic) UIView *backgroundView;   //遮罩层
@property (strong, nonatomic) UIPickerView *pickerView;
@property (strong, nonatomic) NSArray *dataArr;
@property (assign, nonatomic) NSInteger selectRow;
@end

@implementation ZXZPickerView
- (instancetype)initWithContent:(NSArray *)array {
    self = [self initWithFrame:CGRectZero];
    if (self) {
        self.dataArr = array;
        self.pickerView.delegate = self;
    }
    return self;
}
- (instancetype)initWithContent:(NSArray *)array index:(NSInteger)idx {
    self = [self initWithFrame:CGRectZero];
    if (self) {
        self.dataArr = array;
        self.pickerView.delegate = self;
        if (idx<array.count) {
            self.selectRow = idx;
            [self.pickerView selectRow:idx inComponent:0 animated:NO];
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
    
    self.pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(10, 260-216, kScreenWidth-20, 216)];
    self.pickerView.backgroundColor = [UIColor whiteColor];
    self.pickerView.showsSelectionIndicator = YES;
//    self.pickerView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;//可以自定义高度
    [self addSubview:self.pickerView];
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

- (void)showPickerView {
    if (self.backgroundView) {
        self.backgroundView.alpha = 0;
        [UIView animateWithDuration:0.3 animations:^{
            self.backgroundView.alpha = 1;
            self.frame = CGRectMake(0, kScreenHeight-260, kScreenWidth, 260);
        }];
    }
}
- (void)hidePickerView {
    if (self.backgroundView) {
        [UIView animateWithDuration:0.3 animations:^{
            self.backgroundView.alpha = 0;
            self.frame = CGRectMake(0, kScreenHeight-260, kScreenWidth, 260);
        } completion:^(BOOL finished) {
            [self.backgroundView removeFromSuperview];
        }];
    }
}

#pragma mark - UIPickerViewDelegate
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return self.dataArr.count;
}

- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return self.dataArr[row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    self.selectRow = row;
}

////自定义字体大小，不过失去原有放大效果
//- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
//    
//    UILabel *pickerLabel = (UILabel *)view;
//    if (pickerLabel == nil) {
//        pickerLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 80)];
//        [pickerLabel setTextAlignment:NSTextAlignmentCenter];
//        [pickerLabel setBackgroundColor:[UIColor clearColor]];
//        [pickerLabel setFont:[UIFont systemFontOfSize:18]];
//    }
//    
//    [pickerLabel setText:[self.dataArr objectAtIndex:row]];
//    return pickerLabel;
//}

#pragma mark - Action
- (void)tapAction:(UITapGestureRecognizer *)gesture {
    CGPoint loc = [gesture locationInView:self.backgroundView];
    if (loc.y<kScreenHeight-260) {
        [self cancelAction:nil];
    }
}

- (void)cancelAction:(id)sender {
    [self hidePickerView];
    if (self.delegate && [self.delegate respondsToSelector:@selector(cancelSelectInZXZPickerView:)]) {
        [self.delegate cancelSelectInZXZPickerView:self];
    }

}
- (void)doneAction:(id)sender {
    [self hidePickerView];
    if (self.delegate && [self.delegate respondsToSelector:@selector(pickerView:didSelectRow:)]) {
        [self.delegate pickerView:self didSelectRow:self.selectRow];
    }

}

@end
