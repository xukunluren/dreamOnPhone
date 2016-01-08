//
//  Products.h
//  dreamOnPhone
//
//  Created by admin on 15/8/16.
//  Copyright (c) 2015年 xukun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Products : NSManagedObject

@property (nonatomic, retain) NSString * signid;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * url;
@property (nonatomic, retain) NSString * imageurl;
@property (nonatomic, retain) NSString * salersname;
@property (nonatomic, retain) NSString * price;
@property (nonatomic, retain) NSString * imagelogo;

@end
