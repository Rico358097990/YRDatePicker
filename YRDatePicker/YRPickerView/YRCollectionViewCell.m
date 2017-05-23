//
//  YRCollectionViewCell.m
//  YRDatePicker
//
//  Created by Shenguang on 17/5/23.
//  Copyright © 2017年 Shenguang. All rights reserved.
//

#import <Masonry.h>
#import "YRCollectionViewCell.h"

@interface YRCollectionViewCell()


@end


@implementation YRCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        _myLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _myLabel.textAlignment = NSTextAlignmentCenter;
        _myLabel.textColor = [UIColor blackColor];
        _myLabel.font = [UIFont systemFontOfSize:15];
        _myLabel.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:_myLabel];
    }
    
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [self.myLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
}


@end
