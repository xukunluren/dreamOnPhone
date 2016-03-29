//
//  saoMiaoResultViewController.m
//  dreamOnPhone
//
//  Created by admin on 16/1/4.
//  Copyright © 2016年 xukun. All rights reserved.
//

#import "saoMiaoResultViewController.h"
#import "AFNetworking.h"

#define KURL @"http://202.121.66.52:8010/"

@interface saoMiaoResultViewController ()

@end

@implementation saoMiaoResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(@"%@",_saoMiaoResult);
//    [self setViewWithString:_saoMiaoResult];
    [self setViewPage];
    
}

-(void)setViewPage
{
    NSString *result = _saoMiaoResult;
    NSLog(@"%@",result);
    NSString *leibie = [result substringToIndex:6];
    NSArray *stringArray = [leibie componentsSeparatedByString:@"|"];
    NSString *classes = [stringArray.firstObject substringFromIndex:1];
    NSArray *numberArray = [stringArray.lastObject componentsSeparatedByString:@"}"];
    NSString *number = numberArray.firstObject;
    NSLog(@"======%@====%@====%@",leibie,classes,number);
    NSString *item;
    if ([classes isEqualToString:@"4"]) {
        item = @"items";
    }else if ([classes isEqualToString:@"3"])
    {
    item = @"plants";
    }else if ([classes isEqualToString:@"2"])
    {
        item = @"plants";
    }
    else if ([classes isEqualToString:@"1"])
    {
        item = @"plants";
    }
    NSString *stringUrl = [NSString stringWithFormat:@"%@%@/%@",KURL,item,number];
    NSLog(@"%@",stringUrl);
  
    [self getItemsData:stringUrl];
}



-(void)getItemsData:(NSString *)stringurl
{
//    NSString *item = @"picture";
//    NSString *stringURL = [NSString stringWithFormat:@"%@/%@",KURL,item];
//    
    NSURL *url = [NSURL URLWithString:[stringurl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    //    NSLog(@"%@",url);
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *html = operation.responseString;
        NSData* data=[html dataUsingEncoding:NSUTF8StringEncoding];
        NSArray *result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        //        NSLog(@"%@",result);
        //对数据进行解析
        for(NSDictionary *dic in result){
            [self analysisData:dic];
        }
        
        NSLog(@"成功");
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"%@失败",error);
    }];
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [queue addOperation:operation];
    
    
    
}



-(void)analysisData:(NSDictionary *)object
{
   
}



-(void)setViewWithString:(NSString *)result
{
    NSString *iii = @"{4|46}才力樱:才力樱是日本著名的早樱花，以钟花樱为亲本选育而来。枝条纤细，花朵粉红而小巧繁密，主要用于小庭院的布置。-来自掌上梦之园APP";
    
    NSLog(@"%@",iii);
    NSString *leibie1 = [iii substringWithRange:NSMakeRange(3, 2)];
    NSString *num = [result substringWithRange:NSMakeRange(3, 2)];
    NSString *desc = [result substringFromIndex:6];
    

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
