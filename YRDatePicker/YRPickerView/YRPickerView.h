//
//  YRPickerView.h
//  YRDatePicker
//
//  Created by Shenguang on 17/5/23.
//  Copyright © 2017年 Shenguang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YRPickerView;

@protocol YRPickerViewDelegate <NSObject>

@optional
- (void)pickerView:(YRPickerView *)pickerView didSelectItem:(NSInteger)item;

@end


@interface YRPickerView : UIView 
@property (nonatomic, weak) id <YRPickerViewDelegate> delegate;
@property (nonatomic, strong) NSArray <NSString *>*dataArr;
@property (nonatomic, strong) NSString *title;

//coustom自定义
///每个item的高度
@property (nonatomic, assign) CGFloat itemHeight;
///文字字体
@property (nonatomic, strong) UIFont *textFont;
///文字颜色
@property (nonatomic, strong) UIColor *textColor;
///item背景颜色
@property (nonatomic, strong) UIColor *itemBGColor;

+ (instancetype)pickerViewinitWithFrame:(CGRect)frame andArr:(NSArray <NSString *> * )dataArr;

- (void)titleForItem:(void(^)(NSInteger item))callBack;

- (void)reloadData;
@end


