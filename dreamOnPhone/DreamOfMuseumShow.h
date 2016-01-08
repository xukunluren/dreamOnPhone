//
//  DreamOfMuseumShow.h
//  dreamOnPhone
//
//  Created by admin on 15/8/26.
//  Copyright (c) 2015年 xukun. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol passIdToDetailShowDelegate <NSObject>

-(void)passIdToDetailShow:(NSString *)name ider:(NSString *)ider andInfo:(NSString *)info andInfoimage:(NSString *)infoimage;

@end

@interface DreamOfMuseumShow : UIViewController
@property(retain,nonatomic) id <passIdToDetailShowDelegate> delegate;
@end
