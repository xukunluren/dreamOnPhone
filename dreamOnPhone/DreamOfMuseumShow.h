//
//  DreamOfMuseumShow.h
//  dreamOnPhone
//
//  Created by admin on 15/8/26.
//  Copyright (c) 2015年 xukun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@protocol passIdToDetailShowDelegate <NSObject>

-(void)passIdToDetailShow:(NSString *)name ider:(NSString *)ider andInfo:(NSString *)info andInfoimage:(NSString *)infoimage;

@end

@interface DreamOfMuseumShow : UIViewController
{
    AppDelegate *mydelegate;
}

@property(nonatomic,strong)AppDelegate *mydelegate;
@property(retain,nonatomic) id <passIdToDetailShowDelegate> delegate;
@end
