//
//  YRPickerView.m
//  YRDatePicker
//
//  Created by Shenguang on 17/5/23.
//  Copyright © 2017年 Shenguang. All rights reserved.
//

#import <Masonry.h>
#import "YRPickerView.h"
#import "YRCollectionViewCell.h"
#import "UIView+Sizes.h"
#import <AudioToolbox/AudioToolbox.h>

@interface YRCollectionViewFlowLayout : UICollectionViewFlowLayout
@property (nonatomic, assign) CGFloat itemHeight;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGFloat midY;
@property (nonatomic, assign) CGFloat maxAngle;
/** 存放所有cell的布局属性 */
@property (nonatomic, strong) NSMutableArray *attrsArray;
@end


@interface YRPickerView()<UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, copy) void (^callBack)(NSInteger item);

@end


@implementation YRPickerView

+ (instancetype)pickerViewinitWithFrame:(CGRect)frame andArr:(NSArray <NSString *> * )dataArr{
    return [[self alloc]initWithFrame:frame andArr:dataArr];
}

- (instancetype)initWithFrame:(CGRect)frame andArr:(NSArray <NSString *> * )dataArr{
    if (self = [super initWithFrame:frame]) {
        self.dataArr = dataArr;
        [self setUpUI];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setUpUI];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
}

- (void)setUpUI{
    self.textFont = self.textFont ?: [UIFont systemFontOfSize:15];
    self.itemHeight = self.itemHeight ?: 20;
    self.textColor = self.textColor ?: [UIColor blackColor];
    self.itemBGColor = self.itemBGColor ?: [UIColor clearColor];
    YRCollectionViewFlowLayout *layout = [[YRCollectionViewFlowLayout alloc] init];
    [layout setScrollDirection:UICollectionViewScrollDirectionVertical];
    layout.itemHeight = self.itemHeight;
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    self.collectionView.backgroundColor = [UIColor clearColor];
    [self.collectionView registerClass:[YRCollectionViewCell class] forCellWithReuseIdentifier:@"item"];
    self.collectionView.decelerationRate = UIScrollViewDecelerationRateFast;
    self.collectionView.showsVerticalScrollIndicator = NO;
    [self addSubview:self.collectionView];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    
}

- (void)reloadData{
    [self.collectionView reloadData];
    self.collectionView.contentOffset = CGPointZero;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    YRCollectionViewCell *item = [collectionView dequeueReusableCellWithReuseIdentifier:@"item" forIndexPath:indexPath];
    item.myLabel.font = self.textFont;
    item.backgroundColor = self.itemBGColor;
    item.myLabel.textColor = self.textColor;
    NSLog(@"%@",_dataArr);
    item.myLabel.text = self.dataArr[indexPath.item];
    return item;
}

#pragma mark -LayoutDelegate

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(collectionView.width, self.itemHeight);
}

- (UIEdgeInsets)collectionView:(nonnull UICollectionView *)collectionView layout:(nonnull UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    
    NSInteger itemCount = [self collectionView:collectionView numberOfItemsInSection:section];
    
    NSIndexPath *firstIndexPath = [NSIndexPath indexPathForItem:0 inSection:section];
    CGSize firstSize = [self collectionView:collectionView layout:collectionViewLayout sizeForItemAtIndexPath:firstIndexPath];
    
    NSIndexPath *lastIndexPath = [NSIndexPath indexPathForItem:itemCount - 1 inSection:section];
    CGSize lastSize = [self collectionView:collectionView layout:collectionViewLayout sizeForItemAtIndexPath:lastIndexPath];
    
    return UIEdgeInsetsMake((collectionView.bounds.size.height - firstSize.height) / 2, 0,
                            (collectionView.bounds.size.height - lastSize.height) / 2, 0);
}

#pragma mark -scrollViewDelegate
//播放声音
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if ((int)scrollView.contentOffset.y % (int)self.itemHeight == 0) {
        
        AudioServicesPlaySystemSound(1105);
    }
}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    CGPoint center = [self convertPoint:self.collectionView.center toView:self.collectionView];
    NSIndexPath *indexPath = [self.collectionView indexPathForItemAtPoint:center];
    if ([self.delegate respondsToSelector:@selector(pickerView:didSelectItem:)]) {
        // 代理开始做事情
        [self.delegate pickerView:self didSelectItem:indexPath.row];
    }
    self.callBack(indexPath.row);
    
}

