//
//  LZSTitleView.m
//  academy
//
//  Created by licc on 2017/8/28.
//  Copyright © 2017年 JZ-jingzhuan. All rights reserved.
//

#import "LZSTitleView.h"
#import "LZSPageViewHeader.h"

@interface LZSTitleView ()<LZSContentViewDelegate>
{
    NSArray<NSString *> *_titleArr;
    LZSTitleStyle *_style;
    NSMutableArray<UILabel *> *_titleLabArr;
    NSMutableArray<NSNumber *> *_titleWidthArr;
    UIScrollView *_scrollView;
    
    NSArray<NSNumber *> *_normalColorRGB;
    NSArray<NSNumber *> *_selectedColorRGB;
    NSArray<NSNumber *> *_differColorRGB;
}

@property(nonatomic,strong)UIView *bottomLine;

@end

@implementation LZSTitleView

- (instancetype)initWithFrame:(CGRect)frame titleArr:(NSArray<NSString *> *)titleArr style:(LZSTitleStyle *)style {
    if (self = [super initWithFrame:frame]) {
        _titleArr = titleArr;
        _style = style;
        [self setupUI];
    }
    
    return self;
}

- (void)setupUI {
    self.backgroundColor = [UIColor whiteColor];
    
    _scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
    [self addSubview:_scrollView];
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.scrollsToTop = NO;
    
    [self setupTitleLabs];
    
    if (_style.isShowScrollLine) {
        [_scrollView addSubview:self.bottomLine];
        self.bottomLine.width = [self bottomLineWidthWtihIndex:0];
        self.bottomLine.x = [self bottomLineXWtihIndex:0];
    }
    
    _normalColorRGB = _style.normalColor.colorRGB;
    _selectedColorRGB = _style.selectColor.colorRGB;
    _differColorRGB = @[@(_selectedColorRGB[0].floatValue-_normalColorRGB[0].floatValue),@(_selectedColorRGB[1].floatValue-_normalColorRGB[1].floatValue),@(_selectedColorRGB[2].floatValue-_normalColorRGB[2].floatValue)];
}

- (void)setupTitleLabs {
    _titleLabArr = [NSMutableArray new];
    _titleWidthArr = [NSMutableArray new];
    CGFloat x = 0;
    CGFloat y = 0;
    CGFloat width = 0;
    CGFloat height = self.height;
    for (int i=0; i<_titleArr.count; i++) {
        UILabel *titleLab = [UILabel lzs_labelWithText:_titleArr[i] font:[UIFont systemFontOfSize:_style.fontSize] color:(i==0?_style.selectColor:_style.normalColor)];
        [_scrollView addSubview:titleLab];
        titleLab.textAlignment = NSTextAlignmentCenter;
        titleLab.tag = i;
        [_titleLabArr addObject:titleLab];
        
        [titleLab addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickTitleLabel:)]];
        titleLab.userInteractionEnabled = YES;
        
        if (_style.isScrollEnable) {
            width = [_titleArr[i] sizeWithAttributes:@{NSFontAttributeName:titleLab.font}].width;
            [_titleWidthArr addObject:@(width)];
            if (i == 0) {
                x = _style.itemMargin * 0.5;
            } else {
                x = _titleLabArr[i-1].rightX + _style.itemMargin;
            }
        } else {
            width = self.width / _titleArr.count;
            x = width * i;
        }
        titleLab.frame = CGRectMake(x, y, width, height);
    }
    
    _scrollView.contentSize = _style.isScrollEnable ? CGSizeMake(_titleLabArr.lastObject.rightX+_style.itemMargin*0.5, 0) : CGSizeZero;
}

#pragma mark - 点击titleLabel
- (void)clickTitleLabel:(UITapGestureRecognizer *)tap {
    UILabel *selectedLab = (UILabel *)tap.view;
    if (_currentIndex == selectedLab.tag) {
        return;
    }
    
    for (UILabel *lab in _titleLabArr) {
        lab.userInteractionEnabled = NO;
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kContentViewWillScroll object:self userInfo:@{@"currentIndex":@(_currentIndex),@"targetIndex":@(selectedLab.tag)}];
    
    [self adjustTitleLabAndBottomLine:selectedLab];
    [self.delegate selectedTitleDidChange:self currentIndex:_currentIndex];
}

