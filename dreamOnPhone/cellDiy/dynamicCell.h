//
//  dynamicCell.h
//  dreamOnPhone
//
//  Created by shou on 16/1/19.
//  Copyright © 2016年 xukun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface dynamicCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *detailTitle;
@property (weak, nonatomic) IBOutlet UIImageView *backimage;
@property (weak, nonatomic) IBOutlet UILabel *datelable;
@property (weak, nonatomic) IBOutlet UILabel *biaoshi;
@property (weak, nonatomic) IBOutlet UILabel *museumName;

@end
