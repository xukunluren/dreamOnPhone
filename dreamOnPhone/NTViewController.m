//
//  NTViewController.m
//  tabbarDemo
//
//  Created by MD101 on 14-10-8.
//  Copyright (c) 2014年 TabBarDemo. All rights reserved.
//

#import "NTViewController.h"
#import "NTButton.h"
#import "RDVFirstViewController.h"
#import "DreamOfLifeViewController.h"
#import "DreamOfProductViewController.h"
#import "DreamOfEweakViewController.h"
#import "RDVFirthViewController.h"
#import "BaseNavigationViewController.h"

@interface NTViewController (){

    UIImageView *_tabBarView;//自定义的覆盖原先的tarbar的控件
    
    NTButton * _previousBtn;//记录前一次选中的按钮

}

@end

@implementation NTViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        self.view.backgroundColor = [UIColor clearColor];
        self.title = @"视图";
        // Custom initialization
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //wsq
    for (UIView* obj in self.tabBar.subviews) {
        if (obj != _tabBarView) {//_tabBarView 应该单独封装。
            [obj removeFromSuperview];
        }
//        if ([obj isKindOfClass:[]]) {
//            
//        }
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //self.tabBar.hidden = YES;
//    CGFloat tabBarViewY = self.view.frame.size.height - 49;
    
    
    //_tabBarView = [[UIImageView alloc]initWithFrame:CGRectMake(0, tabBarViewY, 320, 49)];
    //wsq
    _tabBarView = [[UIImageView alloc]initWithFrame:self.tabBar.bounds];
    _tabBarView.userInteractionEnabled = YES;
    _tabBarView.backgroundColor = [UIColor colorWithRed:0 green:0.8 blue:0.6 alpha:0.8];
    //[self.view addSubview:_tabBarView];
    //wsq
    [self.tabBar addSubview:_tabBarView];
    
    RDVFirstViewController * first = [[RDVFirstViewController alloc]init];
//    first.delegate = self;
    //wsq  多肽
    UINavigationController * navi1 = [[BaseNavigationViewController alloc]initWithRootViewController:first];
    DreamOfLifeViewController * second = [[DreamOfLifeViewController alloc]init];
    UINavigationController * navi2 = [[UINavigationController alloc]initWithRootViewController:second];
    DreamOfProductViewController * third = [[DreamOfProductViewController alloc]init];
    UINavigationController * navi3 = [[UINavigationController alloc]initWithRootViewController:third];
    DreamOfEweakViewController * fourth = [[DreamOfEweakViewController alloc]init];
    UINavigationController * navi4 = [[UINavigationController alloc]initWithRootViewController:fourth];
    RDVFirthViewController * firth = [[RDVFirthViewController alloc]init];
    UINavigationController * navi5 = [[UINavigationController alloc]initWithRootViewController:firth];
    self.viewControllers = [NSArray arrayWithObjects:navi1,navi2,navi3,navi4,navi5, nil];

    [self creatButtonWithNormalName:@"tabbar_client.png" andSelectName:@"tabbar_client_selected.png" andTitle:@"梦之园" andIndex:0];
    [self creatButtonWithNormalName:@"tabbar_product" andSelectName:@"tabbar_product_selected" andTitle:@"梦生命" andIndex:1];
    [self creatButtonWithNormalName:@"tabbar_info" andSelectName:@"tabbar_info_selected" andTitle:@"梦生活" andIndex:2];
    [self creatButtonWithNormalName:@"tabbar_more" andSelectName:@"tabbar_more_selected" andTitle:@"e周刊" andIndex:3];
    [self creatButtonWithNormalName:@"tabbar_more" andSelectName:@"tabbar_more_selected" andTitle:@"我的" andIndex:4];
    NTButton * button = _tabBarView.subviews[0];
    [self changeViewController:button];
    
    // Do any additional setup after loading the view.
}

#pragma mark 创建一个按钮

- (void)creatButtonWithNormalName:(NSString *)normal andSelectName:(NSString *)selected andTitle:(NSString *)title andIndex:(int)index{
    
    NTButton * customButton = [NTButton buttonWithType:UIButtonTypeCustom];
    customButton.tag = index;
    
    CGFloat buttonW = _tabBarView.frame.size.width / 4;
    CGFloat buttonH = _tabBarView.frame.size.height;
    
    customButton.frame = CGRectMake(80 * index, 0, buttonW, buttonH);
    [customButton setImage:[UIImage imageNamed:normal] forState:UIControlStateNormal];
    //[customButton setImage:[UIImage imageNamed:selected] forState:UIControlStateDisabled];
    //这里应该设置选中状态的图片。wsq
    [customButton setImage:[UIImage imageNamed:selected] forState:UIControlStateSelected];
    [customButton setTitle:title forState:UIControlStateNormal];
    
    [customButton addTarget:self action:@selector(changeViewController:) forControlEvents:UIControlEventTouchDown];
    
    customButton.imageView.contentMode = UIViewContentModeCenter;
    customButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    customButton.titleLabel.font = [UIFont systemFontOfSize:10];
   
    [_tabBarView addSubview:customButton];
    
    if(index == 0)//设置第一个选择项。（默认选择项） wsq
    {
        _previousBtn = customButton;
        _previousBtn.selected = YES;
    }

}

#pragma mark 按钮被点击时调用
- (void)changeViewController:(NTButton *)sender
 {
     if(self.selectedIndex != sender.tag){ //wsq®
         self.selectedIndex = sender.tag; //切换不同控制器的界面
         _previousBtn.selected = ! _previousBtn.selected;
         _previousBtn = sender;
         _previousBtn.selected = YES;
     }
}

#pragma mark 是否隐藏tabBar
//wsq
//-(void)isHiddenCustomTabBarByBoolean:(BOOL)boolean{
//    
//    _tabBarView.hidden=boolean;
//}

@end
