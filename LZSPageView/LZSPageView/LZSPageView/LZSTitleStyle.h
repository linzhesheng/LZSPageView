//
//  LZSTitleStyle.h
//  academy
//
//  Created by licc on 2017/8/28.
//  Copyright © 2017年 JZ-jingzhuan. All rights reserved.
//

#import <UIKit/UIKit.h>

//contentView将要开始滚动
#define kContentViewWillScroll @"kContentViewWillScroll"
//contentView已经停止滚动
#define kContentViewDidStopScroll @"kContentViewDidStopScroll"

@interface LZSTitleStyle : NSObject

//titleView高度，默认44
@property(nonatomic,assign)float titleViewHeight;
//titleView的宽度，默认等于pageView宽度
@property(nonatomic,assign)float titleViewWidth;
//titleView的x值，当titleView的宽度等于pageView宽度时，一定为0，当titleView的宽度不能等于pageView宽度时,可以设置，不设置默认为0
@property(nonatomic,assign)float titleViewX;
//title未选中颜色，默认黑色
@property(nonatomic,strong)UIColor *normalColor;
//title选中颜色，默认蓝色
@property(nonatomic,strong)UIColor *selectColor;
//字体大小
@property(nonatomic,assign)float fontSize;
//标题栏不能滚动时titleLab宽度等于pageView宽度/title个数，可以滚动时titleLab宽度等于文字宽度，默认不能滚动
@property(nonatomic,assign)BOOL isScrollEnable;
//titleLab间距,标题栏不能滚动时一定为0，能滚动时可以设置间距，默认30，最左边距和最右边距为itemMargin/2
@property(nonatomic,assign)float itemMargin;
//是否显示下划线，默认显示
@property(nonatomic,assign)BOOL isShowScrollLine;
//标题栏可以滚动时下划线宽度一定会等于文字的宽度,不能滚动时可以设置下划线宽度，默认等于titleLab的宽度
@property(nonatomic,assign)float scrollLineWidth;
//下划线高度，默认2
@property(nonatomic,assign)float scrollLineHeight;
//下划线颜色，默认蓝色
@property(nonatomic,strong)UIColor *scrollLineColor;

@end
