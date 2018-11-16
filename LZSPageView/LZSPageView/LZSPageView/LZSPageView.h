//
//  LZSPageView.h
//  academy
//
//  Created by licc on 2017/8/29.
//  Copyright © 2017年 JZ-jingzhuan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LZSTitleView.h"
#import "LZSContentView.h"

@interface LZSPageView : UIView

@property(nonatomic,weak)LZSTitleView *titleView;
@property(nonatomic,weak)LZSContentView *contentView;

- (instancetype)initWithFrame:(CGRect)frame titleArr:(NSArray<NSString *> *)titleArr style:(LZSTitleStyle *)style childViewControllers:(NSArray<UIViewController *> *)childVcArr parentViewController:(UIViewController *)parentVc;

@end
