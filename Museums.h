//
//  Museums.h
//  dreamOnPhone
//
//  Created by admin on 15/8/12.
//  Copyright (c) 2015年 xukun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Museums : NSManagedObject

@property (nonatomic, retain) NSString * adress;
@property (nonatomic, retain) NSString * coverImage;
@property (nonatomic, retain) NSString * feature;
@property (nonatomic, retain) NSString * signid;
@property (nonatomic, retain) NSString * imageLogo;
@property (nonatomic, retain) NSString * imageUrl;
@property (nonatomic, retain) NSString * info;
@property (nonatomic, retain) NSString * info_Image;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * price;

@end
