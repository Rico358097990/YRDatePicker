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

@interface ViewController ()<YRPickerViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UIPickerView
    
    
    YRPickerView *PCview = [[YRPickerView alloc] init];
    [self.view addSubview:PCview];
    [PCview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    //PCview.delegate = self;
    PCview.textColor = [UIColor redColor];
    PCview.itemBGColor = [UIColor lightGrayColor];
    PCview.textFont = [UIFont systemFontOfSize:20];
    PCview.itemHeight = 40;
    PCview.dataArr = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12"];
    [PCview titleForItem:^(NSInteger item) {
        NSLog(@"%ld",item);
    }];
}


//- (void)pickerView:(YRPickerView *)pickerView didSelectItem:(NSInteger)item{
//    NSLog(@"%ld",(long)item);
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