- (void)titleForItem:(void(^)(NSInteger item))callBack{
    self.callBack = callBack;
}

@end




@implementation YRCollectionViewFlowLayout

- (void)prepareLayout {
    [super prepareLayout];
    [self.attrsArray removeAllObjects];
    NSUInteger count = [self.collectionView numberOfItemsInSection:0];
    for (NSUInteger i = 0; i < count; ++i) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        UICollectionViewLayoutAttributes *attrs = [self layoutAttributesForItemAtIndexPath:indexPath];
        [self.attrsArray addObject:attrs];
    }
    self.minimumLineSpacing = 0;
    CGRect visibleRect = (CGRect){self.collectionView.contentOffset, self.collectionView.bounds.size};
    self.midY = CGRectGetMidY(visibleRect);
    self.height = CGRectGetHeight(visibleRect) / 2;
    self.maxAngle = M_PI_2;
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    [super shouldInvalidateLayoutForBoundsChange:newBounds];
    return YES;
}




- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    
    NSMutableArray *attributes = [NSMutableArray array];
    if ([self.collectionView numberOfSections]) {
        for (NSInteger i = 0; i < [self.collectionView numberOfItemsInSection:0]; i++) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
            [attributes addObject:[self layoutAttributesForItemAtIndexPath:indexPath]];
        }
    }
    return attributes;
}


//scroll 停止对中间位置进行偏移量校正
- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity {
    CGFloat offsetAdjustment = MAXFLOAT;
    ////  |-------[-------]-------|
    ////  |滑动偏移|可视区域 |剩余区域|
    //是整个collectionView在滑动偏移后的当前可见区域的中点
    CGFloat centerY = proposedContentOffset.y + (CGRectGetHeight(self.collectionView.bounds) / 2.0);
    //    CGFloat centerX = self.collectionView.center.x; //这个中点始终是屏幕中点
    //所以这里对collectionView的具体尺寸不太理解，输出的是屏幕大小，但实际上宽度肯定超出屏幕的
    
    CGRect targetRect = CGRectMake(0.0, proposedContentOffset.y, self.collectionView.bounds.size.width, self.collectionView.bounds.size.height);
    
    NSArray *array = [super layoutAttributesForElementsInRect:targetRect];
    
    for (UICollectionViewLayoutAttributes *layoutAttr in array) {
        CGFloat itemCenterY = layoutAttr.center.y;
        
        if (ABS(itemCenterY - centerY) < ABS(offsetAdjustment)) { // 找出最小的offset 也就是最中间的item 偏移量
            offsetAdjustment = itemCenterY - centerY;
        }
    }
    
    return CGPointMake(proposedContentOffset.x, proposedContentOffset.y + offsetAdjustment);
}

//放大范围
static CGFloat const ScaleFactor = 0.4;

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    UICollectionViewLayoutAttributes *attributes = [super layoutAttributesForItemAtIndexPath:indexPath];
    
    CGRect visibleRect = (CGRect){self.collectionView.contentOffset, self.collectionView.bounds.size};
    attributes.alpha = 0.5;
    
    CGFloat distance = CGRectGetMidY(visibleRect) - attributes.center.y;//距离中点的距离
    CGFloat normalizedDistance = distance / self.itemHeight;
    CATransform3D transform = CATransform3DIdentity;
    if (ABS(distance) < self.itemHeight) {
        CGFloat zoom = 1 + ScaleFactor * (1 - ABS(normalizedDistance)); //放大渐变
        transform = CATransform3DMakeScale(zoom, zoom, 1.0);
        attributes.zIndex = 1;
        attributes.alpha = 1.0;
        
    }

    CGFloat currentAngle = self.maxAngle * distance / self.height / M_PI_2 *2.5;
    if (ABS(currentAngle) > M_PI / 2.0) {
        currentAngle = M_PI / 2.0;
    }
    transform = CATransform3DRotate(transform, currentAngle, 1, 0, 0);
    attributes.transform3D = transform;
    return attributes;
}


@end
