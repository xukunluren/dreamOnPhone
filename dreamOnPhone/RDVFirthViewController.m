//
//  RDVFirthViewController.m
//  dreamOnPhone
//
//  Created by admin on 15/8/6.
//  Copyright (c) 2015年 xukun. All rights reserved.
//

#import "RDVFirthViewController.h"
#import "UMSocial.h"


@interface RDVFirthViewController ()

@end

@implementation RDVFirthViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"个人中心";
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
//    self.navigationController.navigationBar.barTintColor = [UIColor blackColor];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [self.navigationController.navigationBar
     setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    self.navigationController.navigationBar.translucent = NO;
    
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:67.0/255.0 green:148.0/255.0 blue:247.0/255.0 alpha:1.0];
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    UIImage *image = [UIImage imageNamed:@"scaning.png"];
    UIButton *myCustomButton = [UIButton buttonWithType:UIButtonTypeCustom];
    myCustomButton.bounds = CGRectMake( 0, 0, image.size.width, image.size.height );
    [myCustomButton setImage:image forState:UIControlStateNormal];
    //    [myCustomButton addTarget:nil action:@selector(goBack:) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIBarButtonItem *rightbar = [[UIBarButtonItem alloc] initWithCustomView:myCustomButton];

    self.navigationItem.rightBarButtonItem = rightbar;
//    self.title = @"我的";
    // Do any additional setup after loading the view.
}
-(void)share{
    
    
////    
//    NSString *shareText = @"软件分享测试";             //分享内嵌文字
////    UIImage *shareImage = [UIImage imageNamed:@"UMS_social_demo"];          //分享内嵌图片
//    
//    //调用快速分享接口
//    [UMSocialSnsService presentSnsIconSheetView:self
//                                         appKey:@"55fcee3ce0f55a4ccb006a88"
//                                      shareText:shareText
//                                     shareImage:nil
//                                shareToSnsNames:nil
//                                       delegate:nil];
//
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
