//
//  UILabel+LZSPageView.h
//  LZSPageView
//
//  Created by licc on 2018/11/16.
//  Copyright © 2018年 1. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (LZSPageView)


/**
 创建一个label

 @param text 文本
 @param font 文本字体
 @param color 文本颜色
 @return label
 */
+ (instancetype)lzs_labelWithText:(NSString *)text font:(UIFont *)font color:(UIColor *)color;

@end
