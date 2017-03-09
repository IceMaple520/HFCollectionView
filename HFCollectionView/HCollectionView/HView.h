//
//  HView.h
//  HFCollectionView
//
//  Created by 司华锋 on 2017/3/9.
//  Copyright © 2017年 HF. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HViewDelegate <NSObject>

@optional
- (void)changeImageDidSelected:(NSInteger)index;


@end

@interface HView : UIView

@property (nonatomic,strong) NSArray *imageArray;
@property (nonatomic,assign) id<HViewDelegate>delegate;








@end
