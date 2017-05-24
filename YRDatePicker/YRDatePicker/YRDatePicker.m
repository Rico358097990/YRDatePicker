//
//  YRDatePicker.m
//  YRDatePicker
//
//  Created by Shenguang on 17/5/24.
//  Copyright © 2017年 Shenguang. All rights reserved.
//

#import "YRDatePicker.h"
#import "YRPickerView.h"
#import <Masonry.h>

@interface YRDatePicker()<YRPickerViewDelegate>

@property (nonatomic, strong) UILabel *yearLabel;
@property (nonatomic, strong) UILabel *monthLabel;
@property (nonatomic, strong) UILabel *dayLabel;

@property (nonatomic, copy) void (^callBack)(NSString *string);

@end


@implementation YRDatePicker

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setUpUI];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [self.yearPickView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.left.equalTo(self);
        make.bottom.equalTo(self);
    }];
    
    [self.yearLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.left.equalTo(self.yearPickView.mas_right);
        make.bottom.equalTo(self);
        make.width.equalTo(self.yearPickView);
    }];
    
    [self.monthPickView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.left.equalTo(self.yearLabel.mas_right);
        make.bottom.equalTo(self);
        make.width.equalTo(self.yearPickView);
    }];
    
    [self.monthLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.left.equalTo(self.monthPickView.mas_right);
        make.bottom.equalTo(self);
        make.width.equalTo(self.yearPickView);
    }];
    
    [self.dayPickView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.left.equalTo(self.monthLabel.mas_right);
        make.bottom.equalTo(self);
        make.width.equalTo(self.yearPickView);
    }];
    
    [self.dayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.left.equalTo(self.dayPickView.mas_right);
        make.bottom.equalTo(self);
        make.right.equalTo(self);
        make.width.equalTo(self.yearPickView);
    }];
    
    
}

- (void)setUpUI{
    self.textFont = self.textFont ?: [UIFont systemFontOfSize:12];
    //年
    YRPickerView *yearPickView = [[YRPickerView alloc] initWithFrame:CGRectZero];
    self.yearPickView = yearPickView;
    yearPickView.delegate = self;
    yearPickView.textColor = [UIColor redColor];
    yearPickView.textFont = self.textFont;
    [self addSubview:yearPickView];
    
    UILabel *yearLabel = [[UILabel alloc] init];
    self.yearLabel = yearLabel;
    yearLabel.text = @"年";
    yearLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:yearLabel];
    
    //月
    YRPickerView *monthPickView = [[YRPickerView alloc] initWithFrame:CGRectZero];
    self.monthPickView = monthPickView;
    monthPickView.delegate = self;
    monthPickView.textColor = [UIColor purpleColor];
    monthPickView.textFont = self.textFont;
    [self addSubview:monthPickView];
    
    UILabel *monthLabel = [[UILabel alloc] init];
    self.monthLabel = monthLabel;
    monthLabel.text = @"月";
    monthLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:monthLabel];
    
    //日
    YRPickerView *dayPickView = [[YRPickerView alloc] initWithFrame:CGRectZero];
    self.dayPickView = dayPickView;
    dayPickView.delegate = self;
    dayPickView.textColor = [UIColor lightGrayColor];
    dayPickView.textFont = self.textFont;
    [self addSubview:dayPickView];
    
    UILabel *dayLabel = [[UILabel alloc] init];
    self.dayLabel = dayLabel;
    dayLabel.text = @"日";
    dayLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:dayLabel];
    
}

- (void)titleForDatePicker:(void(^)(NSString *string))callBack{
    self.callBack = callBack;
}

#pragma mark -YRPickerView delegate
- (void)pickerView:(YRPickerView *)pickerView didSelectItem:(NSInteger)item{

    if ([self.delegate respondsToSelector:@selector(datePicker:didSelectBack:)]) {
        [self.delegate datePicker:self didSelectBack:[NSString stringWithFormat:@"%@年%@月%@日",self.yearPickView.title,self.monthPickView.title,self.dayPickView.title]];
    }
    if (self.callBack) {
        self.callBack([NSString stringWithFormat:@"%@年%@月%@日",self.yearPickView.title,self.monthPickView.title,self.dayPickView.title]);
    }
}



@end
