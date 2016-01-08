//
//  DreamOfLifeShow.m
//  dreamOnPhone
//
//  Created by admin on 15/8/19.
//  Copyright (c) 2015年 xukun. All rights reserved.
//

#import "DreamOfLifeShow.h"
#import "DreamOfLifeViewController.h"
#import "AFNetworking.h"
#import "UIImageView+WebCache.h"
#import "RDVTabBarController.h"

#import "TOWebViewController.h"

#define MainURL            @"http://202.121.66.52:8010"

@interface DreamOfLifeShow ()<passValueToShowDelegate>

@end

@implementation DreamOfLifeShow
{
    NSString *ID;
    UIImageView *_imageview;
    NSDictionary *_dictail;
    UILabel *_namelabel;
    UILabel *_classlabel;
    UILabel *_resourcelabel;
    UILabel *_detaillabel;
    NSString *_baiduUrl;
    UIWebView *_baiduWeb;
    UIButton *_complite;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    // 单击的 Recognizer
    UITapGestureRecognizer* singleRecognizer;
    singleRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(SingleTap:)];
    //点击的次数
    singleRecognizer.numberOfTapsRequired = 1; // 单击
    
    //给self.view添加一个手势监测；
    
    [self.view addGestureRecognizer:singleRecognizer];

    //设置UI的位置
    
    [self setImageView];
    [self analysdata];
}


-(void)SingleTap:(UITapGestureRecognizer*)recognizer
{
    //处理单击操作
     [[self rdv_tabBarController] setTabBarHidden:!self.rdv_tabBarController.tabBarHidden animated:YES];
    
}
//设置imageview的位置
-(void)setImageView
{
    //设置UIimageView的位置
    _imageview = [[UIImageView alloc] init];
     CGFloat imageH = self.view.frame.size.height*0.4;
    CGFloat width = self.view.frame.size.width-10;
    _imageview.frame  = CGRectMake(1, 5, width, imageH);
    _imageview.image = [UIImage imageNamed:@"backgroud@2x"];
    _imageview.layer.masksToBounds = YES;
    _imageview.layer.cornerRadius = 10;
    _imageview.contentMode = UIViewContentModeScaleAspectFill;
    _imageview.contentMode = UIViewContentModeCenter;
    [self.view addSubview:_imageview];

//设置namelabel的位置
    CGFloat nameT = imageH+10;
    _namelabel = [[UILabel alloc] initWithFrame:CGRectMake(5, nameT, width, 15)];
     CGFloat nameB = nameT+15;
    _namelabel.text = @"学名 ：";
    _namelabel.font = [UIFont systemFontOfSize:12.0];
    _namelabel.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:_namelabel];
//设置classlabel的位置
    CGFloat classT = nameB+5;
    _classlabel = [[UILabel alloc] initWithFrame:CGRectMake(5, classT, width, 15)];
    CGFloat classB = classT+15;
    _classlabel.text = @"科属 ：";
    _classlabel.font = [UIFont systemFontOfSize:12.0];
    _classlabel.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:_classlabel];
    
//设置resourcelabel的位置
    CGFloat resourceT = classB+5;
    _resourcelabel = [[UILabel alloc] initWithFrame:CGRectMake(5, resourceT, width, 15)];
    CGFloat resourceB = resourceT+5;
   _resourcelabel.font = [UIFont systemFontOfSize:12.0];
    _resourcelabel.text = @"原产地 ：";
    _resourcelabel.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:_resourcelabel];
    
//设置detaillabel的位置
    CGFloat detailT = resourceB+5;
    _detaillabel = [[UILabel alloc] initWithFrame:CGRectMake(5, detailT, width, 100)];
    CGFloat detailB = detailT+100;
    _detaillabel.numberOfLines = 5;
    _detaillabel.text = @"  ";
    _detaillabel.font = [UIFont systemFontOfSize:10.0];
    _detaillabel.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:_detaillabel];
    
