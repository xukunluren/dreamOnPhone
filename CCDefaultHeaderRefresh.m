//
//  CCDefaultHeaderRefresh.m
//  CCRefresh-master
//
//  Created by v－ling on 15/7/30.
//  Copyright (c) 2015年 LiuZeChen. All rights reserved.
//

#import "CCDefaultHeaderRefresh.h"

@interface CCDefaultHeaderRefresh ()

@property (nonatomic, strong) UILabel *descLabel;
@property (nonatomic, strong) UIImageView *arrowView;
@property (nonatomic, strong) UIActivityIndicatorView *indicatorView;

@end

@implementation CCDefaultHeaderRefresh

- (void)componentForHeader {

    UIImageView *backgroudView = [[UIImageView alloc]initWithFrame:self.bounds];
    [backgroudView setImage:[UIImage imageNamed:@"backgroud"]];
    [self addSubview:backgroudView];

    UIImage *arrow = [UIImage imageNamed:@"arrow-white"];
    CGFloat arrowWidth = arrow.size.width;
    CGFloat arrowHeight = arrow.size.height;

    // 文字提示
    self.descLabel = [[UILabel alloc] initWithFrame:self.bounds];
    self.descLabel.backgroundColor = [UIColor clearColor];
    self.descLabel.textColor = [UIColor whiteColor];
    self.descLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.descLabel];

    // 箭头提示
    self.arrowView = [[UIImageView alloc] initWithFrame:CGRectMake(15, (self.frame.size.height - arrowHeight) / 2, arrowWidth, arrowHeight)];
    [self.arrowView setImage:arrow];
    [self addSubview:self.arrowView];

    // 刷新菊花
    self.indicatorView = [[UIActivityIndicatorView alloc]initWithFrame:CGRectMake(0, 0, 25, 25)];
    self.indicatorView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhite;
    self.indicatorView.center = self.arrowView.center;
    [self addSubview:self.indicatorView];
}

- (void)setRefreshState:(CCRefreshState)refreshState {
    [super setRefreshState:refreshState];

    switch (self.refreshState) {
        case CCRefreshStateDefault:
            self.descLabel.text = CCRefreshStateDefaultTitle;
            [self scrollViewContentInsets:self.defaultEdgeInsets];
            [self arrowAnimation:0 isHidden:NO];
            [self.indicatorView stopAnimating];
            break;
        case CCRefreshStateTriggered:
            self.descLabel.text = CCRefreshStateTriggeredTitle;
            [self arrowAnimation:M_PI isHidden:NO];
            [self.indicatorView stopAnimating];
            break;
        case CCRefreshStateLoading:
            self.descLabel.text = CCRefreshStateLoadingTitle;
            [self scrollViewContentInsets:UIEdgeInsetsMake(offsetThreshold+self.scrollView.contentInset.top, 0, 0, 0)];
            [self arrowAnimation:0 isHidden:YES];
            [self.indicatorView startAnimating];
            self.refreshedHandler();
            break;
        default:
            break;
    }
}

- (void)scrollViewContentInsets:(UIEdgeInsets)contentInset {
    [UIView animateWithDuration:.35 animations:^{
        [self.scrollView setContentInset:contentInset];
    }];
}

- (void)arrowAnimation:(CGFloat)progress isHidden:(BOOL)isHidden {
    [UIView animateWithDuration:.25 animations:^{
        self.arrowView.layer.transform = CATransform3DMakeRotation(progress, 0, 0, 1);
        self.arrowView.hidden = isHidden;
    }];
}

@end
