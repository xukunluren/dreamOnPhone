//
//  DreamOfMuseumShow.m
//  dreamOnPhone
//
//  Created by admin on 15/8/26.
//  Copyright (c) 2015年 xukun. All rights reserved.
//

#import "DreamOfMuseumShow.h"
#import "RDVFirstViewController.h"
#import "AFNetworking.h"
#import "UIImageView+WebCache.h"
#import "Museums.h"
#import "MuseumsDetailShow.h"
#import "MuseumExihibit.h"
#import "ExibitPictureShow.h"
#import "LPPopup.h"
#import "Love.h"
#import "Love+CoreDataProperties.h"
#import "shoucangMuseumTableViewController.h"
#import "UMSocial.h"
#import "dynamicalViewController.h"
#import "TOWebViewController.h"
#import "mapViewController.h"

#define MainURL            @"http://202.121.66.52:8010"

@interface DreamOfMuseumShow ()<passSigleIdToShowViewDelegate,passSigleIdToShowViewFromCenterDelegate>

@end

@implementation DreamOfMuseumShow
{
    NSString *_museumsname;
    NSString *_ID;
    NSString *_museumscoverImage;
    NSString *_info;
    NSString *_infoImage;
    NSString *_price;
    NSString *_tel;
    NSString *_address;
    NSString *_opentime;
    
    UIImageView *_museumsImageView;
    UILabel *_museumsLabel;
    UILabel *_priceLabel;
    UIButton *_love;
    UIImageView *_navigationImageView;
    UILabel *_navigationLabel;
    UIImageView *_museumDyImageView;
    UILabel *_museumDylabel;
    UIImageView *_trafficInfoImageView;
    UILabel *_trafficInfoLabel;
    UIImageView *_exhibitionImageView;
    UILabel *_exhibitionLabel;
    UIImageView *_questionImageView;
    UILabel *_questionLabel;
    NSMutableArray *_nameArray;
    NSInteger cnt;
    UILabel *_tel1;
    UILabel *_opentime1;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    _nameArray = [[NSMutableArray alloc] init];
    
    [self getEweakData];
    // Do any additional setup after loading the view.
    self.mydelegate =(AppDelegate *)[[UIApplication sharedApplication]delegate];
    [[LPPopup appearance] setPopupColor:[UIColor whiteColor]];
    //设置右barbutton
    UIImage *image = [UIImage imageNamed:@"share.png"];
    UIButton *myCustomButton = [UIButton buttonWithType:UIButtonTypeCustom];
    myCustomButton.bounds = CGRectMake( 0, 0, image.size.width, image.size.height );
    [myCustomButton setImage:image forState:UIControlStateNormal];
    [myCustomButton addTarget:self action:@selector(share) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIBarButtonItem *rightbar = [[UIBarButtonItem alloc] initWithCustomView:myCustomButton];
    
//    self.navigationItem.rightBarButtonItem = rightbar;
    [self setPositionOfUI];
    [self setdetailValue];
    
}

-(void)share
{
    NSString *shareText = _museumsname;             //分享内嵌文字
    
    
    NSURL *url = [NSURL URLWithString: _museumscoverImage];
//    UIImage *imagea = [UIImage imageWithData: [NSData dataWithContentsOfURL:url]];
    UIImage *shareImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:url]];          //分享内嵌图片
    //
    //调用快速分享接口
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:@"55fcee3ce0f55a4ccb006a88"
                                      shareText:shareText
                                     shareImage:shareImage
                                shareToSnsNames:nil
                                       delegate:nil];
    

}
//-(void)viewWillAppear:(BOOL)animated
//{
//    self.tabBarController.tabBar.hidden = YES;
//}
//-(void)viewWillDisappear:(BOOL)animated
//{
//    self.tabBarController.tabBar.hidden = NO;
//}
-(void)setPositionOfUI
{
    
    //设置UIimageView的位置
    _museumsImageView = [[UIImageView alloc] init];
    CGFloat imageH = self.view.frame.size.height*0.4;
    CGFloat width = self.view.frame.size.width-10;
    _museumsImageView.frame  = CGRectMake(5, 5, width, imageH);
//    _museumsImageView.backgroundColor = [UIColor redColor];
    _museumsImageView.image = [UIImage imageNamed:@"loading1.jpg"];
    _museumsImageView.layer.masksToBounds = YES;
    _museumsImageView.layer.cornerRadius = 5;
    _museumsImageView.contentMode = UIViewContentModeScaleAspectFill;
    _museumsImageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *signalTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(goToTheShow:)];
    [_museumsImageView addGestureRecognizer:signalTap];
    [self.view addSubview:_museumsImageView];
