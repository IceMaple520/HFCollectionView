//
//  HCollectionCell.m
//  HFCollectionView
//
//  Created by 司华锋 on 2017/3/9.
//  Copyright © 2017年 HF. All rights reserved.
//

#import "HCollectionCell.h"

@interface HCollectionCell()

@property (nonatomic,strong) UIImageView *imageView;
@property (nonatomic,strong) UILabel *nameLabel;

@end

@implementation HCollectionCell


- (instancetype)initWithFrame:(CGRect)frame
{

    if (self = [super initWithFrame:frame]) {
        [self buildUI];
    }
    return self;
    
}
- (void)buildUI
{
    self.layer.cornerRadius = 10;
    self.layer.masksToBounds = YES;
    self.backgroundColor = [UIColor whiteColor];
    
    CGFloat labelHeight = self.bounds.size.height * 0.2f;
    CGFloat imageViewHeight = self.bounds.size.height - labelHeight;
    
    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, imageViewHeight)];
    _imageView.contentMode = UIViewContentModeScaleAspectFill;
    _imageView.layer.masksToBounds = YES;
    [self addSubview:_imageView];
    
    _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, imageViewHeight, self.bounds.size.width, labelHeight)];
    _nameLabel.textColor = [UIColor colorWithRed:102 / 255 green:102 /255 blue:102 / 255 alpha:1];
    _nameLabel.font = [UIFont systemFontOfSize:22];
    _nameLabel.textAlignment = NSTextAlignmentCenter;
    _nameLabel.adjustsFontSizeToFitWidth = YES;
    [self addSubview:_nameLabel];

    
    

}

- (void)setModel:(HModel *)model
{
    _model = model;
    
    _imageView.image = [UIImage imageNamed:model.imageName];
    _nameLabel.text = model.title;
    
}





























@end
