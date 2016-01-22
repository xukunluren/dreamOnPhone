//
//  RDVFirthViewController.h
//  dreamOnPhone
//
//  Created by admin on 15/8/6.
//  Copyright (c) 2015年 xukun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"


@protocol passSigleIdToShowViewFromCenterDelegate <NSObject>

-(void)passsigleIdToShowViewFromCenter:(NSString*)sigle withname:(NSString *)name andcoverimage:(NSString *)coverimage andInfo:(NSString *)info andInfoImage:(NSString *)infoImage andPrice:(NSString *)price andTel:(NSString *)tel andOpentime:(NSString *)opentime;

@end



@interface RDVFirthViewController : UIViewController
{
    AppDelegate *mydelegate;
}

@property(nonatomic,strong)AppDelegate *mydelegate;
@property(retain,nonatomic) id <passSigleIdToShowViewFromCenterDelegate> delegate;
@end
