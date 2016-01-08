//
//  CCBaseRefresh.h
//  CCRefresh-master
//
//  Created by v－ling on 15/7/30.
//  Copyright (c) 2015年 LiuZeChen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "CCRefreshMacro.h"

typedef NS_ENUM(NSInteger, CCRefreshState) {
    CCRefreshStateNoKnown = 0,
    CCRefreshStateDefault = 1,
    CCRefreshStateTriggered = 2,
    CCRefreshStateLoading = 3
};

@protocol CCBaseRefresh <NSObject>

// 父视图
@property (nonatomic, weak) UIScrollView *scrollView;
// 默认边界值
@property (nonatomic, assign) UIEdgeInsets defaultEdgeInsets;
// 刷新状态
@property (nonatomic, assign) CCRefreshState refreshState;
// 请求完成的回调
@property (nonatomic, copy) CCRefreshedHandler refreshedHandler;

@end

@interface CCBaseHeaderRefresh : UIView <CCBaseRefresh>

- (instancetype)initWithHeaderRefresh:(CCRefreshedHandler)refreshedHandler;
- (void)autoRefresh;
- (void)stopRefresh;
- (void)componentForHeader;

@end