//设置_museumsImageView上的label显示的字体
    _love = [[UIButton alloc] initWithFrame:CGRectMake(2, 2, 50, 50)];
    [_love setImage:[UIImage imageNamed:@"love.png"] forState:UIControlStateNormal];
    [_love addTarget:self action:@selector(shoucang) forControlEvents:UIControlEventTouchUpInside];
    [_museumsImageView addSubview:_love];
    
    _priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(width*0.78, imageH*0.85, width*0.4, 40)];
    _priceLabel.text = _price;
    _priceLabel.font = [UIFont systemFontOfSize:20];
    _priceLabel.textColor = [UIColor whiteColor];
    _priceLabel.textAlignment = NSTextAlignmentLeft;
    _priceLabel.backgroundColor =[UIColor clearColor];
    _priceLabel.opaque = 0.3;
    [_museumsImageView addSubview:_priceLabel];
    
    _tel1 = [[UILabel alloc] initWithFrame:CGRectMake(5, imageH*0.78, width*0.45, 40)];
    NSString *tel =[NSString stringWithFormat:@"%@:%@",@"电话",_tel];
    _tel1.text = tel;
    _tel1.font = [UIFont systemFontOfSize:14];
    _tel1.textColor = [UIColor whiteColor];
    _tel1.textAlignment = NSTextAlignmentLeft;
    _tel1.backgroundColor =[UIColor clearColor];
    _tel1.opaque = 0.3;
    [_museumsImageView addSubview:_tel1];
    
    _opentime1 = [[UILabel alloc] initWithFrame:CGRectMake(5, imageH*0.85, width*0.6, 40)];
    NSString *openTime = [NSString stringWithFormat:@"%@:%@",@"营业时间",_opentime];
    _opentime1.text = openTime;
    _opentime1.font = [UIFont systemFontOfSize:14];
    _opentime1.textColor = [UIColor whiteColor];
    _opentime1.textAlignment = NSTextAlignmentLeft;
    _opentime1.backgroundColor =[UIColor clearColor];
    _opentime1.opaque = 0.3;
    [_museumsImageView addSubview:_opentime1];
    CGFloat museumH = imageH+8;

    //设置展品导航的位置
    _navigationImageView = [[UIImageView alloc] init];
    CGFloat navigationH = self.view.frame.size.height*0.25;
    CGFloat navigationW = self.view.frame.size.width*0.48;
    _navigationImageView.frame  = CGRectMake(5, museumH, navigationW, navigationH);
    _navigationImageView.backgroundColor = [UIColor blueColor];
    _navigationImageView.image = [UIImage imageNamed:@"btn_zpdl.png"];
    _navigationImageView.layer.masksToBounds = YES;
    _navigationImageView.layer.cornerRadius = 5;
    _navigationImageView.contentMode = UIViewContentModeScaleAspectFill;
    _navigationImageView.userInteractionEnabled=YES;
    UITapGestureRecognizer *singleTap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(navagationSingleTap)];
    [_navigationImageView addGestureRecognizer:singleTap];
    [self.view addSubview:_navigationImageView];
    //设置_museumsImageView上的label显示的字体
    _navigationLabel = [[UILabel alloc] initWithFrame:CGRectMake(2, 2, 100, 20)];
    _navigationLabel.text = @"  展品导航";
    _navigationLabel.font = [UIFont systemFontOfSize:14];
    _navigationLabel.textColor = [UIColor whiteColor];
    _navigationLabel.textAlignment = NSTextAlignmentLeft;
    [_navigationImageView addSubview:_navigationLabel];
    
    //设置场馆动态的位置
    _museumDyImageView = [[UIImageView alloc] init];
    CGFloat museumDyH = self.view.frame.size.height*0.15;
    CGFloat museumDyW = self.view.frame.size.width*0.48;
    CGFloat museumX = navigationW+8;
    _museumDyImageView.frame  = CGRectMake(museumX, museumH, museumDyW, museumDyH);
    _museumDyImageView.backgroundColor = [UIColor yellowColor];
    _museumDyImageView.image = [UIImage imageNamed:@"btn_zxhd.png"];
    _museumDyImageView.layer.masksToBounds = YES;
    _museumDyImageView.layer.cornerRadius = 5;
    _museumDyImageView.userInteractionEnabled=YES;
    UITapGestureRecognizer *dynamicalSingleTap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dynamicTap)];
    [_museumDyImageView addGestureRecognizer:dynamicalSingleTap];
    _museumDyImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self.view addSubview:_museumDyImageView];
    //设置_museumsImageView上的label显示的字体
    _museumDylabel = [[UILabel alloc] initWithFrame:CGRectMake(2, 2, 100, 20)];
    _museumDylabel.text = @" 场馆动态";
    _museumDylabel.font = [UIFont systemFontOfSize:14];
    _museumDylabel.textColor = [UIColor whiteColor];
    _museumDylabel.textAlignment = NSTextAlignmentLeft;
    [_museumDyImageView addSubview:_museumDylabel];
    
    //设置交通信息的位置
    _trafficInfoImageView = [[UIImageView alloc] init];
    CGFloat trafficInfoH = self.view.frame.size.height*0.15;
    CGFloat trafficInfoW = self.view.frame.size.width*0.48;
    CGFloat navigationB = self.view.frame.size.height*0.65+10;
    _trafficInfoImageView.frame  = CGRectMake(5, navigationB, trafficInfoW, trafficInfoH);
    _trafficInfoImageView.backgroundColor = [UIColor purpleColor];
    _trafficInfoImageView.image = [UIImage imageNamed:@"btn_jtxx.png"];
    _trafficInfoImageView.layer.masksToBounds = YES;
    
    _trafficInfoImageView.userInteractionEnabled=YES;
    UITapGestureRecognizer *dynamicalSingleTap11 =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dynamicTap1)];
    [_trafficInfoImageView addGestureRecognizer:dynamicalSingleTap11];
    _trafficInfoImageView.layer.cornerRadius = 5;
    _trafficInfoImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self.view addSubview:_trafficInfoImageView];
    //设置_museumsImageView上的label显示的字体
    _trafficInfoLabel = [[UILabel alloc] initWithFrame:CGRectMake(2, 2, 100, 20)];
    _trafficInfoLabel.text = @" 交通信息";
    _trafficInfoLabel.font = [UIFont systemFontOfSize:14];
    _trafficInfoLabel.textColor = [UIColor whiteColor];
    _trafficInfoLabel.textAlignment = NSTextAlignmentLeft;
    [_trafficInfoImageView addSubview:_trafficInfoLabel];
    
    //设置展品图集的位置
    _exhibitionImageView = [[UIImageView alloc] init];
    CGFloat museumDyB = self.view.frame.size.height*0.55+10;
    _exhibitionImageView.frame  = CGRectMake(museumX, museumDyB, trafficInfoW, navigationH);
