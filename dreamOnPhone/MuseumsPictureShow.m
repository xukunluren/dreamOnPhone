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

@interface MuseumsPictureShow ()<passvalueDelegate>

@end

@implementation MuseumsPictureShow
{
    NSArray *_imageArray;
    NSString *_story;
    NSString *_baiduUrl;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    
    [self setViewOfPicture];

}

-(void)viewWillAppear:(BOOL)animated
{
    self.tabBarController.tabBar.hidden = YES;
}
-(void)viewWillDisappear:(BOOL)animated
{ self.tabBarController.tabBar.hidden = NO;

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
    
    UILabel *story = [[UILabel alloc] initWithFrame:CGRectMake(15, self.view.frame.size.height*0.45, self.view.frame.size.width-30, self.view.frame.size.height*0.35)];
    story.text = _story;
    story.font = [UIFont systemFontOfSize:13.0];
    story.numberOfLines = 0;
    [self.view addSubview:story];
    
    
    UIButton *baiduButton = [[UIButton alloc] initWithFrame:CGRectMake(200, self.view.frame.size.height*0.8, 70, 30)];
    [baiduButton setTitle:@"百度百科" forState:UIControlStateNormal];
    baiduButton.backgroundColor = [UIColor grayColor];
    baiduButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [baiduButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [baiduButton addTarget:self action:@selector(openWeb) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:baiduButton];

}

-(void)passimage:(NSArray *)imagearray story:(NSString *)story baidu:(NSString *)baidu
{
    NSLog(@"%@",imagearray);
    _imageArray = imagearray;
    _story =story;
    _baiduUrl = baidu;
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
