//
//  UIColor+LZSPageView.m
//  LZSPageView
//
//  Created by licc on 2018/11/16.
//  Copyright © 2018年 1. All rights reserved.
//

#import "UIColor+LZSPageView.h"

@implementation UIColor (LZSPageView)

#pragma mark - 根据十六进制创建颜色
+ (UIColor *)colorWithHex:(uint32_t)hex
{
    //(hex & 0xff0000)表示二进制取值，  >>表示位运算右移
    uint8_t r = (hex & 0xff0000) >> 16;
    uint8_t g = (hex & 0x00ff00) >> 8;
    uint8_t b = (hex & 0x0000ff);
    //后面要加f,不然永远都是整型0,黑色
    return [UIColor colorWithRed:r/255.f green:g/255.f blue:b/255.f alpha:1];
}

#pragma mark - 返回颜色的RGB值
- (NSArray<NSNumber *> *)colorRGB {
    CGFloat r = 0.0;
    CGFloat g = 0.0;
    CGFloat b = 0.0;
    BOOL success = [self getRed:&r green:&g blue:&b alpha:nil];
    if (success) {
        return @[@(r),@(g),@(b)];
    }
    return nil;
}

@end
