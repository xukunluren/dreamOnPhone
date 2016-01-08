

//
//  DreamViewController.m
//  dreamOnPhone
//
//  Created by admin on 16/1/6.
//  Copyright © 2016年 xukun. All rights reserved.
//

#import "DreamViewController.h"
#import "BaseCollectionViewCell.h"
#import "AFNetworking.h"
#import "UIImageView+WebCache.h"
#import "TOWebViewController.h"


#define MainURL @"http://202.121.66.52:8010"

@interface DreamViewController ()

@end

@implementation DreamViewController
{
    NSMutableArray *_eweeklyImage;
    NSMutableArray *_eweeklyTitle;
    NSMutableArray *_eweeklyNum;
    NSMutableArray *_eweeklyDate;
    NSMutableArray *_eweeklyUrl;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _eweeklyImage = [[NSMutableArray alloc] init];
    _eweeklyDate = [[NSMutableArray alloc] init];
    _eweeklyNum = [[NSMutableArray alloc] init];
    _eweeklyTitle = [[NSMutableArray alloc] init];
    _eweeklyUrl = [[NSMutableArray alloc] init];
  
    
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [self.navigationController.navigationBar
     setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:67.0/255.0 green:148.0/255.0 blue:247.0/255.0 alpha:1.0];
    self.navigationController.navigationBar.translucent = NO;
    
    self.title = @"E周刊";
//    [self setCollectionviewInView];
    [self getEweakData];
    NSLog(@"%lu",(unsigned long)_eweeklyNum.count);
    
    
}
-(void)setCollectionviewInView
{
    //确定是水平滚动，还是垂直滚动
    UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc] init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    
    self.collectionView=[[UICollectionView alloc] initWithFrame:CGRectMake(0, 5, self.view.frame.size.width,self.view.frame.size.height) collectionViewLayout:flowLayout];
    self.collectionView.dataSource=self;
    self.collectionView.delegate=self;
    [self.collectionView setBackgroundColor:[UIColor clearColor]];
    
    //注册Cell，必须要有
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"UICollectionViewCell"];
    
    [self.view addSubview:self.collectionView];
}




-(void)getEweakData
{
    
    [_eweeklyImage removeAllObjects];
    [_eweeklyNum removeAllObjects];
    [_eweeklyTitle removeAllObjects];
    [_eweeklyDate removeAllObjects];
    [_eweeklyUrl removeAllObjects];
    
    
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
        [self setCollectionviewInView];
        NSLog(@"成功");
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"%@失败",error);
    }];
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [queue addOperation:operation];
    
}
/**
 *  解析E周刊获取的数据
 *
 *  @param object
 */
-(void)analysisEweeklyData:(NSDictionary *)object
{
    
    NSInteger intId = 0;
    //    NSLog(@"%@",object);
    NSString *name = [object objectForKey:@"name"];
    NSNumber *iD = [object objectForKey:@"id"];
    NSString *signid = [[NSString alloc]initWithFormat:@"%@",iD];
    NSLog(@"%@",signid);
    NSString *cover = [object objectForKey:@"cover"];
    NSLog(@"%@",cover);
    NSString *url = [object objectForKey:@"url"];
    NSString *introduction = [object objectForKey:@"introduction"];
    NSString *date = [object objectForKey:@"publish_date"];
    NSNumber *number1 = [object objectForKey:@"no"];
    NSString *number = [[NSString alloc] initWithFormat:@"%@",number1];
    
    [_eweeklyImage addObject:cover];
    [_eweeklyTitle addObject:name];
    [_eweeklyNum addObject:number];
    [_eweeklyDate addObject:date];
    [_eweeklyUrl addObject:url];
    //    NSString *items = @"Eweekly";
    //    NSArray *signarray = [self getdatafromCoreData:items];
    //    for (Products *items in signarray) {
    //        if ([items.signid isEqualToString:signid]) {
    //            intId =1;
    //            NSLog(@"%@",items);
    //            //            NSLog(@"有重复数据");
    //        }
    //    }
    //    NSLog(@"%ld",(long)intId);
    //    if (intId == 0) {
    //        //        NSLog(@"此处添加数据");
    //        Eweekly *items = (Eweekly *)[NSEntityDescription insertNewObjectForEntityForName:@"Eweekly" inManagedObjectContext:self.mydelegate.managedObjectContext];
    //
    //
    //        [items setValue:signid forKey:@"signid"];
    //        [items setValue:name forKey:@"name"];
    //        [items setValue:cover forKey:@"cover"];
    //        [items setValue:introduction forKey:@"introduction"];
    //        [items setValue:date forKey:@"date"];
    //        [items setValue:url forKey:@"url"];
    //        [items setValue:number forKey:@"number"];
    //
    //
    //        NSError* error;
    //        BOOL isSaveSuccess=[self.mydelegate.managedObjectContext save:&error];
    //        if (!isSaveSuccess) {
    //            NSLog(@"Error:%@",error);
    //        }else{
    //            NSLog(@"Save successful!");
    //        }
    //    }
    
    
}


#pragma mark -- UICollectionViewDataSource

//定义展示的UICollectionViewCell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSLog(@"%lu",(unsigned long)_eweeklyNum.count);
    return _eweeklyNum.count;
}

//定义展示的Section的个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

//每个UICollectionView展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * CellIdentifier = @"UICollectionViewCell";
    
    UICollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    cell.backgroundColor = [UIColor colorWithRed:((10 * indexPath.row) / 255.0) green:((20 * indexPath.row)/255.0) blue:((30 * indexPath.row)/255.0) alpha:1.0f];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 5, self.view.frame.size.width*0.3, self.view.frame.size.height*0.22)];
    NSString *image = _eweeklyImage[indexPath.row];
    NSURL *imageUrl = [NSURL URLWithString:image];
    UIImage *imageofPage = [UIImage imageWithData:[NSData dataWithContentsOfURL:imageUrl]];
    imageView.image = imageofPage;
    imageView.layer.masksToBounds = YES;
    imageView.layer.cornerRadius = 5.0;
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    label.textColor = [UIColor redColor];
    label.text = [NSString stringWithFormat:@"%ld",(long)indexPath.row];
    
    for (id subView in cell.contentView.subviews) {
        [subView removeFromSuperview];
    }
    
    [cell.contentView addSubview:imageView];
//    [cell.contentView addSubview:label];
    return cell;
}

#pragma mark --UICollectionViewDelegateFlowLayout

//定义每个Item 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(self.view.frame.size.width*0.3,self.view.frame.size.height*0.22);
}

//定义每个UICollectionView 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(10, 5, 30, 5);
}
//top, left, bottom, right

#pragma mark --UICollectionViewDelegate

//UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
//    UICollectionViewCell * cell = (UICollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    //临时改变个颜色，看好，只是临时改变的。如果要永久改变，可以先改数据源，然后在cellForItemAtIndexPath中控制。（和UITableView差不多吧！O(∩_∩)O~）
    
    NSString *url = _eweeklyUrl[indexPath.row];
    //    NSURL *url = [NSURL URLWithString:text];
    TOWebViewController *webViewController = [[TOWebViewController alloc] initWithURL:[NSURL URLWithString:url]];
    [self presentViewController:[[UINavigationController alloc] initWithRootViewController:webViewController] animated:YES completion:nil];
//    cell.backgroundColor = [UIColor greenColor];
    NSLog(@"row=======%ld",(long)indexPath.row);
}

//返回这个UICollectionView是否可以被选择
-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
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
