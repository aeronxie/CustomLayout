//
//  CustomLayout.m
//  CustomLayout
//
//  Created by Fay on 16/3/12.
//  Copyright © 2016年 Fay. All rights reserved.
//

#import "LineLayout.h"

@implementation LineLayout

- (instancetype)init {
    if (self = [super init]) {
    }
    return self;
}

/**
 * 用来做布局的初始化操作
 */
- (void)prepareLayout
{
    [super prepareLayout];
    // 水平滚动
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
   // 设置内边距
    CGFloat inset = (self.collectionView.frame.size.width - self.itemSize.width) * 0.5;
    self.sectionInset = UIEdgeInsetsMake(0, inset, 0, inset);
}

/**
 * 当collectionView的显示范围发生改变的时候，是否需要重新刷新布局
 * 一旦重新刷新布局，就会重新调用 layoutAttributesForElementsInRect:方法
 */
-(BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return YES;
}


/**
 * 返回的数组里面存放着rect范围内所有元素的布局属性
 * 这个方法的返回值决定了rect范围内所有元素的排布（frame）
 * 一个cell对应一个UICollectionViewLayoutAttributes对象
 */
-(NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    
    //取出父类算出的布局属性
    NSArray *attsArray = [super layoutAttributesForElementsInRect:rect];
    
    //collectionView中心点的值
    CGFloat centerX = self.collectionView.frame.size.width / 2 + self.collectionView.contentOffset.x;
    
    //一个个取出来进行更改
    for (UICollectionViewLayoutAttributes *atts in attsArray) {
        // cell的中心点x 和 collectionView最中心点的x值 的间距
        CGFloat space = ABS(atts.center.x - centerX);
        CGFloat scale = 1 - space/self.collectionView.frame.size.width;
        atts.transform = CGAffineTransformMakeScale(scale, scale);
        
    }
    return attsArray;
}

/**
 * 这个方法的返回值，就决定了collectionView停止滚动时的偏移量
 */
-(CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity {
    
     // 计算出最终显示的矩形框
    CGRect rect;
    rect.origin.y = 0;
    rect.origin.x = proposedContentOffset.x;//最终要停下来的X
    rect.size = self.collectionView.frame.size;
    
    //获得计算好的属性
    NSArray *attsArray = [super layoutAttributesForElementsInRect:rect];
    //计算collection中心点X
    CGFloat centerX = proposedContentOffset.x + self.collectionView.frame.size.width / 2;
    
    CGFloat minSpace = MAXFLOAT;
    for (UICollectionViewLayoutAttributes *attrs in attsArray) {
        
        if (ABS(minSpace) > ABS(attrs.center.x - centerX)) {
            minSpace = attrs.center.x - centerX;
        }
    }
    // 修改原有的偏移量
    proposedContentOffset.x += minSpace;
    return proposedContentOffset;

}
@end
