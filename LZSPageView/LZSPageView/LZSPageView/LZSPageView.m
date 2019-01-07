//
//  LZSPageView.m
//  academy
//
//  Created by licc on 2017/8/29.
//  Copyright © 2017年 JZ-jingzhuan. All rights reserved.
//

#import "LZSPageView.h"

@interface LZSPageView ()
{
    NSArray<NSString *> *_titleArr;
    LZSTitleStyle *_style;
    NSArray<UIViewController *> *_childVcArr;
}

@property(nonatomic,weak)UIViewController *parentVc;

@end

@implementation LZSPageView

- (instancetype)initWithFrame:(CGRect)frame titleArr:(NSArray<NSString *> *)titleArr style:(LZSTitleStyle *)style childViewControllers:(NSArray<UIViewController *> *)childVcArr parentViewController:(UIViewController *)parentVc {
    if (self = [super initWithFrame:frame]) {
        _titleArr = titleArr;
        _style = style;
        _childVcArr = childVcArr;
        _parentVc = parentVc;
        [self setupUI];
    }
    
    return self;
}

- (void)setupUI {
    self.backgroundColor = [UIColor whiteColor];
    
    // titleView的宽度；是否有指定titleView的宽度，如果没有，就取pageView的宽度
    CGFloat titleViewWidth = _style.titleViewWidth?_style.titleViewWidth:self.bounds.size.width;
    // titleView的X值；是否有指定titleView的宽度，如果有，取指定的titleView的X值，如果没有，titleView的X值为0
    CGFloat titleViewX = _style.titleViewWidth?_style.titleViewX:0;
    LZSTitleView *titleView = [[LZSTitleView alloc] initWithFrame:CGRectMake(0, titleViewX, titleViewWidth, _style.titleViewHeight) titleArr:_titleArr style:_style];
    [self addSubview:titleView];
    _titleView = titleView;
    
    LZSContentView *contentView = [[LZSContentView alloc] initWithFrame:CGRectMake(0, titleView.bounds.size.height, self.bounds.size.width, self.bounds.size.height-titleView.bounds.size.height) childViewControllers:_childVcArr parentViewController:_parentVc];
    [self addSubview:contentView];
    _contentView = contentView;
    
    titleView.delegate = contentView;
    [contentView addDelegate:titleView];
}

@end
