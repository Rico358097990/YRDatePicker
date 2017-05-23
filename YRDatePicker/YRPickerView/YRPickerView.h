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

@protocol YRPickerViewDataSource <NSObject>

@required
- (NSUInteger)numberOfItemsInPickerView:(YRPickerView *)pickerView;
- (NSString *)pickerView:(YRPickerView *)pickerView titleForItem:(NSInteger)item;
@end

@interface YRPickerView : UIView 
@property (nonatomic, weak) id <YRPickerViewDelegate> delegate;
@property (nonatomic, weak) id <YRPickerViewDataSource> dataSource;
@property (nonatomic, strong) NSArray <NSString *>*dataArr;
//coustom自定义
@property (nonatomic, assign) CGFloat itemHeight;
@property (nonatomic, strong) UIFont *textFont;
@property (nonatomic, strong) UIColor *textColor;
@property (nonatomic, strong) UIColor *itemBGColor;

+ (instancetype)pickerViewinitWithFrame:(CGRect)frame andArr:(NSArray <NSString *> * )dataArr;

- (void)titleForItem:(void(^)(NSInteger item))callBack;
- (void)reloadData;
@end


