//
//  MuseumExihibit.h
//  dreamOnPhone
//
//  Created by admin on 15/9/4.
//  Copyright (c) 2015年 xukun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"


@protocol passvalueDelegate <NSObject>

@optional
-(void)passimage:(NSArray *)imagearray withTitle:(NSString *)title story:(NSString *)story baidu:(NSString *)baidu;

@optional
-(void)passimage:(NSArray *)imagearray withTitle:(NSString *)title story:(NSString *)story baidu:(NSString *)baidu mp3:(NSString *)mp3Url content:(NSString *)content;

@end

@interface MuseumExihibit : UITableViewController

{
    AppDelegate *mydelegate;
}

@property(nonatomic,strong)AppDelegate *mydelegate;
@property(retain,nonatomic) id <passvalueDelegate> delegate;

@end
