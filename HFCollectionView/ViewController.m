//
//  ViewController.m
//  HFCollectionView
//
//  Created by 司华锋 on 2017/3/9.
//  Copyright © 2017年 HF. All rights reserved.
//

#import "ViewController.h"
#import "HView.h"
#import "HModel.h"
@interface ViewController ()<HViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self setUI];
}
- (void)setUI
{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"DataPropertyList" ofType:@"plist"];
    NSArray *array = [NSArray arrayWithContentsOfFile:filePath];
    NSMutableArray *mArray = [NSMutableArray new];
    for (NSDictionary *dict in array) {
        
        HModel *model = [HModel new];
        [model setValuesForKeysWithDictionary:dict];
        [mArray addObject:model];
    }

    HView *view = [[HView alloc] initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height - 64)];
    view.imageArray = mArray;
    view.delegate = self;
    [self.view addSubview:view];
    
    
}
- (void)changeImageDidSelected:(NSInteger)index
{
    NSLog(@"********%ld",index);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
