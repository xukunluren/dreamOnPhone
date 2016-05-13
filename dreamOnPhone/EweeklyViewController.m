//
//  EweeklyViewController.m
//  dreamOnPhone
//
//  Created by shou on 16/1/20.
//  Copyright © 2016年 xukun. All rights reserved.
//

#import "EweeklyViewController.h"
#import "UMSocial.h"
#import "AFNetworking.h"
#define MainURL @"http://202.121.66.52:8010"

@interface EweeklyViewController ()<UIWebViewDelegate>

@end

@implementation EweeklyViewController
{
    NSMutableArray *_urlArray;
    NSString *_urlString;
}

-(void)viewDidAppear:(BOOL)animated
{
//    NSUserDefaults *userdefaults = [NSUserDefaults standardUserDefaults];
//    [userdefaults removeObjectForKey:@"number"];
//    int number = 3;
//    [userdefaults setInteger:number forKey:@"number"];
    
    self.tabBarController.tabBar.hidden = YES;
    [self.tabBarController.view subviews].lastObject.hidden = YES;
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    self.tabBarController.tabBar.hidden = NO;
    [self.tabBarController.view subviews].lastObject.hidden = NO;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    // Do any additional setup after loading the view.
    _urlArray = [[NSMutableArray alloc] init];
//    [self getEweeklyData];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [self.navigationController.navigationBar
     setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:67.0/255.0 green:148.0/255.0 blue:247.0/255.0 alpha:1.0];
    self.navigationController.navigationBar.translucent = NO;
    
    self.title = @"E周刊";
    
    //设置右barbutton
    UIImage *image = [UIImage imageNamed:@"Share.png"];
    UIButton *myCustomButton = [UIButton buttonWithType:UIButtonTypeCustom];
    myCustomButton.bounds = CGRectMake( 0, 0, image.size.width, image.size.height );
    [myCustomButton setImage:image forState:UIControlStateNormal];
    [myCustomButton addTarget:self action:@selector(share) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIBarButtonItem *rightbar = [[UIBarButtonItem alloc] initWithCustomView:myCustomButton];

    
    
    //设置右barbutton
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 60, 30)];
    
    UIImage *image1 = [UIImage imageNamed:@"back@2x.png"];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(-10, 0, 30, 30)];
    imageView.image = image1;
    imageView.contentMode = UIViewContentModeScaleToFill;
    [view addSubview:imageView];

    UIButton *leftCustomButton = [[UIButton alloc] initWithFrame:CGRectMake(20, 0, 40, 30)];
    [leftCustomButton setTitle:@"返回" forState:UIControlStateNormal];
    [leftCustomButton.titleLabel setTextColor:[UIColor whiteColor]];
    leftCustomButton.titleLabel.font = [UIFont systemFontOfSize:16.0];
    [leftCustomButton addTarget:self action:@selector(backToOtherView) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:leftCustomButton];
    
    
    UIBarButtonItem *leftbar = [[UIBarButtonItem alloc] initWithCustomView:view];

    self.navigationItem.rightBarButtonItem = rightbar;
       self.navigationItem.leftBarButtonItem = leftbar;
//    [self.navigationItem setLeftBarButtonItems:[NSArray arrayWithObjects:left1,leftbar, nil]];
    [self setWebView];
    
   
}

-(void)backToOtherView
{
    NSUserDefaults *userdefaults = [NSUserDefaults standardUserDefaults];
    NSInteger iii = [userdefaults integerForKey:@"number"];
    NSLog(@"%ld",(long)iii);
    [self.tabBarController setSelectedIndex:iii];
    
}
-(void)setWebView
{
    _eweeklyWeb = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
//    NSString *url = _urlArray.firstObject;
    _urlString = @"http://www.bkfj.net/bkeweekly/mobile.aspx";
    NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString:_urlString]];
    [self.view addSubview: _eweeklyWeb];
    [_eweeklyWeb loadRequest:request];
}
-(void)getEweeklyData{

    [_urlArray removeAllObjects];
    NSString *items = @"eweekly";
    NSString *stringURL = [NSString stringWithFormat:@"%@/%@",MainURL,items];
    NSLog(@"%@",stringURL);
    NSURL *url = [NSURL URLWithString:[stringURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *html = operation.responseString;
        NSData* data=[html dataUsingEncoding:NSUTF8StringEncoding];
        NSArray *result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        NSLog(@"%@",result);
        //对数据进行解析
        for(NSDictionary *dic in result){
            [self analysisEweeklyData:dic];
        }
        [self setWebView];
        NSLog(@"成功");
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"%@失败",error);
    }];
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [queue addOperation:operation];
}


-(void)analysisEweeklyData:(NSDictionary *)dic
{
    NSString *url = [dic objectForKey:@"url"];
    [_urlArray addObject:url];

}
-(void)share
{
    NSString *shareText = _urlString;             //分享内嵌文字
    
    
    //    NSURL *url = [NSURL URLWithString: _museumscoverImage];
    //    //    UIImage *imagea = [UIImage imageWithData: [NSData dataWithContentsOfURL:url]];
    //    UIImage *shareImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:url]];          //分享内嵌图片
    //
    //调用快速分享接口
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:@"55fcee3ce0f55a4ccb006a88"
                                      shareText:shareText
                                     shareImage:nil
                                shareToSnsNames:@[UMShareToWechatSession,UMShareToWechatTimeline,UMShareToWechatFavorite,UMShareToSina,UMShareToTencent,UMShareToSms]
                                       delegate:nil];
    [UMSocialData defaultData].extConfig.wechatSessionData.url =shareText;
    
    [UMSocialData defaultData].extConfig.wechatTimelineData.url = shareText;
    
    
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
