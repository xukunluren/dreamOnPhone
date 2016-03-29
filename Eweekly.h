//
//  Eweekly.h
//  dreamOnPhone
//
//  Created by admin on 15/8/17.
//  Copyright (c) 2015年 xukun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Eweekly : NSManagedObject

@property (nonatomic, retain) NSString * signid;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * number;
@property (nonatomic, retain) NSString * cover;
@property (nonatomic, retain) NSString * introduction;
@property (nonatomic, retain) NSString * url;
@property (nonatomic, retain) NSString * date;
@property (nonatomic, retain) NSString * coverurl;
@property (nonatomic, retain) NSString * coverlogo;

@end