//    _exhibitionImageView.backgroundColor = [UIColor greenColor];
    _exhibitionImageView.image = [UIImage imageNamed:@"btn_zptj.png"];
    _exhibitionImageView.layer.masksToBounds = YES;
    _exhibitionImageView.layer.cornerRadius = 5;
    _exhibitionImageView.userInteractionEnabled=YES;
    UITapGestureRecognizer *exhibitionSingleTap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(exhibitionSingleTap)];
    [_exhibitionImageView addGestureRecognizer:exhibitionSingleTap];
    _exhibitionImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self.view addSubview:_exhibitionImageView];
    //设置_museumsImageView上的label显示的字体
    _exhibitionLabel = [[UILabel alloc] initWithFrame:CGRectMake(2, 2, 100, 20)];
    _exhibitionLabel.text = @" 展品图集";
    _exhibitionLabel.font = [UIFont systemFontOfSize:14];
    _exhibitionLabel.textColor = [UIColor whiteColor];
    _exhibitionLabel.textAlignment = NSTextAlignmentLeft;
    [_exhibitionImageView addSubview:_exhibitionLabel];
    
    
    //设置科普问答的位置
//    _questionImageView = [[UIImageView alloc] init];
//    CGFloat questionH = self.view.frame.size.height*0.22;
//    CGFloat _exhibitionB = self.view.frame.size.height*0.65+18;
//    _questionImageView.frame  = CGRectMake(5, _exhibitionB, width, questionH);
//    _questionImageView.backgroundColor = [UIColor grayColor];
//    _questionImageView.image = [UIImage imageNamed:@"btn_kpwd.png"];
//    _questionImageView.layer.masksToBounds = YES;
//    _questionImageView.layer.cornerRadius = 5;
//    _questionImageView.contentMode = UIViewContentModeScaleAspectFill;
//    [self.view addSubview:_questionImageView];
//    //设置_museumsImageView上的label显示的字体
//    _questionLabel = [[UILabel alloc] initWithFrame:CGRectMake(2, 2, 100, 20)];
//    _questionLabel.text = @"科普问答";
//    _questionLabel.font = [UIFont systemFontOfSize:10];
//    _questionLabel.textColor = [UIColor whiteColor];
//    _questionLabel.textAlignment = NSTextAlignmentLeft;
//    [_questionImageView addSubview:_questionLabel];


}


