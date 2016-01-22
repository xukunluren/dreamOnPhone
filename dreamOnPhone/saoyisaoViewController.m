//
//  saoyisaoViewController.m
//  dreamOnPhone
//
//  Created by admin on 16/1/6.
//  Copyright © 2016年 xukun. All rights reserved.
//

#import "saoyisaoViewController.h"
//#import "QRCodeReaderViewController.h"
#import "saoMiaoResultViewController.h"

@interface saoyisaoViewController ()

@end

@implementation saoyisaoViewController
{
    saoMiaoResultViewController *_saoMiao;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor redColor];
//    static QRCodeReaderViewController *reader = nil;
//    static dispatch_once_t onceToken;
//    
//    dispatch_once(&onceToken, ^{
//        reader                        = [QRCodeReaderViewController new];
//        reader.modalPresentationStyle = UIModalPresentationFormSheet;
//    });
//    reader.delegate = self;
//    [reader setCompletionWithBlock:^(NSString *resultAsString) {
//        NSLog(@"Completion with result: %@", resultAsString);
//    }];
//    [self presentViewController:reader animated:YES completion:NULL];
//
    
}


//#pragma mark - QRCodeReader Delegate Methods
//
//- (void)reader:(QRCodeReaderViewController *)reader didScanResult:(NSString *)result
//{
//    
//    [self dismissViewControllerAnimated:YES completion:^{
//        //        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"QRCodeReader" message:result delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
//        //        [alert show];
//        _saoMiao = [[saoMiaoResultViewController alloc] init];
//        _saoMiao.saoMiaoResult = result;
//        [self.navigationController pushViewController:_saoMiao animated:YES];
//        NSLog(@"%@",result);
//    }];
//}
//
//- (void)readerDidCancel:(QRCodeReaderViewController *)reader
//{
//    [self dismissViewControllerAnimated:YES completion:NULL];
//}
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
