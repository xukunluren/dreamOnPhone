//
//  MuseumsDetailShow.m
//  dreamOnPhone
//
//  Created by admin on 15/8/26.
//  Copyright (c) 2015年 xukun. All rights reserved.
//

#import "MuseumsDetailShow.h"
#import "DreamOfMuseumShow.h"
#import "UIImageView+WebCache.h"
#import "UMSocial.h"

@interface MuseumsDetailShow ()<passIdToDetailShowDelegate>

@end

@implementation MuseumsDetailShow
{
    UIImageView *_imageview;
    UIImageView *_backimage;
    NSString *_infoimage;
    NSString *_info;
    NSString *_title;
    UITextView *_imageTitleView;
    UILabel *_imageDetailLabel;
    UITextView *_detailtext;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"场馆简介";
    // Do any additional setup after loading the view.
//    self.view.backgroundColor = [UIColor yellowColor];
    
    [self setUI];
    [self setImageAndFont];
    //设置右barbutton
    UIImage *image = [UIImage imageNamed:@"share.png"];
    UIButton *myCustomButton = [UIButton buttonWithType:UIButtonTypeCustom];
    myCustomButton.bounds = CGRectMake( 0, 0, image.size.width, image.size.height );
    [myCustomButton setImage:image forState:UIControlStateNormal];
    [myCustomButton addTarget:self action:@selector(share) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIBarButtonItem *rightbar = [[UIBarButtonItem alloc] initWithCustomView:myCustomButton];
    
//    self.navigationItem.rightBarButtonItem = rightbar;
    
}

-(void)share
{
    NSString *shareText = @"";             //分享内嵌文字
    
    
//    NSURL *url = [NSURL URLWithString: _museumscoverImage];
//    //    UIImage *imagea = [UIImage imageWithData: [NSData dataWithContentsOfURL:url]];
//    UIImage *shareImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:url]];          //分享内嵌图片
    //
    //调用快速分享接口
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:@"55fcee3ce0f55a4ccb006a88"
                                      shareText:shareText
                                     shareImage:nil
                                shareToSnsNames:nil
                                       delegate:nil];
    
    
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

-(void)setUI
{
    _imageview = [[UIImageView alloc] init];
    CGFloat navigationH = self.view.frame.size.height;
    CGFloat navigationW = self.view.frame.size.width;
    _imageview.frame  = CGRectMake(0, 0, navigationW, navigationH);
    _imageview.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"loading.jpg"]];
    _imageview.contentMode = UIViewContentModeScaleAspectFill;
    _imageview.layer.masksToBounds = YES;
    _imageview.layer.cornerRadius = 5;
  
    [self.view addSubview:_imageview];
    
    
//    _backimage = [[UIImageView alloc] init];
//    CGFloat backimageH = self.view.frame.size.height *0.2;
//    CGFloat backimageW = self.view.frame.size.width;
    CGFloat imageH = self.view.frame.size.height *0.6;
//    _backimage.frame  = CGRectMake(0, imageH, backimageW, backimageH);
//    _backimage.backgroundColor = [UIColor colorWithRed:255 green:255 blue:0 alpha:0.2];
//    
//    _backimage.contentMode = UIViewContentModeCenter;
//    [_imageview addSubview:_backimage];
    
    _imageTitleView = [[UITextView alloc] initWithFrame:CGRectMake(2, imageH,self.view.frame.size.width,30)];
    _imageTitleView.text = @"展品导航";
    _imageTitleView.font = [UIFont systemFontOfSize:19];
    _imageTitleView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];
    _imageTitleView.textColor = [UIColor whiteColor];
    _imageTitleView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    _imageTitleView.textAlignment = NSTextAlignmentLeft;
    [_imageview addSubview:_imageTitleView];
    
    
    
    _detailtext = [[UITextView alloc] initWithFrame:CGRectMake(2, imageH+30, self.view.frame.size.width,80)];
    _detailtext.text = @"nihao";
    _detailtext.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    _detailtext.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];
    _detailtext.font = [UIFont systemFontOfSize:15];
    _detailtext.textColor = [UIColor whiteColor];
    
    [_imageview addSubview:_detailtext];
    

    

}

-(void)passIdToDetailShow:(NSString *)name ider:(NSString *)ider andInfo:(NSString *)info andInfoimage:(NSString *)infoimage
{
    _title = name;
    _info = info;
    _infoimage = infoimage;
    
    
    
    
}

-(void)setImageAndFont
{
    
    NSCharacterSet *set = [NSCharacterSet characterSetWithCharactersInString:@"@／：；（）¥「」＂、[]{}#%-*+=_\\|~＜＞$€^•'@#$%^&*()<br />_+'\""];
    NSLog(@"%@===%@===%@",_title,_info,_infoimage);
    NSURL *url = [NSURL URLWithString:_infoimage];
    UIImage *imageof = [UIImage imageWithData:[NSData dataWithContentsOfURL:url]];

    NSLog(@"%@",url);
//    [_imageview  sd_setImageWithURL:url];
    _imageview.image = imageof;
    NSString *detailtext = [_info stringByTrimmingCharactersInSet:set];
    NSLog(@"%@",detailtext);
    NSString *detailimagetext = [self stringDeleteString:detailtext];
    _imageTitleView.text = _title;
    _detailtext.text = detailimagetext;

    

}

-(NSString *) stringDeleteString:(NSString *)str
{
    NSMutableString *str1 = [NSMutableString stringWithString:str];
    for (int i = 0; i < str1.length; i++) {
        unichar c = [str1 characterAtIndex:i];
        NSRange range = NSMakeRange(i, 1);
        if (c == '<' || c == 'b' || c == 'r' || c == '/' || c == '>') { //此处可以是任何字符
            [str1 deleteCharactersInRange:range];
            --i;
        }
    }
    NSString *newstr = [NSString stringWithString:str1];
    return newstr;
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