-(void)shoucang
{
    
     [_love setImage:[UIImage imageNamed:@"love_select.png"] forState:UIControlStateNormal];
    
    NSInteger intId = 0;
    NSString *museums = @"Love";
    NSArray *signarray = [self getdatafromCoreData:museums];
    NSLog(@"%@",signarray);
    for (Love *museum in signarray) {
        if ([museum.ider isEqualToString:_ID]) {
            intId =1;
            //            NSLog(@"有重复数据");
        }
    }
    NSLog(@"%ld",(long)intId);
    if (intId == 0) {
        //        NSLog(@"此处添加数据");
        Love *love = (Love *)[NSEntityDescription insertNewObjectForEntityForName:@"Love" inManagedObjectContext:self.mydelegate.managedObjectContext];
        
        
        [love setValue:_ID forKey:@"ider"];
        [love setValue:_museumsname forKey:@"name"];
        [love setValue:_museumscoverImage forKey:@"coverImage"];
        [love setValue:_infoImage forKey:@"infoImage"];
        [love setValue:_info forKey:@"info"];
       
        [love setValue:_price forKey:@"price"];
        [love setValue:_address forKey:@"address"];
        [love setValue:_tel forKey:@"tel"];
        [love setValue:_opentime forKey:@"opentime"];
        
        
        NSError* error;
        BOOL isSaveSuccess=[self.mydelegate.managedObjectContext save:&error];
        if (!isSaveSuccess) {
            NSLog(@"Error:%@",error);
        }else{
            NSLog(@"Save successful!");
        }
    }
    
    NSLog(@"收藏");

}

/**
 *  从coredata数据库中获取数据
 */

