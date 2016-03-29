//
//  DreamOfLifeViewController.h
//  dreamOnPhone
//
//  Created by admin on 15/8/16.
//  Copyright (c) 2015年 xukun. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "AppDelegate.h"


@protocol passValueToShowDelegate <NSObject>

-(void)passValueToShow:(NSString *)signid;

@end
@interface DreamOfLifeViewController : UITableViewController
{
    AppDelegate *mydelegate;
}
@property(nonatomic,strong)AppDelegate *mydelegate;
@property(retain,nonatomic) id <passValueToShowDelegate> delegate;


@end
