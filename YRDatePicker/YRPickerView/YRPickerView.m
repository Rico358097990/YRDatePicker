//
//  YRPickerView.m
//  YRDatePicker
//
//  Created by Shenguang on 17/5/23.
//  Copyright © 2017年 Shenguang. All rights reserved.
//

#import "YRPickerView.h"

@interface YRPickerView()<UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;


@end


@implementation YRPickerView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setUpUI];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
}

- (void)setUpUI{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    [layout setScrollDirection:UICollectionViewScrollDirectionVertical];
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    [self addSubview:self.collectionView];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
}

@end