//设置baiduButton的位置
    
    UIButton *baiduButton = [[UIButton alloc] initWithFrame:CGRectMake(10, detailB+5, 50, 30)];
    [baiduButton setTitle:@"百度百科" forState:UIControlStateNormal];
    baiduButton.backgroundColor = [UIColor blueColor];
    baiduButton.titleLabel.font = [UIFont systemFontOfSize:10];
    [baiduButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [baiduButton addTarget:self action:@selector(openWeb) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:baiduButton];
    
    _baiduWeb = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    _baiduWeb.hidden = YES;
    _baiduWeb.scalesPageToFit = YES;
    [self.view addSubview:_baiduWeb];
    
     _complite = [[UIButton alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height-20, 70, 20)];
    [_complite setTitle:@"完成" forState:UIControlStateNormal];
    [_complite setTintColor:[UIColor blueColor]];
//    _complite.titleLabel.textColor = [UIColor blueColor];
    _complite.backgroundColor = [UIColor grayColor];
    _complite.titleLabel.font = [UIFont systemFontOfSize:10.0];
    _complite.hidden = YES;
    [_complite addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [_baiduWeb addSubview:_complite];

}

-(void) passValueToShow:(NSString *)signid
{
  
    [self getFromCoredata:signid];
    NSLog(@"%@",signid);
}

-(void)getFromCoredata:(NSString *)sign{
    NSLog(@"%@",sign);
    
    
    NSString *museums = @"plants";
    NSString *stringURL = [NSString stringWithFormat:@"%@/%@/%@",MainURL,museums,sign];
    
    NSURL *url = [NSURL URLWithString:[stringURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSLog(@"%@",url);
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *html = operation.responseString;
        NSData* data=[html dataUsingEncoding:NSUTF8StringEncoding];
        NSArray *result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
                NSLog(@"%@",result);
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


-(void)analysisData:(NSDictionary *)dic
{
    _dictail = dic;
    NSString *name = [dic objectForKey:@"name"];
    NSString *xuemin = @"学名：";
        NSString *englishname = [dic objectForKey:@"english_name"];
    NSString *EnglishNa = [NSString stringWithFormat:@"%@%@",xuemin,englishname];
    NSString *keshu = @"科属：";
        NSString *family = [dic objectForKey:@"family"];
    NSString *Familys = [NSString stringWithFormat:@"%@%@",keshu,family];
    NSString *yuanchandi = @"原产地：";
        NSString *resource = [dic objectForKey:@"country_of_origin"];
    NSString *resources = [NSString stringWithFormat:@"%@%@",yuanchandi,resource];
        NSString *description = [dic objectForKey:@"description"];
        NSString *baidu = [dic objectForKey:@"baidu"];
    _baiduUrl = baidu;
    NSLog(@"%@",baidu);
        NSDictionary *image = [dic objectForKey:@"image"];
        NSString *imagUrl1 = [image objectForKey:@"url"];
        NSString *imageurl = [NSString stringWithFormat:@"%@%@",MainURL,imagUrl1];
    NSURL *url = [NSURL URLWithString:imageurl];
    self.navigationItem.title = name;
    _namelabel.text = EnglishNa;
    _classlabel.text = Familys;
    _resourcelabel.text = resources;
    _detaillabel.text = description;
    [_imageview sd_setImageWithURL:url];
    
    
}


-(void)analysdata
{
//    NSLog(@"%@",_dictail);
    
    

}

-(void)back{
    _baiduWeb.hidden = YES;
    
    _complite.hidden = YES;
        self.navigationController.navigationBarHidden = NO;
    
}

-(void)openWeb{
    
     TOWebViewController *webViewController = [[TOWebViewController alloc] initWithURL:[NSURL URLWithString:_baiduUrl]];
     [self presentViewController:[[UINavigationController alloc] initWithRootViewController:webViewController] animated:YES completion:nil];
    

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
