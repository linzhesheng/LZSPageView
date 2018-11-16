//
//  LZSTitleStyle.m
//  academy
//
//  Created by licc on 2017/8/28.
//  Copyright © 2017年 JZ-jingzhuan. All rights reserved.
//

#import "LZSTitleStyle.h"

@implementation LZSTitleStyle

- (instancetype)init {
    self = [super init];
    
    _titleViewHeight = 44;
    _normalColor = [UIColor whiteColor];
    _selectColor = [UIColor blueColor];
    _fontSize = 15;
    _itemMargin = 30;
    _scrollLineHeight = 2;
    _scrollLineColor = self.selectColor;
    _isShowScrollLine = YES;
    
    return self;
}

@end
