//
//  HView.m
//  HFCollectionView
//
//  Created by 司华锋 on 2017/3/9.
//  Copyright © 2017年 HF. All rights reserved.
//

#import "HView.h"
#import "HModel.h"
#import "HCollectionCell.h"
#import "HCollectionViewFlowLayout.h"

static float CardWidthScale = 0.7f;
static float CardHeightScale = 0.8f;
static NSString *cellId = @"Cell";
@interface HView()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
    UIImageView *_imageView;
    UICollectionView *_collectionView;
    NSInteger _currentIndex;
    CGFloat _dragStartX;
    CGFloat _dragEndX;

}



@end

@implementation HView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self createUI];
        
    }
    return self;
}
- (void)createUI
{
    
    [self addImages];
    [self addCollectionView];

}

- (void)addImages
{
    _imageView = [[UIImageView alloc] initWithFrame:self.bounds];
    [self addSubview:_imageView];
    
    UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:effect];
    effectView.frame = _imageView.bounds;
    [_imageView addSubview:effectView];
    
    
    

}

- (void)addCollectionView
{
    HCollectionViewFlowLayout *flowLayout = [[HCollectionViewFlowLayout alloc] init];
    
    [flowLayout setItemSize:CGSizeMake([self cellWidth], self.bounds.size.height * CardHeightScale)];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    [flowLayout setMinimumLineSpacing:[self cellMargin]];
    _collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:flowLayout];
    _collectionView.showsVerticalScrollIndicator = NO;
    _collectionView.backgroundColor = [UIColor clearColor];
    [_collectionView setDelegate:self];
    [_collectionView setDataSource:self];
    _collectionView.userInteractionEnabled = YES;
    [self addSubview:_collectionView];
    
    [_collectionView registerClass:[HCollectionCell class] forCellWithReuseIdentifier:cellId];
    
    
    

}
- (void)setImageArray:(NSArray *)imageArray
{
    _imageArray = imageArray;
    if (_imageArray.count) {
        HModel *model = _imageArray.firstObject;
        _imageView.image = [UIImage imageNamed:model.imageName];
    }

}

- (CGFloat)cellWidth
{
    return self.bounds.size.width * CardWidthScale;
}
//卡片间隔
-(float)cellMargin
{
    return (self.bounds.size.width - [self cellWidth])/4;
}



- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.imageArray.count;
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, self.bounds.size.width/2.0f - [self cellWidth]/2.0f, 0, self.bounds.size.width/2.0f - [self cellWidth]/2.0f);
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    HCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    HModel *model = _imageArray[indexPath.row];
    cell.model = model;
    
    
    return cell;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    _dragStartX = scrollView.contentOffset.x;
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    _dragEndX = scrollView.contentOffset.x;
    dispatch_async(dispatch_get_main_queue(), ^{
        [self fixCellToCenter];
    });

}
- (void)fixCellToCenter
{
    float dragMiniDistance = self.bounds.size.width / 20;
    if (_dragStartX - _dragEndX >= dragMiniDistance) {
        _currentIndex -= 1;
    }else if (_dragEndX - _dragStartX >= dragMiniDistance){
        _currentIndex += 1;
    }
    NSInteger maxIndex = [_collectionView numberOfItemsInSection:0] - 1;
    _currentIndex = _currentIndex <= 0 ? 0 : _currentIndex;
    _currentIndex = _currentIndex >= maxIndex ? maxIndex : _currentIndex;
    [self scrollToCenter];

}
- (void)scrollToCenter
{
    [_collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:_currentIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
    
    HModel *model = _imageArray[_currentIndex];
    _imageView.image = [UIImage imageNamed:model.imageName];
    if (self.delegate && [self.delegate respondsToSelector:@selector(changeImageDidSelected:)]) {
        [self.delegate changeImageDidSelected:_currentIndex];
    }

}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    _currentIndex = indexPath.row;
    [self scrollToCenter];

}



@end
