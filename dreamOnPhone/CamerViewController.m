//
//  CamerViewController.m
//  dreamOnPhone
//
//  Created by sqhe18 on 16/2/29.
//  Copyright © 2016年 xukun. All rights reserved.
//

#import "CamerViewController.h"
#import "Scan_VC.h"

@interface CamerViewController ()

@end

@implementation CamerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.view.backgroundColor = [UIColor redColor];
    Scan_VC *scan = [[Scan_VC alloc] init];
    [self.navigationController pushViewController:scan animated:YES];
//    [self.navigationController popToViewController:scan animated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
