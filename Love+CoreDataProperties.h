//
//  Love+CoreDataProperties.h
//  dreamOnPhone
//
//  Created by admin on 16/1/13.
//  Copyright © 2016年 xukun. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Love.h"

NS_ASSUME_NONNULL_BEGIN

@interface Love (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *address;
@property (nullable, nonatomic, retain) NSString *coverImage;
@property (nullable, nonatomic, retain) NSString *ider;
@property (nullable, nonatomic, retain) NSString *info;
@property (nullable, nonatomic, retain) NSString *infoImage;
@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSString *price;
@property (nullable, nonatomic, retain) NSString *tel;
@property (nullable, nonatomic, retain) NSString *opentime;

@end

NS_ASSUME_NONNULL_END
