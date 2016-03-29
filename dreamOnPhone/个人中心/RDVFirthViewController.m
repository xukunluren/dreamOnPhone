//
//  RDVFirthViewController.m
//  dreamOnPhone
//
//  Created by admin on 15/8/6.
//  Copyright (c) 2015年 xukun. All rights reserved.
//

#import "RDVFirthViewController.h"
#import "UMSocial.h"
#import "Love+CoreDataProperties.h"
#import "Love.h"
#import "CenterCell.h"
#import "UIImageView+WebCache.h"
#import "RDVTabBarController.h"
#import "DreamOfMuseumShow.h"
#import "shoucangMuseumTableViewController.h"
//#import "JC_NacAnimation.h"


@interface RDVFirthViewController ()<UITableViewDataSource,UITableViewDelegate,UINavigationControllerDelegate>



@end

@implementation RDVFirthViewController
{
    UITableView *_tableView;
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"个人中心";
    }
    return self;
}
-(void)viewDidAppear:(BOOL)animated
{
    NSUserDefaults *userdefaults = [NSUserDefaults standardUserDefaults];
    [userdefaults removeObjectForKey:@"number"];
    int number = 4;
    [userdefaults setInteger:number forKey:@"number"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.mydelegate =(AppDelegate *)[[UIApplication sharedApplication]delegate];
    self.view.backgroundColor = [UIColor grayColor];
    
    
    //设置右barbutton
    UIImage *image = [UIImage imageNamed:@"Share.png"];
    UIButton *myCustomButton = [UIButton buttonWithType:UIButtonTypeCustom];
    myCustomButton.bounds = CGRectMake( 0, 0, image.size.width, image.size.height );
    [myCustomButton setImage:image forState:UIControlStateNormal];
    [myCustomButton addTarget:self action:@selector(share) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIBarButtonItem *rightbar = [[UIBarButtonItem alloc] initWithCustomView:myCustomButton];
    
//    self.navigationItem.rightBarButtonItem = rightbar;

    
    
//    self.navigationController.navigationBar.barTintColor = [UIColor blackColor];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [self.navigationController.navigationBar
     setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    self.navigationController.navigationBar.translucent = NO;
    
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:67.0/255.0 green:148.0/255.0 blue:247.0/255.0 alpha:1.0];
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    NSString *museums = @"Love";
    NSArray *signarray = [self getdatafromCoreData:museums];
    NSLog(@"%@",signarray);
    
    
    
    [self setViewOfCenter];

    
    
    
//    self.title = @"我的";
    // Do any additional setup after loading the view.
}

-(void)setViewOfCenter
{
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height*0.3)];
    imageView.image = [UIImage imageNamed:@"centerback.jpeg"];
//    imageView.alpha = 0.5;
    [self.view addSubview:imageView];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height*0.3)];
    view.backgroundColor = [UIColor whiteColor];
    view.alpha = 0.5;
    [self.view addSubview:view];
    
    
    
    
    UIImageView *iconView = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width*0.5-40,self.view.frame.size.height*0.12, 80,80)];
    iconView.image = [UIImage imageNamed:@"iconback.jpg"];
//                      @"iconOfCenter.jpeg"];
    iconView.layer.masksToBounds = YES;
    iconView.layer.cornerRadius = iconView.bounds.size.width * 0.5;
    iconView.layer.borderWidth = 3.0;
    iconView.contentMode = UIViewContentModeScaleAspectFill;
    iconView.layer.borderColor = [UIColor whiteColor].CGColor;
//    [view addSubview:iconView];
    [self.view insertSubview:iconView aboveSubview:view];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height*0.3, self.view.frame.size.width, self.view.frame.size.height*0.8)];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
    
    
    
    
    

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

-(void)share{
    
    
////    
    NSString *shareText = @"软件分享测试";             //分享内嵌文字
    UIImage *shareImage = [UIImage imageNamed:@"UMS_social_demo"];          //分享内嵌图片
//
    //调用快速分享接口
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:@"55fcee3ce0f55a4ccb006a88"
                                      shareText:shareText
                                     shareImage:shareImage
                                shareToSnsNames:nil
                                       delegate:nil];

  
    //
}



//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//    UIView *viewaa = [[UIView alloc] init];
//    viewaa.backgroundColor =[UIColor purpleColor];
//    UILabel *datelabel = [[UILabel alloc] initWithFrame:CGRectMake(0,5, self.view.frame.size.width, 20)];
//    [datelabel setText:@"我的收藏"];
//    [datelabel setFont:[UIFont systemFontOfSize:15.0]];
//    [datelabel setTextAlignment:NSTextAlignmentCenter];
//    [viewaa addSubview:datelabel];
//    
//    return viewaa;
//
//}

#pragma mark - Table view

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"TableViewCell";
    //自定义cell类
    CenterCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        //通过xib的名称加载自定义的cell
        cell = [[[NSBundle mainBundle] loadNibNamed:@"CenterCell" owner:self options:nil] lastObject];
    }
//     cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
//    [self configureCell:cell forIndexPath:indexPath];
    if (indexPath.row == 1) {
        cell.title.text = @"我收藏的展品";
    }else{
    cell.title.text = @"我收藏的场馆";
    }
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSString *museums = @"Love";
    
//    NSArray *array = [self getdatafromCoreData:museums];
    return 2;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//{
//    return 30.0;
//}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return  70;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0) {
        
        
        
        shoucangMuseumTableViewController  *shoucang = [[shoucangMuseumTableViewController alloc] init];
        [UIView transitionWithView:self.navigationController.view duration:0.5 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
            //      UIViewAnimationOptionTransitionCurlUp
            //        UIViewAnimationOptionTransitionCrossDissolve
            [self.navigationController pushViewController:shoucang animated:NO];
        } completion:^(BOOL finished) {
            
        }];
        

        
    }
    
}
//- (void)configureCell:(CenterCell *)cell forIndexPath:(NSIndexPath *)indexPath {
//    NSString *museums = @"Love";
//    
//    NSArray *cellArray = [self getdatafromCoreData:museums];
////    _museumArray = cellArray;
//    Love *museumcell = cellArray[indexPath.row];
//    NSString *imagelogo = museumcell.infoImage;
//    NSURL *imageurl = [NSURL URLWithString:imagelogo];
//    cell.title.text = museumcell.name;
//    cell.detail.text = museumcell.address;
//    [cell.image sd_setImageWithURL:imageurl];
//    //    [cell.love addTarget:self action:@selector(shoucang:indexPath:) forControlEvents:UIControlEventTouchUpInside];
//    //    NSLog(@"%@",imageurl);
//    //    cell.imageView.contentMode = UIViewContentModeScaleAspectFit;
//    //    [cell.imageView sd_setImageWithURL:imageurl];
//    //    .
//    //    cell.textLabel.text = museumcell.name;
//    //    cell.detailTextLabel.text = museumcell.adress;
//    
//}




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
