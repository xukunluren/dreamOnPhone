//
//  UIScrollView+Refresh.m
//  CCRefresh-master
//
//  Created by v－ling on 15/7/30.
//  Copyright (c) 2015年 LiuZeChen. All rights reserved.
//

#import "UIScrollView+CCRefresh.h"
#import <objc/runtime.h>

static void *kHeaderRefresh = (void *)@"kHeaderRefresh";

@implementation UIScrollView (CCRefresh)
@dynamic header;

- (CCDefaultHeaderRefresh *)header {
    return objc_getAssociatedObject(self, kHeaderRefresh);
}

- (void)setHeader:(CCDefaultHeaderRefresh *)header {
    id header_ = [self header];
    if (header_) {
        [header_ removeFromSuperview];
    }
    if (header) {
        [self addSubview:header];
    }
    objc_setAssociatedObject(self, kHeaderRefresh, header, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
