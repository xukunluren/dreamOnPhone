//
//  Plants.h
//  dreamOnPhone
//
//  Created by admin on 15/8/12.
//  Copyright (c) 2015年 xukun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Plants : NSManagedObject

@property (nonatomic, retain) NSString * singleId;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * imageurl;
@property (nonatomic, retain) NSString * imagelogo;
@property (nonatomic, retain) NSString * address;

@end
