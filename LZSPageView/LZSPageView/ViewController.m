//
//  ViewController.m
//  LZSPageView
//
//  Created by licc on 2018/11/16.
//  Copyright © 2018年 1. All rights reserved.
//

#import "ViewController.h"
#import "LZSPageView.h"
#import "UILabel+LZSPageView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // 创建tab栏对应的title数组
    NSArray<NSString *> *titleArr = @[@"腾讯", @"蚂蚁金服", @"YY", @"网易"];
    // 创建页面对应的子控制器数组
    NSMutableArray<UIViewController *> *childVcArr = [NSMutableArray new];
    for (int i = 0; i < titleArr.count; i++) {
        UIViewController *vc = [UIViewController new];
        vc.view.backgroundColor = [UIColor whiteColor];
        UILabel *label = [UILabel lzs_labelWithText:titleArr[i] font:[UIFont systemFontOfSize:14] color:[UIColor redColor]];
        label.center = vc.view.center;
        [vc.view addSubview:label];
        [childVcArr addObject:vc];
    }
    // tab栏的样式
    LZSTitleStyle *style = [LZSTitleStyle new];
    // 创建pageView
    LZSPageView *pageView = [[LZSPageView alloc] initWithFrame:self.view.bounds titleArr:titleArr style:style childViewControllers:childVcArr parentViewController:self];
    [self.view addSubview:pageView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
