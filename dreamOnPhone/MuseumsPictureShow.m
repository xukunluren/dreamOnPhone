//
//  MuseumsPictureShow.m
//  dreamOnPhone
//
//  Created by admin on 15/9/4.
//  Copyright (c) 2015年 xukun. All rights reserved.
//

#import "MuseumsPictureShow.h"
#import "DJPageView.h"
#import "MuseumExihibit.h"
#import "TOWebViewController.h"
#import "Scan_VC.h"
#import "UMSocial.h"
#import "UIImageView+WebCache.h"
#import "common.h"

@interface MuseumsPictureShow ()<passvalueDelegate,passvalueFromSaoMiaoDelegate>

@end

@implementation MuseumsPictureShow
{
    NSArray *_imageArray;
    NSString *_story;
    NSString *_baiduUrl;
    NSString *_imageUrl;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];

    
    [self setViewOfPicture];
    //设置右barbutton
//    UIImage *image = [UIImage imageNamed:@"share.png"];
//    UIButton *myCustomButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    myCustomButton.bounds = CGRectMake( 0, 0, image.size.width, image.size.height );
//    [myCustomButton setImage:image forState:UIControlStateNormal];
//    [myCustomButton addTarget:self action:@selector(share) forControlEvents:UIControlEventTouchUpInside];
//    
//    
//    
//    
//    
//    UIBarButtonItem *rightbar = [[UIBarButtonItem alloc] initWithCustomView:myCustomButton];
//    
//    self.navigationItem.rightBarButtonItem = rightbar;
    
    
    
    
    //设置右barbutton
    UIImage *image = [UIImage imageNamed:@"Share.png"];
    
    UIButton *myCustomButton = [UIButton buttonWithType:UIButtonTypeCustom];
    myCustomButton.bounds = CGRectMake( 0, 0, image.size.width, image.size.height );
    [myCustomButton setImage:image forState:UIControlStateNormal];
    [myCustomButton addTarget:self action:@selector(share) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightbar = [[UIBarButtonItem alloc] initWithCustomView:myCustomButton];
    self.navigationItem.rightBarButtonItem = rightbar;
}

-(void)share
{
    NSString *shareText = _story;
    
     NSString *shareUrl = [NSString stringWithFormat:@"%@%@",SHARE_URL,self.ider];
    //分享内嵌文字
//    UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:_imageUrl]];
    UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:_imageUrl]]];
    
//        NSURL *url = [NSURL URLWithString: _museumscoverImage];
//        //    UIImage *imagea = [UIImage imageWithData: [NSData dataWithContentsOfURL:url]];
//        UIImage *shareImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:url]];          //分享内嵌图片
    //
    //调用快速分享接口
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:@"55fcee3ce0f55a4ccb006a88"
                                      shareText:shareText
                                     shareImage:image
                                shareToSnsNames:@[UMShareToWechatSession,UMShareToWechatTimeline,UMShareToWechatFavorite,UMShareToSina,UMShareToTencent,UMShareToSms]
                                       delegate:nil];
    
    [UMSocialData defaultData].extConfig.wechatSessionData.url =shareUrl;
    
    [UMSocialData defaultData].extConfig.wechatTimelineData.url = shareUrl;
}
-(void)viewWillAppear:(BOOL)animated
{
    self.tabBarController.tabBar.hidden = YES;
    [self.tabBarController.view subviews].lastObject.hidden = YES;
}
-(void)viewWillDisappear:(BOOL)animated
{
    self.tabBarController.tabBar.hidden = NO;
    [self.tabBarController.view subviews].lastObject.hidden = NO;

}


-(void)setViewOfPicture
{
    
    DJPageView *pageView = [[DJPageView alloc] initPageViewFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.frame.size.height*0.45) webImageStr:_imageArray didSelectPageViewAction:^(NSInteger index) {
        ;NSLog(@"%ld",(long)index);
    }];
    
    //停留时间
    pageView.duration = 2.0;
    pageView.pageBackgroundColor = [UIColor clearColor];
    pageView.pageIndicatorTintColor = [UIColor orangeColor];
    pageView.currentPageColor = [UIColor blueColor];
    [self.view addSubview:pageView];
    
    _storyLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, self.view.frame.size.height*0.45, self.view.frame.size.width-30, self.view.frame.size.height*0.4)];
//    _storyLabel.text = _story;
    _storyLabel.font = [UIFont systemFontOfSize:16.0];
    _storyLabel.numberOfLines = 0;
    
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:_story];
    //设置字体颜色
    [text addAttribute:NSForegroundColorAttributeName value:[UIColor grayColor] range:NSMakeRange(0, text.length)];
    
    //设置缩进、行距
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    style.headIndent = 0;//缩进
    style.firstLineHeadIndent = 30;
    style.lineSpacing = 10;//行距
    [text addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, text.length)];
    
    _storyLabel.attributedText = text;
    
    [self.view addSubview:_storyLabel];
    
    UIButton *baiduButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    baiduButton.frame = CGRectMake(self.view.frame.size.width*0.8, self.view.frame.size.height*0.85, 70, 30);
    [baiduButton setTitle:@"百度百科" forState:UIControlStateNormal];
    
//    [baiduButton.layer  setMasksToBounds:YES];
//    [baiduButton.layer setCornerRadius:10.0f];
    baiduButton.backgroundColor = [UIColor groupTableViewBackgroundColor];
    baiduButton.autoresizesSubviews = YES;
    
    baiduButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [baiduButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [baiduButton addTarget:self action:@selector(openWeb) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:baiduButton];

}




//从表格中点击进来展示的代理
-(void)passimage:(NSArray *)imagearray withTitle:(NSString *)title story:(NSString *)story baidu:(NSString *)baidu
{
    NSLog(@"%@",title);
    self.navigationItem.title = title;
    NSLog(@"%@",imagearray);
    _imageArray = imagearray;
    _story =story;
    _baiduUrl = baidu;
    _imageUrl = imagearray.firstObject;
}


//从二维码扫描进入的展品的代理
-(void)passimageFromSaoMiao:(NSArray *)imagearray story:(NSString *)story baidu:(NSString *)baidu
{
    _imageArray = imagearray;
    _story = story;
    _baiduUrl = baidu;
    _imageUrl = imagearray.firstObject;
}



-(void)openWeb{
    
    TOWebViewController *webViewController = [[TOWebViewController alloc] initWithURL:[NSURL URLWithString:_baiduUrl]];
    [self presentViewController:[[UINavigationController alloc] initWithRootViewController:webViewController] animated:YES completion:nil];

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
