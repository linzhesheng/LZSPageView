//
//  UILabel+LZSPageView.m
//  LZSPageView
//
//  Created by licc on 2018/11/16.
//  Copyright © 2018年 1. All rights reserved.
//

#import "UILabel+LZSPageView.h"

@implementation UILabel (LZSPageView)

+ (instancetype)lzs_labelWithText:(NSString *)text font:(UIFont *)font color:(UIColor *)color {
    UILabel *label = [[self alloc] init];
    
    label.text = text;
    label.font = font;
    label.textColor = color;
    
    [label sizeToFit];
    
    return label;
}

@end
