//
//  LZSTitleView.h
//  academy
//
//  Created by licc on 2017/8/28.
//  Copyright © 2017年 JZ-jingzhuan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LZSTitleStyle.h"

@class LZSTitleView;
@protocol LZSTitleViewDelegate <NSObject>
@required;
- (void)selectedTitleDidChange:(LZSTitleView *)titleView currentIndex:(NSInteger)selectedIndex;

@end

#import "LZSContentView.h"

@interface LZSTitleView : UIView<LZSContentViewDelegate>

@property(nonatomic,assign)NSInteger currentIndex;
@property(nonatomic,weak)id<LZSTitleViewDelegate> delegate;

- (instancetype)initWithFrame:(CGRect)frame titleArr:(NSArray<NSString *> *)titleArr style:(LZSTitleStyle *)style;

@end
