//
//  Items.h
//  dreamOnPhone
//
//  Created by admin on 15/9/4.
//  Copyright (c) 2015年 xukun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Items : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * signId;
@property (nonatomic, retain) NSString * desc;
@property (nonatomic, retain) NSString * logo;
@property (nonatomic, retain) NSString * image1;
@property (nonatomic, retain) NSString * image2;
@property (nonatomic, retain) NSString * image3;
@property (nonatomic, retain) NSString * image4;
@property (nonatomic, retain) NSString * story;
@property (nonatomic, retain) NSString * wikiurl;
@property (nonatomic, retain) NSString * museumId;

@end