-(NSArray *)getdatafromCoreData:(NSString *)par{
    
    
    
    NSFetchRequest* request=[[NSFetchRequest alloc] init];
    NSEntityDescription* user=[NSEntityDescription entityForName:par inManagedObjectContext:self.mydelegate.managedObjectContext];
    [request setEntity:user];
    
    NSError* error=nil;
    NSMutableArray* mutableFetchResult=[[_mydelegate.managedObjectContext executeFetchRequest:request error:&error] mutableCopy];
    if (mutableFetchResult==nil) {
        NSLog(@"Error:%@",error);
    }
    NSLog(@"The count of entry: %lu",(unsigned long)[mutableFetchResult count]);
    
    
    return mutableFetchResult;
    
}
-(void)passsigleIdToShowViewFromCenter:(NSString*)sigle withname:(NSString *)name andcoverimage:(NSString *)coverimage andInfo:(NSString *)info andInfoImage:(NSString *)infoImage andPrice:(NSString *)price andTel:(NSString *)tel andOpentime:(NSString *)opentime;
{
    self.navigationItem.title = name;
    NSLog(@"%@",name);
    //    _museumsLabel.text = name;
    _museumsname = name;
    _ID = sigle;
    _museumscoverImage = coverimage;
    _info =info;
    _tel = tel;
    _opentime = opentime;
    _infoImage = infoImage;
    NSLog(@"%@",price);
    _price = [NSString stringWithFormat:@"%@:%@",@"票价",price];
    
    _priceLabel.text= _price;
    [self setdetailValue];
    NSLog(@"%@",sigle);
}


-(void)passsigleIdToShowView:(NSString *)sigle withname:(NSString *)name andcoverimage:(NSString *)coverimage andInfo:(NSString *)info andInfoImage:(NSString *)infoImage andPrice:(NSString *)price andTel:(NSString *)tel andopenTime:(NSString *)opentime andAddress:(NSString *)address
{
    self.navigationItem.title = name;
    NSLog(@"%@",name);
    //    _museumsLabel.text = name;
    _museumsname = name;
    _ID = sigle;
    _museumscoverImage = coverimage;
    _info =info;
    _address = address;
    _tel = tel;
    _opentime = opentime;
    _infoImage = infoImage;
    NSLog(@"%@",price);
    _price = [NSString stringWithFormat:@"%@:%@",@"票价",price];
    
    _priceLabel.text= _price;
    [self setdetailValue];
    NSLog(@"%@",sigle);

}

-(void)setdetailValue{
    NSLog(@"%@%@",_museumsname,_museumscoverImage);
    _museumsLabel.text = _museumsname;
    NSURL *url = [NSURL URLWithString:_museumscoverImage];
    
    [_museumsImageView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"loading.jpg"]] ;
    _priceLabel.text= _price;


}



-(void)goToTheShow:(UITapGestureRecognizer *)gestureRecognizer
{

    MuseumsDetailShow *museumShow = [[MuseumsDetailShow alloc] init];
    self.delegate = museumShow;
    [self.delegate passIdToDetailShow:_museumsname ider:_ID andInfo:_info andInfoimage:_infoImage];
    [UIView transitionWithView:self.navigationController.view duration:0.2 options:UIViewAnimationOptionTransitionCurlUp animations:^{
        //      UIViewAnimationOptionTransitionCurlUp
        //        UIViewAnimationOptionTransitionCrossDissolve
        [self.navigationController pushViewController:museumShow animated:NO];
    } completion:^(BOOL finished) {
    }];
    
    
    
}


