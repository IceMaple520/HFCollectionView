//
//  HCollectionViewFlowLayout.m
//  HFCollectionView
//
//  Created by 司华锋 on 2017/3/9.
//  Copyright © 2017年 HF. All rights reserved.
//

#import "HCollectionViewFlowLayout.h"

@implementation HCollectionViewFlowLayout

//设置放大图片
- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSArray *array = [self getCopyOfAttributes:[super layoutAttributesForElementsInRect:rect]];
    
    CGFloat centerX = self.collectionView.contentOffset.x + self.collectionView.bounds.size.width / 2;
    for (UICollectionViewLayoutAttributes *attributes in array) {
        CGFloat distance = fabs(attributes.center.x - centerX);
        CGFloat apartScale = distance / self.collectionView.bounds.size.width;
        CGFloat scale = fabs(cos(apartScale * M_PI_4));
        attributes.transform = CGAffineTransformMakeScale(1, scale);
    }

    return array;
    
}
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return true;
}


- (NSArray *)getCopyOfAttributes:(NSArray *)attributes
{
    NSMutableArray *array = [NSMutableArray new];
    for (UICollectionViewLayoutAttributes *attribute in attributes) {
        [array addObject:attribute];
    }
   
    return array;
    
}



@end
