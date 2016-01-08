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

#define MainURL            @"http://202.121.66.52:8010"

@interface DreamOfMuseumShow ()<passSigleIdToShowViewDelegate>

@end

@implementation DreamOfMuseumShow
{
    NSString *_museumsname;
    NSString *_ID;
    NSString *_museumscoverImage;
    NSString *_info;
    NSString *_infoImage;
    NSString *_price;
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
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setPositionOfUI];
    [self setdetailValue];
    
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
    _museumsImageView.backgroundColor = [UIColor redColor];
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
    
    _priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, imageH*0.8, width*0.9, 40)];
    _priceLabel.text = _price;
    _priceLabel.font = [UIFont systemFontOfSize:14];
    _priceLabel.textColor = [UIColor whiteColor];
    _priceLabel.textAlignment = NSTextAlignmentRight;
    _priceLabel.backgroundColor =[UIColor clearColor];
    _priceLabel.opaque = 0.3;
    [_museumsImageView addSubview:_priceLabel];
    
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
    _navigationLabel.text = @"展品导航";
    _navigationLabel.font = [UIFont systemFontOfSize:10];
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
    _museumDyImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self.view addSubview:_museumDyImageView];
    //设置_museumsImageView上的label显示的字体
    _museumDylabel = [[UILabel alloc] initWithFrame:CGRectMake(2, 2, 100, 20)];
    _museumDylabel.text = @"场馆动态";
    _museumDylabel.font = [UIFont systemFontOfSize:10];
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
    _trafficInfoImageView.layer.cornerRadius = 5;
    _trafficInfoImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self.view addSubview:_trafficInfoImageView];
    //设置_museumsImageView上的label显示的字体
    _trafficInfoLabel = [[UILabel alloc] initWithFrame:CGRectMake(2, 2, 100, 20)];
    _trafficInfoLabel.text = @"交通信息";
    _trafficInfoLabel.font = [UIFont systemFontOfSize:10];
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
    _exhibitionLabel.text = @"展品图集";
    _exhibitionLabel.font = [UIFont systemFontOfSize:10];
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
    NSLog(@"收藏");

}

-(void)passsigleIdToShowView:(NSString *)sigle withname:(NSString *)name andcoverimage:(NSString *)coverimage andInfo:(NSString *)info andInfoImage:(NSString *)infoImage andPrice:(NSString *)price
{
    self.navigationItem.title = name;
    NSLog(@"%@",name);
//    _museumsLabel.text = name;
    _museumsname = name;
    _ID = sigle;
    _museumscoverImage = coverimage;
    _info =info;
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
    
    [_museumsImageView sd_setImageWithURL:url];
    _priceLabel.text= _price;


}



-(void)goToTheShow:(UITapGestureRecognizer *)gestureRecognizer
{

    MuseumsDetailShow *museumShow = [[MuseumsDetailShow alloc] init];
    self.delegate = museumShow;
    [self.delegate passIdToDetailShow:_museumsname ider:_ID andInfo:_info andInfoimage:_infoImage];
    
    [self.navigationController pushViewController:museumShow animated:YES];
    
    
}


//导航页面的跳转
-(void)navagationSingleTap
{
    NSLog(@"%@===%@",_ID,_museumsname);
    MuseumExihibit *exhibit = [[MuseumExihibit alloc] init];
    self.delegate = exhibit;
    [self.delegate passIdToDetailShow:_museumsname ider:_ID andInfo:nil andInfoimage:nil];
    
    [self.navigationController pushViewController:exhibit animated:YES];
    
}
//图片展示页面的跳转
-(void)exhibitionSingleTap
{
    ExibitPictureShow *exihibitionPictureShow = [[ExibitPictureShow alloc]init];
    exihibitionPictureShow.ider = _ID;
    [self.navigationController pushViewController:exihibitionPictureShow animated:YES];
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
