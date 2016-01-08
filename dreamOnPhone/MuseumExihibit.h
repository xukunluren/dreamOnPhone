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

-(void)passimage:(NSArray *)imagearray story:(NSString *)story baidu:(NSString *)baidu;

@end

@interface MuseumExihibit : UITableViewController

{
    AppDelegate *mydelegate;
}

@property(nonatomic,strong)AppDelegate *mydelegate;
@property(retain,nonatomic) id <passvalueDelegate> delegate;

@end