#pragma mark - 到目标title
- (void)adjustTitleLabAndBottomLine:(UILabel *)selectedLab {
    UILabel *currentLab = _titleLabArr[_currentIndex];
    
    currentLab.textColor = _style.normalColor;
    selectedLab.textColor = _style.selectColor;
    
    if (_style.isShowScrollLine) {
        [UIView animateWithDuration:0.25 animations:^{
            self.bottomLine.width = [self bottomLineWidthWtihIndex:selectedLab.tag];
            self.bottomLine.x = [self bottomLineXWtihIndex:selectedLab.tag];
        } completion:^(BOOL finished) {
            for (UILabel *lab in _titleLabArr) {
                lab.userInteractionEnabled = YES;
            }
        }];
    }
    
    if (_style.isScrollEnable) {
        CGFloat offsetX = selectedLab.centerX - _scrollView.width * 0.5;
        if (offsetX < 0) {
            offsetX = 0;
        }
        if (offsetX > (_scrollView.contentSize.width-_scrollView.width)) {
            offsetX = _scrollView.contentSize.width-_scrollView.width;
        }
        [_scrollView setContentOffset:CGPointMake(offsetX, 0) animated:YES];
    }
    
    _currentIndex = selectedLab.tag;
}

#pragma mark - 根据index得到bottomLine的x值和宽度
- (CGFloat)bottomLineXWtihIndex:(NSInteger)index {
    if (_style.isScrollEnable) {
         return _titleLabArr[index].x;
    }
    return _style.scrollLineWidth ? _titleLabArr[index].centerX-_style.scrollLineWidth/2 : _titleLabArr[index].x;
}

- (CGFloat)bottomLineWidthWtihIndex:(NSInteger)index {
    if (_style.isScrollEnable) {
        return _titleLabArr[index].width;
    }
    return _style.scrollLineWidth ? _style.scrollLineWidth : self.width/_titleArr.count;
}

#pragma mark - LZSContentViewDelegate
- (void)contentViewIsScrolling:(LZSContentView *)contentView beginIndex:(NSInteger)beginIndex targetIndex:(NSInteger)targetIndex progress:(CGFloat)progress {
    UILabel *currentLab = _titleLabArr[_currentIndex];
    UILabel *targetLab = _titleLabArr[targetIndex];
    
    currentLab.textColor = [UIColor colorWithRed:_selectedColorRGB[0].floatValue-_differColorRGB[0].floatValue*progress green:_selectedColorRGB[1].floatValue-_differColorRGB[1].floatValue*progress blue:_selectedColorRGB[2].floatValue-_differColorRGB[2].floatValue*progress alpha:1];
    targetLab.textColor = [UIColor colorWithRed:_normalColorRGB[0].floatValue+_differColorRGB[0].floatValue*progress green:_normalColorRGB[1].floatValue+_differColorRGB[1].floatValue*progress blue:_normalColorRGB[2].floatValue+_differColorRGB[2].floatValue*progress alpha:1];
    
    if (_style.isShowScrollLine) {
        CGFloat differX = [self bottomLineXWtihIndex:targetIndex] - [self bottomLineXWtihIndex:_currentIndex];
        CGFloat differWidth = [self bottomLineWidthWtihIndex:targetIndex] - [self bottomLineWidthWtihIndex:_currentIndex];
        self.bottomLine.x = [self bottomLineXWtihIndex:_currentIndex] + differX*progress;
        self.bottomLine.width = [self bottomLineWidthWtihIndex:_currentIndex] + differWidth*progress;
    }
}

- (void)contentViewDidEndScroll:(LZSContentView *)contentView currentIndex:(NSInteger)currentIndex {
    [self adjustTitleLabAndBottomLine:_titleLabArr[currentIndex]];
    _currentIndex = currentIndex;
}

#pragma mark - 懒加载
- (UIView *)bottomLine {
    if (!_bottomLine) {
        _bottomLine = [[UIView alloc] initWithFrame:CGRectMake(0, self.height-_style.scrollLineHeight, 0, _style.scrollLineHeight)];
        _bottomLine.backgroundColor = _style.scrollLineColor;
    }
    return _bottomLine;
}

@end