//导航页面的跳转
-(void)navagationSingleTap
{
    NSLog(@"%@===%@",_ID,_museumsname);
    if ([_ID isEqualToString:@"1"]||[_ID isEqualToString:@"2"]||[_ID isEqualToString:@"8"]) {
        MuseumExihibit *exhibit = [[MuseumExihibit alloc] init];
        self.delegate = exhibit;
        [self.delegate passIdToDetailShow:_museumsname ider:_ID andInfo:nil andInfoimage:nil];
        [UIView transitionWithView:self.navigationController.view duration:0.5 options:UIViewAnimationOptionTransitionCurlUp animations:^{
            //      UIViewAnimationOptionTransitionCurlUp
            //        UIViewAnimationOptionTransitionCrossDissolve
            [self.navigationController pushViewController:exhibit animated:NO];

        } completion:^(BOOL finished) {
            
        }];
       
    }else
    {
        LPPopup *popup = [LPPopup popupWithText:@"内容整理中..."];
        
        [popup showInView:self.view
            centerAtPoint:self.view.center
                 duration:kLPPopupDefaultWaitDuration
               completion:nil];

    
    }
    
}
//图片展示页面的跳转
-(void)exhibitionSingleTap
{
    if ([_ID isEqualToString:@"1"]||[_ID isEqualToString:@"2"]) {
    
    ExibitPictureShow *exihibitionPictureShow = [[ExibitPictureShow alloc]init];
    exihibitionPictureShow.ider = _ID;
    [UIView transitionWithView:self.navigationController.view duration:0.5 options:UIViewAnimationOptionTransitionCurlUp animations:^{
        //      UIViewAnimationOptionTransitionCurlUp
        //        UIViewAnimationOptionTransitionCrossDissolve
        [self.navigationController pushViewController:exihibitionPictureShow animated:NO];
        
    } completion:^(BOOL finished) {
        
    }];
    }else{
        LPPopup *popup = [LPPopup popupWithText:@"内容整理中..."];
        
        [popup showInView:self.view
            centerAtPoint:self.view.center
                 duration:kLPPopupDefaultWaitDuration
               completion:nil];

    }
   
}


-(void)dynamicTap1{
    
    
    
//    _ID;

    UIWebView *_webView = [[UIWebView alloc] initWithFrame:CGRectMake(0,0,self.view.bounds.size.width,self.view.bounds.size.height)];
//    NSString *htmlFile1 = [[NSBundle mainBundle] pathForResource:@"testmap" ofType:@"html"];
////    NSString *iddd = @"?id=";
////    
////    NSString *htmlFile= [NSString stringWithFormat:@"%@%@%@",htmlFile1,iddd,@"1"];
//    
//    //用于显示文档
////    NSString  *path1 = NSHomeDirectory();
////    NSLog(@"path:%@",path1);
////    NSURL *url = [[NSURL fileURLWithPath:NSHomeDirectory()]  URLByAppendingPathComponent:@"testmap.html"];
////    NSLog(@"url:%@",url);
////    
//    
//  
         NSString *path1 = @"http://app.bkfj.net/testmap.html?id=";
    NSString *path = [NSString stringWithFormat:@"%@%@",path1,_ID];
   
    NSURL *url = [NSURL URLWithString:path];
    
    // 2. 把URL告诉给服务器,请求,从m.baidu.com请求数据
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    // 3. 发送请求给服务器
    [_webView loadRequest:request];
    mapViewController *viewcontroller = [[mapViewController alloc] init];
    [viewcontroller.view addSubview:_webView];
    [self.navigationController pushViewController:viewcontroller animated:YES];
    
   
//    NSString *path =@"www.baidu.com";
    
//    NSString* path1 = [[NSBundle mainBundle] pathForResource:@"testmap" ofType:@"html"];
//    NSString *iddd = @"?";
//    NSString *path= [NSString stringWithFormat:@"%@%@%@",path1,iddd,@"id=1"];
//
//    NSLog(@"%@",path);
//    TOWebViewController *webViewController = [[TOWebViewController alloc] initWithURL:[NSURL URLWithString:path]];
//    [self presentViewController:[[UINavigationController alloc] initWithRootViewController:webViewController] animated:YES completion:nil];
//
    
//    UIWebView *webView1 = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
//    webView1.backgroundColor = [UIColor redColor];
//    NSString* path1 = [[NSBundle mainBundle] pathForResource:@"testmap" ofType:@"html"];
//    NSString *iddd = @"?";
//    NSString *path= [NSString stringWithFormat:@"%@%@%@",path1,iddd,@"id=1"];
////    NSString *path = [path2 stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    NSLog(@"%@",path);
//    NSURL* url = [NSURL fileURLWithPath:path];
//     NSLog(@"%@",url);
//    NSURLRequest* request = [NSURLRequest requestWithURL:url] ;
//     webView1.scalesPageToFit = YES;
//    [webView1 loadRequest:request];
//     [self.navigationController pushViewController:webView1 animated:NO];

//   /Users/admin/Desktop/kepu
//    NSURL* url = [NSURL fileURLWithPath:filePath];//创建URL
//    NSURLRequest* request = [NSURLRequest requestWithURL:url];//创建NSURLRequest
//    [webView loadRequest:request];//加载
    
//    UIWebView 还支持将一个NSString对象作为源来加载。你可以为其提供一个基础URL，来指导UIWebView对象如何跟随链接和加载远程资源：
    
//    [view loadHTMLString:myHTML baseURL:[NSURL URLWithString:@"http://baidu.com"]];

    
}

