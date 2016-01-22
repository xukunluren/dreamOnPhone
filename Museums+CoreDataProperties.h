//
//  Museums+CoreDataProperties.h
//  dreamOnPhone
//
//  Created by admin on 16/1/13.
//  Copyright © 2016年 xukun. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Museums.h"

NS_ASSUME_NONNULL_BEGIN

@interface Museums (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *adress;
@property (nullable, nonatomic, retain) NSString *coverImage;
@property (nullable, nonatomic, retain) NSString *feature;
@property (nullable, nonatomic, retain) NSString *imageLogo;
@property (nullable, nonatomic, retain) NSString *imageUrl;
@property (nullable, nonatomic, retain) NSString *info;
@property (nullable, nonatomic, retain) NSString *info_Image;
@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSString *price;
@property (nullable, nonatomic, retain) NSString *signid;
@property (nullable, nonatomic, retain) NSString *tel;
@property (nullable, nonatomic, retain) NSString *opentime;

@end

NS_ASSUME_NONNULL_END
