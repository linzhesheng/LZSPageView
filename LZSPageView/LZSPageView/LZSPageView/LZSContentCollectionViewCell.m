//
//  LZSContentCollectionViewCell.m
//  academy
//
//  Created by licc on 2017/8/29.
//  Copyright © 2017年 JZ-jingzhuan. All rights reserved.
//

#import "LZSContentCollectionViewCell.h"

@implementation LZSContentCollectionViewCell

- (void)setupUI {
    self.contentView.backgroundColor = [UIColor whiteColor];
}

- (void)setVc:(UIViewController *)vc {
    if (_vc) {
        [_vc.view removeFromSuperview];
    }
    _vc = vc;
    
    if (_vc) {
        vc.view.frame = self.bounds;
        for (UIView *subview in vc.view.subviews) {
            if ([subview isKindOfClass:[UITableView class]]) {
                subview.frame = vc.view.bounds;
                break;
            }
        }
        
        [self.contentView addSubview:vc.view];
    }
}

@end
