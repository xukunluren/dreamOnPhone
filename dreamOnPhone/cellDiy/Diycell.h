//
//  Diycell.h
//  dreamOnPhone
//
//  Created by admin on 15/9/3.
//  Copyright (c) 2015年 xukun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Diycell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *detail;
@property (weak, nonatomic) IBOutlet UIButton *button;
@property (strong, nonatomic) IBOutlet UIButton *love;
@property (weak, nonatomic) IBOutlet UILabel *price;
@property (weak, nonatomic) IBOutlet UIImageView *image;

- (IBAction)love:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *saomiao;
@end
