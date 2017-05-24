//
//  YRDatePicker.h
//  YRDatePicker
//
//  Created by Shenguang on 17/5/24.
//  Copyright © 2017年 Shenguang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YRDatePicker;
@class YRPickerView;

@protocol YRDatePickerDelegate <NSObject>

@optional
- (void)datePicker:(YRDatePicker *)datePicker didSelectBack:(NSString *)string;

@end

@interface YRDatePicker : UIView

@property (nonatomic, weak) id <YRDatePickerDelegate> delegate;
@property (nonatomic, strong) YRPickerView *yearPickView;
@property (nonatomic, strong) YRPickerView *monthPickView;
@property (nonatomic, strong) YRPickerView *dayPickView;
//coustom 自定义
@property (nonatomic, strong) UIFont *textFont;

- (void)titleForDatePicker:(void(^)(NSString *string))callBack;
@end
