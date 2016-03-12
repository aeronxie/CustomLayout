//
//  CircleLayout.m
//  CustomLayout
//
//  Created by Fay on 16/3/12.
//  Copyright © 2016年 Fay. All rights reserved.
//

#import "CircleLayout.h"

@interface CircleLayout ()
@property (nonatomic,strong) NSMutableArray *attrsArray;
@end

@implementation CircleLayout

-(void)prepareLayout {
    
    [super prepareLayout];
    
    [self.attrsArray removeAllObjects];
    //因为是一次性就显示在view上，所以可以一次性初始化
    //collection一共有多少item
    NSInteger count = [self.collectionView numberOfItemsInSection:0];
    for (NSInteger i=0; i<count; i++) {
        //自己写布局属性
        UICollectionViewLayoutAttributes *attrs = [self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForItem:i inSection:0]];
        [self.attrsArray addObject:attrs];
    }
    
}

/**
 * 返回所有布局属性
 */
- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
    return self.attrsArray;
}

/**
 * 返回indexPath位置对应cell的布局属性
 */
-(UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSInteger count = [self.collectionView numberOfItemsInSection:0];
    CGFloat radius = 120;
    
    //圆心
    CGFloat circleX = self.collectionView.frame.size.width / 2;
    CGFloat circleY = self.collectionView.frame.size.height / 2;
    
    UICollectionViewLayoutAttributes *attrs = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    attrs.size = CGSizeMake(60, 60);
    //如果还剩下一个cell
    if (count == 1) {
        attrs.center = CGPointMake(circleX, circleY);
        attrs.size = CGSizeMake(150, 150);
    }else {
        CGFloat angle = (2 * M_PI / count) * indexPath.item;//每一个cell的角度
        CGFloat centerX = circleX + radius * sin(angle);
        CGFloat centerY = circleY + radius * cos(angle);
        attrs.center = CGPointMake(centerX, centerY);
    }
    
    return attrs;
}


-(NSMutableArray *)attrsArray {
    
    if (!_attrsArray) {
        _attrsArray = [NSMutableArray array];
        
    }
    return _attrsArray;
}

@end
