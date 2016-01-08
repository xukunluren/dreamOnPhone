//
//  CCBaseRefresh.m
//  CCRefresh-master
//
//  Created by v－ling on 15/7/30.
//  Copyright (c) 2015年 LiuZeChen. All rights reserved.
//

#import "CCBaseRefresh.h"

@implementation CCBaseHeaderRefresh
@synthesize scrollView = _scrollView;
@synthesize defaultEdgeInsets = _defaultEdgeInsets;
@synthesize refreshState = _refreshState;
@synthesize refreshedHandler = _refreshedHandler;

- (instancetype)init {
    if (self = [super init]) {
        self.frame = CGRectMake(0, -offsetThreshold, CCScreenWidth, offsetThreshold);
        self.backgroundColor = [UIColor redColor];
        [self componentForHeader];
    }
    return self;
}

- (instancetype)initWithHeaderRefresh:(CCRefreshedHandler)refreshedHandler {
    self = [self init];
    if (self) {
        self.refreshedHandler = refreshedHandler;
    }
    return self;
}

- (void)componentForHeader {
    // over method
}

- (void)willMoveToSuperview:(UIView *)newSuperview {
    [self.superview removeObserver:self forKeyPath:@"contentOffset" context:nil];
    if (newSuperview) {
        self.scrollView = (UIScrollView *)newSuperview;
        self.defaultEdgeInsets = self.scrollView.contentInset;
        [self.scrollView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
    }
}

- (void)setRefreshState:(CCRefreshState)refreshState {
    _refreshState = refreshState;
}

- (void)autoRefresh {
    self.refreshState = CCRefreshStateLoading;
}

- (void)stopRefresh {
    self.refreshState = CCRefreshStateDefault;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if (self.refreshState == CCRefreshStateLoading) {
        return;
    }
    CGPoint point = [[change valueForKey:NSKeyValueChangeNewKey] CGPointValue];
    CGFloat newOffsetThreshold = -offsetThreshold - self.scrollView.contentInset.top;
    if (!self.scrollView.isDragging && self.refreshState == CCRefreshStateTriggered) {
        self.refreshState = CCRefreshStateLoading;
    } else if (point.y < newOffsetThreshold && self.scrollView.isDragging) {
        self.refreshState = CCRefreshStateTriggered;
    } else if (point.y >= newOffsetThreshold && self.refreshState != CCRefreshStateDefault) {
        self.refreshState = CCRefreshStateDefault;
    }
}

@end
