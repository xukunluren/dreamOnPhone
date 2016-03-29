//
//  Scan_VC.h
//  仿支付宝
//
//  Created by 张国兵 on 15/12/9.
//  Copyright © 2015年 zhangguobing. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol passvalueFromSaoMiaoDelegate <NSObject>

@optional
-(void)passimageFromSaoMiao:(NSArray *)imagearray story:(NSString *)story baidu:(NSString *)baidu;
@optional
-(void)passvideoFromSaoMiao:(NSArray *)image withTitle:(NSString *)title mp3:(NSString *)mp3Url content:(NSString *)content story:(NSString *)story;
@end


@interface Scan_VC : UIViewController

@property(retain,nonatomic) id <passvalueFromSaoMiaoDelegate> delegate;
@property(retain,nonatomic)NSString *item;
@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com