//
//  UIColor+LZSPageView.h
//  LZSPageView
//
//  Created by licc on 2018/11/16.
//  Copyright © 2018年 1. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (LZSPageView)

#pragma mark - 根据十六进制创建颜色
+ (UIColor *)colorWithHex:(uint32_t)hex;

#pragma mark - 返回颜色的RGB值
- (NSArray<NSNumber *> *)colorRGB;

@end
