//
//  dynamicCell.m
//  dreamOnPhone
//
//  Created by shou on 16/1/19.
//  Copyright © 2016年 xukun. All rights reserved.
//

#import "dynamicCell.h"

@implementation dynamicCell

- (void)awakeFromNib {
    // Initialization code
    self.backimage.layer.cornerRadius = 5;
    self.backimage.layer.masksToBounds = YES;
    //    self.image.layer.borderWidth = 1.0;
    self.backimage.backgroundColor = [UIColor whiteColor];
//    self.backimage.layer.borderColor = [UIColor grayColor].CGColor;
//    self.backimage.layer.borderWidth = 1;
//    self.detail.lineBreakMode = UILineBreakModeCharacterWrap;
    
    self.datelable.layer.cornerRadius = 2;
    self.datelable.layer.masksToBounds = YES;
    //    self.image.layer.borderWidth = 1.0;
    self.datelable.backgroundColor = [UIColor grayColor];
    
    self.biaoshi.layer.cornerRadius = 5;
    self.biaoshi.layer.masksToBounds = YES;

    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
