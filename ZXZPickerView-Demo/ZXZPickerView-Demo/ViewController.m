//
//  ViewController.m
//  ZXZPickerView
//
//  Created by YKJ2 on 16/9/12.
//  Copyright © 2016年 AAA. All rights reserved.
//

#import "ViewController.h"
#import "ZXZPickerView.h"
#import "ZXZDatePicker.h"

@interface ViewController ()<ZXZPickerViewDelegate,ZXZDatePickerDelegate>
@property (strong, nonatomic) NSArray *contentArr;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.contentArr = @[@"123",@"abc",@"ABC",@"123",@"abc",@"ABC",@"123",@"abc",@"ABC"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (IBAction)show1Action:(id)sender {
    ZXZPickerView *pickerView = [[ZXZPickerView alloc]initWithContent:self.contentArr];
//    ZXZPickerView *pickerView = [[ZXZPickerView alloc]initWithContent:self.contentArr index:self.contentArr.count-1];
    pickerView.delegate = self;
    [pickerView showPickerView];
}

- (IBAction)show2Action:(id)sender {
    ZXZDatePicker *datePicker = [[ZXZDatePicker alloc] init];
//    ZXZDatePicker *datePicker = [[ZXZDatePicker alloc] initWithDate:@"2000-01-01"];
    datePicker.delegate = self;
    [datePicker showDatePicker];
}

#pragma mark - ZXZPickerViewDelegate
- (void)pickerView:(ZXZPickerView *)pickerView didSelectRow:(NSInteger )row {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:self.contentArr[row] preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *doneAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:doneAction];
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark - ZXZDatePickerDelegate
- (void)datePicker:(ZXZDatePicker *)datePicker didSelectDate:(NSString *)date {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:date preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *doneAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:doneAction];
    [self presentViewController:alert animated:YES completion:nil];
}

@end