-(void)dynamicTap

{
    
    
    
    NSLog(@"%ld",(unsigned long)_nameArray.count);
   
    if (_nameArray.count<1) {
        LPPopup *popup = [LPPopup popupWithText:@"内容整理中..."];
        
        [popup showInView:self.view
            centerAtPoint:self.view.center
                 duration:kLPPopupDefaultWaitDuration
               completion:nil];
    }else{
    
        dynamicalViewController *dynamic = [[dynamicalViewController alloc] init];
        dynamic.titleString = @"场馆动态";
        dynamic.tag = @"1";
        dynamic.num = _ID;
        [UIView transitionWithView:self.navigationController.view duration:0.5 options:UIViewAnimationOptionTransitionCurlUp animations:^{
            //      UIViewAnimationOptionTransitionCurlUp
            //        UIViewAnimationOptionTransitionCrossDissolve
            [self.navigationController pushViewController:dynamic animated:NO];
            
        } completion:^(BOOL finished) {
            
        }];
        
    }


}



-(NSInteger)getEweakData
{
    
    
    [_nameArray removeAllObjects];
    NSString *items = @"event/museum";
    NSString *stringURL = [NSString stringWithFormat:@"%@/%@/%@",MainURL,items,_ID];
    NSLog(@"%@",stringURL);
    NSURL *url = [NSURL URLWithString:[stringURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *html = operation.responseString;
        NSData* data=[html dataUsingEncoding:NSUTF8StringEncoding];
        NSArray *result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        for(NSDictionary *dic in result){
            [self analysisEweeklyData:dic];
        }
        NSLog(@"%@",result);
        NSLog(@"成功");
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"%@失败",error);
    }];
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [queue addOperation:operation];
    return cnt;
    
}


-(void)analysisEweeklyData:(NSDictionary *)object
{
    
//    NSInteger intId = 0;
    //    NSLog(@"%@",object);
    NSString *name = [object objectForKey:@"name"];
    [_nameArray addObject:name];
    
//    NSNumber *iD = [object objectForKey:@"id"];
//    NSString *signid = [[NSString alloc]initWithFormat:@"%@",iD];
//    NSLog(@"%@",signid);
//    NSString *cover = [object objectForKey:@"cover"];
//    NSLog(@"%@",cover);
//    NSString *url = [object objectForKey:@"url"];
//    NSString *introduction = [object objectForKey:@"introduction"];
//    NSString *date = [object objectForKey:@"publish_date"];
//    NSNumber *number1 = [object objectForKey:@"no"];
//    NSString *number = [[NSString alloc] initWithFormat:@"%@",number1];
    
    
    
    
    
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
