//
//  CCRefreshMacro.h
//  CCRefresh-master
//
//  Created by v－ling on 15/7/30.
//  Copyright (c) 2015年 LiuZeChen. All rights reserved.
//

#ifndef CCRefresh_master_CCRefreshMacro_h
#define CCRefresh_master_CCRefreshMacro_h

typedef void(^CCRefreshedHandler)(void);

#define CCScreenBounds [[UIScreen mainScreen] bounds]
#define CCScreenWidth CCScreenBounds.size.width

#define offsetThreshold 64

#define CCRefreshStateDefaultTitle      @"下拉刷新"
#define CCRefreshStateTriggeredTitle    @"松开刷新"
#define CCRefreshStateLoadingTitle      @"加载中..."

#endif
