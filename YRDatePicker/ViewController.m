//
//  ViewController.m
//  YRDatePicker
//
//  Created by Shenguang on 17/5/23.
//  Copyright © 2017年 Shenguang. All rights reserved.
//

#import <Masonry.h>
#import "ViewController.h"
#import "YRPickerView.h"
#import "YRDatePicker.h"

@interface ViewController ()<YRPickerViewDelegate,YRDatePickerDelegate>
@property (nonatomic, strong)YRPickerView *PCView;
@property (nonatomic, strong) UILabel *timeLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    YRDatePicker *datePicker = [[YRDatePicker alloc] initWithFrame:CGRectZero];
    [self.view addSubview:datePicker];
    [datePicker mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.height.width.mas_equalTo(300);
    }];
    NSMutableArray *yearArr = [[NSMutableArray alloc] init];
    for (int i = 1970; i < 2018; i++) {
        [yearArr addObject:[NSString stringWithFormat:@"%d",i]];
    }
    datePicker.yearPickView.dataArr = yearArr;
    
    datePicker.monthPickView.dataArr = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12"];
    
    NSMutableArray *dayArr = [[NSMutableArray alloc] init];
    for (int i = 1; i < 32; i++) {
        [dayArr addObject:[NSString stringWithFormat:@"%d",i]];
    }
    datePicker.dayPickView.dataArr = dayArr;
    
    datePicker.delegate = self;
    
    
    UILabel *timeLabel = [[UILabel alloc] init];
    self.timeLabel = timeLabel;
    [self.view addSubview:timeLabel];
    [timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(datePicker.mas_bottom);
        make.right.left.equalTo(self.view);
        make.height.mas_equalTo(40);
    }];
    timeLabel.text = [NSString stringWithFormat:@"%@年%@月%@日",datePicker.yearPickView.dataArr.firstObject,datePicker.monthPickView.dataArr.firstObject,datePicker.dayPickView.dataArr.firstObject];
    
    //block
//    [datePicker titleForDatePicker:^(NSString *string) {
//        timeLabel.text = string;
//    }];
    
    
    /*
    YRPickerView *PCview = [[YRPickerView alloc] init];
    self.PCView = PCview;
    [self.view addSubview:PCview];
    [PCview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(80);
        make.right.equalTo(self.view).offset(-50);
        make.left.equalTo(self.view).offset(50);
        make.bottom.equalTo(self.view).offset(-80);
    }];
    //PCview.delegate = self;
    PCview.textColor = [UIColor redColor];
    PCview.textFont = [UIFont systemFontOfSize:20];
    PCview.itemHeight = 40;
    //PCview.dataArr = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12"];
    [PCview titleForItem:^(NSInteger item) {
        NSLog(@"%ld",item);
    }];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        PCview.dataArr = @[@"34",@"3424",@"76567",@"dfg",@"fgsd"];
        //[self.PCView reloadData];
    });
     */
}

//pickView Test
//- (void)pickerView:(YRPickerView *)pickerView didSelectItem:(NSInteger)item{
//    NSLog(@"%ld",(long)item);
//}

- (void)datePicker:(YRDatePicker *)datePicker didSelectBack:(NSString *)string{
    NSLog(@"%@",string);
    self.timeLabel.text = string;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}





@end
