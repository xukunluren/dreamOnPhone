//
//  ExibitPictureShow.m
//  dreamOnPhone
//
//  Created by admin on 15/9/8.
//  Copyright (c) 2015年 xukun. All rights reserved.
//

#import "ExibitPictureShow.h"
#import "IntroControll.h"

#import "AFNetworking.h"
#import <CoreData/CoreData.h>
#import "BWMCoverView.h"
#import "UMSocial.h"



#define MainURL            @"http://202.121.66.52:8010"
@interface ExibitPictureShow ()

@end

@implementation ExibitPictureShow
{
    NSMutableArray *_Array;
    NSMutableArray *_nameArray;
    NSMutableArray *_imageArray;
    BWMCoverView *_coverView;
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

- (void)viewDidLoad {
    [super viewDidLoad];
    _nameArray = [[NSMutableArray alloc] init];
    _imageArray = [[NSMutableArray alloc] init];
    _Array = [[NSMutableArray alloc] init];
    self.navigationItem.title = @"展品图集";
    [self getItemsData];
//    [self setPicture];
    //设置右barbutton
    UIImage *image = [UIImage imageNamed:@"Share.png"];
    UIButton *myCustomButton = [UIButton buttonWithType:UIButtonTypeCustom];
    myCustomButton.bounds = CGRectMake( 0, 0, image.size.width, image.size.height );
    [myCustomButton setImage:image forState:UIControlStateNormal];
    [myCustomButton addTarget:self action:@selector(share1) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIBarButtonItem *rightbar = [[UIBarButtonItem alloc] initWithCustomView:myCustomButton];
    
//    self.navigationItem.rightBarButtonItem = rightbar;
    
}

-(void)share1
{
    NSString *shareText = @"nihao";             //分享内嵌文字
    
    
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
-(void)setPicture
{
    NSMutableArray *realArray = [[NSMutableArray alloc] init];
    NSLog(@"%lu",(unsigned long)_imageArray.count);
    for (int i = 0; i<_imageArray.count; i++) {
        NSString *url = _imageArray[i];
        NSString *imageStr = url;
        NSString *name = _nameArray[i];
        NSString *imageTitle = name;
        BWMCoverViewModel *model = [[BWMCoverViewModel alloc] initWithImageURLString:imageStr imageTitle:imageTitle];
        [realArray addObject:model];
    }
    
    _coverView = [BWMCoverView coverViewWithModels:realArray andFrame:self.view.frame andPlaceholderImageNamed:BWMCoverViewDefaultImage andClickdCallBlock:^(NSInteger index) {
        NSLog(@"你点击了第%ld个图片", (long)index);
    }];
    _coverView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    _coverView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"mountains.png"]];
    [self.view addSubview:_coverView];
    
    // 只需以上两句即可创建BWMCoverView了，也可以继续往下看，自定义更多效果
    
    // 滚动视图每一次滚动都会回调此方法
    [_coverView setScrollViewCallBlock:^(NSInteger index) {
        NSLog(@"当前滚动到第%ld个页面", (long)index);
    }];
    
    // 请打开下面的东西逐个调试
    [_coverView setAutoPlayWithDelay:4.0]; // 设置自动播放
    _coverView.imageViewsContentMode = UIViewContentModeScaleAspectFill; // 图片显示内容模式模式
    
#warning 修改属性后必须调用updateView方法
  
    
}

/**
 *  获取梦之园的图片数据
 */
-(void)getItemsData
{
    NSString *stringURL = [NSString stringWithFormat:@"%@/%@/%@/%@",MainURL,@"picture",@"museum",_ider];
    
    NSURL *url = [NSURL URLWithString:[stringURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        NSLog(@"%@",url);
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *html = operation.responseString;
        NSData* data=[html dataUsingEncoding:NSUTF8StringEncoding];
        NSArray *result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
    //对数据进行解析
        for(NSDictionary *dic in result){
            [self analysisData:dic];
        }
        NSLog(@"%@",_nameArray);
        [_coverView updateView];
        [self setPicture];
//        [self setimageWithName:_nameArray image:_imageArray];
       
        NSLog(@"成功");
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"%@失败",error);
    }];
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [queue addOperation:operation];
    


    
}



-(void)analysisData:(NSDictionary *)object
{
    NSLog(@"%@",object);
    NSString *name = [object objectForKey:@"name"];
    NSDictionary *imageurl = [object objectForKey:@"url"];
    NSString *image1 = [imageurl objectForKey:@"url"];
    NSString *image = [NSString stringWithFormat:@"%@%@",MainURL,image1];
   
    [_nameArray addObject:name];
    NSLog(@"%@",_nameArray);
    [_imageArray addObject:image];
    
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
