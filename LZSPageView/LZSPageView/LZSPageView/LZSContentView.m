//
//  LZSContentView.m
//  academy
//
//  Created by licc on 2017/8/29.
//  Copyright © 2017年 JZ-jingzhuan. All rights reserved.
//

#import "LZSContentView.h"
#import "LZSContentCollectionViewCell.h"
#import "LZSPageViewHeader.h"

@interface LZSContentView ()<UICollectionViewDataSource,UICollectionViewDelegate,LZSTitleViewDelegate>
{
    CGFloat _startOffsetX;
    NSInteger _currentIndex;
}

@property(nonatomic,strong)NSArray<UIViewController *> *childVcArr;
@property(nonatomic,weak)UIViewController *parentVc;
@property(nonatomic,strong)UICollectionView *collectionView;

@property(nonatomic,strong)NSMutableArray<NSNumber *> *isLoadViewArr;

@end

@implementation LZSContentView

- (instancetype)initWithFrame:(CGRect)frame childViewControllers:(NSArray<UIViewController *> *)childVcArr parentViewController:(UIViewController *)parentVc {
    if (self = [super initWithFrame:frame]) {
        _childVcArr = childVcArr;
        _parentVc = parentVc;
        
        _isLoadViewArr = [NSMutableArray new];
        for (int i=0; i<childVcArr.count; i++) {
            [_isLoadViewArr addObject:@0];
        }
        
        
        [self setupUI];
    }
    
    return self;
}

- (void)setupUI {
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    layout.itemSize = self.size;
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    _collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:layout];
    
    if (kIOS11_OR_LATER) {
        _collectionView.contentInsetAdjustmentBehavior = UIApplicationBackgroundFetchIntervalNever;
    }
    [self addSubview:_collectionView];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    [_collectionView registerClass:[LZSContentCollectionViewCell class] forCellWithReuseIdentifier:@"contentCollectionViewCell"];
    _collectionView.pagingEnabled = YES;
    _collectionView.bounces = NO;
    //页面有多个tableView，把点击顶部效果设置为NO，只有一个是YES
    _collectionView.scrollsToTop = NO;
    _collectionView.showsHorizontalScrollIndicator = NO;

    
    for (UIViewController *vc in _childVcArr) {
        [_parentVc addChildViewController:vc];
    }
}

#pragma mark - collectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _childVcArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    LZSContentCollectionViewCell *cell = [_collectionView dequeueReusableCellWithReuseIdentifier:@"contentCollectionViewCell" forIndexPath:indexPath];
    if (indexPath.row == 0) {
        cell.vc = _childVcArr[indexPath.row];
        _isLoadViewArr[0] = @1;
    } else {
        NSNumber *number = _isLoadViewArr[indexPath.row];
        if (number.integerValue) {
            cell.vc = _childVcArr[indexPath.row];
        } else {
            cell.vc = nil;
        }
    }
    
    
    return cell;
}

#pragma mark - collectionViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (!(scrollView.tracking || scrollView.decelerating || scrollView.dragging)) {
        return;
    }
    
    NSInteger targetIndex = 0;
    CGFloat progress = 0.0;
    if (_startOffsetX < scrollView.contentOffset.x) {
        if (_currentIndex+1 == _childVcArr.count) {
            return;
        }
        targetIndex = _currentIndex + 1;
        progress = (scrollView.contentOffset.x - _startOffsetX) / scrollView.width;
    } else {
        if (_currentIndex-1 < 0) {
            return;
        }
        targetIndex = _currentIndex - 1;
        progress = (_startOffsetX - scrollView.contentOffset.x) / scrollView.width;
    }
    
    if ([self.delegate respondsToSelector:@selector(contentViewIsScrolling:beginIndex:targetIndex:progress:)]) {
        [self.delegate contentViewIsScrolling:self beginIndex:_currentIndex targetIndex:targetIndex progress:progress];
    }
    if ([self.delegate2 respondsToSelector:@selector(contentViewIsScrolling:beginIndex:targetIndex:progress:)]) {
        [self.delegate2 contentViewIsScrolling:self beginIndex:_currentIndex targetIndex:targetIndex progress:progress];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    scrollView.userInteractionEnabled = YES;
    
    _currentIndex = _collectionView.contentOffset.x/_collectionView.width;
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:_currentIndex inSection:0];
    LZSContentCollectionViewCell *cell = (LZSContentCollectionViewCell *)[_collectionView cellForItemAtIndexPath:indexPath];
    NSNumber *number = _isLoadViewArr[indexPath.row];
    if (!number.integerValue) {
        cell.vc = _childVcArr[indexPath.row];
        _isLoadViewArr[indexPath.row] = @1;
    }
    
    if ([self.delegate respondsToSelector:@selector(contentViewDidEndScroll:currentIndex:)]) {
        [self.delegate contentViewDidEndScroll:self currentIndex:_currentIndex];
        [[NSNotificationCenter defaultCenter] postNotificationName:kContentViewDidStopScroll object:self userInfo:@{@"currentIndex":@(_currentIndex)}];
    }
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (!decelerate) {
         _currentIndex = _collectionView.contentOffset.x/_collectionView.width;
        if ([self.delegate respondsToSelector:@selector(contentViewDidEndScroll:currentIndex:)]) {
            [self.delegate contentViewDidEndScroll:self currentIndex:_currentIndex];
            [[NSNotificationCenter defaultCenter] postNotificationName:kContentViewDidStopScroll object:self userInfo:@{@"currentIndex":@(_currentIndex)}];
        }
    } else {
        scrollView.userInteractionEnabled = NO;
    }
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    _currentIndex = _collectionView.contentOffset.x/_collectionView.width;
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:_currentIndex inSection:0];
    LZSContentCollectionViewCell *cell = (LZSContentCollectionViewCell *)[_collectionView cellForItemAtIndexPath:indexPath];
    NSNumber *number = _isLoadViewArr[indexPath.row];
    if (!number.integerValue) {
        cell.vc = _childVcArr[indexPath.row];
        _isLoadViewArr[indexPath.row] = @1;
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kContentViewDidStopScroll object:self userInfo:@{@"currentIndex":@(_currentIndex)}];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    _startOffsetX = scrollView.contentOffset.x;
}

#pragma mark - LZSTitleViewDelegate
- (void)selectedTitleDidChange:(LZSTitleView *)titleView currentIndex:(NSInteger)selectedIndex {
    [_collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:selectedIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
}

#pragma mark - 滚动到指定下标的view
- (void)scrollToViewWithIndex:(NSInteger)index {
    [_collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:index inSection:0] atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
    [self.delegate contentViewDidEndScroll:self currentIndex:index];
}

#pragma mark - 解决与系统的手势冲突
- (void)systemGesturerHavePriority {
    UIScreenEdgePanGestureRecognizer *screenEdgePanGesture = [self viewController].screenEdgePanGestureRecognizer;
    if (screenEdgePanGesture) {
        [_collectionView.panGestureRecognizer requireGestureRecognizerToFail:screenEdgePanGesture];
    }
}

@end
