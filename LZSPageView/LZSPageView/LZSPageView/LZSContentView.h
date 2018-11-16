//
//  LZSContentView.h
//  academy
//
//  Created by licc on 2017/8/29.
//  Copyright © 2017年 JZ-jingzhuan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LZSTitleView.h"

@class LZSContentView;
@protocol LZSContentViewDelegate <NSObject>
@optional;
- (void)contentViewDidEndScroll:(LZSContentView *)contentView currentIndex:(NSInteger)currentIndex;
- (void)contentViewIsScrolling:(LZSContentView *)contentView beginIndex:(NSInteger)beginIndex targetIndex:(NSInteger)targetIndex progress:(CGFloat)progress;

@end

@interface LZSContentView : UIView

@property(nonatomic,weak)id<LZSContentViewDelegate> delegate;
@property(nonatomic,weak)id<LZSContentViewDelegate> delegate2;

- (instancetype)initWithFrame:(CGRect)frame childViewControllers:(NSArray<UIViewController *> *)childVcArr parentViewController:(UIViewController *)parentVc;

- (void)scrollToViewWithIndex:(NSInteger)index;

//解决与系统的手势冲突
- (void)systemGesturerHavePriority;

@end
