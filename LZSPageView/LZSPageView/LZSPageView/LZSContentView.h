//
//  LZSContentView.h
//  academy
//
//  Created by licc on 2017/8/29.
//  Copyright © 2017年 JZ-jingzhuan. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LZSContentView;

@protocol LZSContentViewDelegate <NSObject>

@optional;
// contentView正在滚动
- (void)contentViewDidScroll:(LZSContentView *)contentView beginIndex:(NSInteger)beginIndex targetIndex:(NSInteger)targetIndex progress:(CGFloat)progress;
@optional;
// contentView已经停止滚动
- (void)contentViewDidEndScroll:(LZSContentView *)contentView currentIndex:(NSInteger)currentIndex;

@end

#import "LZSTitleView.h"

@interface LZSContentView : UIView<LZSTitleViewDelegate>

// 初始化方法
- (instancetype)initWithFrame:(CGRect)frame childViewControllers:(NSArray<UIViewController *> *)childVcArr parentViewController:(UIViewController *)parentVc;
// 增加代理
- (void)addDelegate:(id<LZSContentViewDelegate>) delegate;
// 指定contentView滚动到对应下标的页面
- (void)scrollToViewWithIndex:(NSInteger)index;

@end
