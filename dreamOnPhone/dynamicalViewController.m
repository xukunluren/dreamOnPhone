



//
//  dynamicalViewController.m
//  dreamOnPhone
//
//  Created by admin on 16/1/11.
//  Copyright © 2016年 xukun. All rights reserved.
//

#import "dynamicalViewController.h"
#import "AFNetworking.h"
#import "dynamicCell.h"
#import "dynamicCell.h"
#import "UIImageView+WebCache.h"
#import "diyDetailViewController.h"
#import "UMSocial.h"

#define MainURL            @"http://202.121.66.52:8010"

@interface dynamicalViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation dynamicalViewController

{
    
    NSMutableArray *_nameArray;
    NSMutableArray *_coverImage;
    NSMutableArray *_urlImage;
    NSMutableArray *_descriptionArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _nameArray = [[NSMutableArray alloc] init];
     _coverImage = [[NSMutableArray alloc] init];
     _urlImage = [[NSMutableArray alloc] init];
     _descriptionArray = [[NSMutableArray alloc] init];
    // Do any additional setup after loading the view.
    NSLog(@"%@",_num);
    [self setTableView];
    [self getEweakData];
    self.navigationItem.title = @"场馆动态";
    
    
    UIImage *image = [UIImage imageNamed:@"share.png"];
    UIButton *myCustomButton = [UIButton buttonWithType:UIButtonTypeCustom];
    myCustomButton.bounds = CGRectMake( 0, 0, image.size.width, image.size.height );
    [myCustomButton setImage:image forState:UIControlStateNormal];
    [myCustomButton addTarget:self action:@selector(share) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIBarButtonItem *rightbar = [[UIBarButtonItem alloc] initWithCustomView:myCustomButton];
    
    self.navigationItem.rightBarButtonItem = rightbar;
    
}

-(void)share
{
    NSString *shareText = @"nihao";             //分享内嵌文字
    
    
    NSURL *url = [NSURL URLWithString: @"www.baidu.com"];
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

-(void)setTableView{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.dataSource =self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];

}

#pragma mark - Table view

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    static NSString *CellIdentifier = @"TableViewCell";
//    //自定义cell类
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//    if (cell == nil) {
//        //通过xib的名称加载自定义的cell
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
//                                       reuseIdentifier:CellIdentifier];
//    }

    static NSString *CellIdentifier = @"TableViewCell";
    //自定义cell类
    dynamicCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        //通过xib的名称加载自定义的cell
        cell = [[[NSBundle mainBundle] loadNibNamed:@"dynamicCell" owner:self options:nil] lastObject];
    }
    
    
//    cell.textLabel.text = _nameArray[indexPath.row];
////        cell.title.text = @"nihao";
////        cell.detail.text = @"nihao";
    cell.title.text = _nameArray[indexPath.row];
    cell.detailTitle.text = _descriptionArray[indexPath.row];
    NSString *image = _coverImage[indexPath.row];
    NSURL *url = [NSURL URLWithString:image];
//    cell.image.contentMode = UIViewContentModeScaleToFill;
    [cell.image sd_setImageWithURL:url];
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _nameArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return  250;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    //若链接数据可用，则使用此句代码
    //    NSString *urlstring = _urlImage[indexPath.row];
    // 侧位测试代码
    
  
    
    UIWebView *_webView = [[UIWebView alloc] initWithFrame:CGRectMake(0,0,self.view.bounds.size.width,self.view.bounds.size.height)];
    NSString *path= @"http://www.baidu.com/";
    
    NSURL *url = [NSURL URLWithString:path];
    
    // 2. 把URL告诉给服务器,请求,从m.baidu.com请求数据
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    // 3. 发送请求给服务器
    [_webView loadRequest:request];
    diyDetailViewController *diy = [[diyDetailViewController alloc] init];
    [diy.view addSubview:_webView];
    [self.navigationController pushViewController:diy animated:YES];
    
}

-(void)getEweakData
{
    
    
    [_nameArray removeAllObjects];
    [_descriptionArray removeAllObjects];
    [_coverImage removeAllObjects];
    [_urlImage removeAllObjects];
    NSString *items = @"event/museum";
    NSString *stringURL = [NSString stringWithFormat:@"%@/%@/%@",MainURL,items,_num];
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
        [_tableView reloadData];
        NSLog(@"成功");
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"%@失败",error);
    }];
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [queue addOperation:operation];

}


-(void)analysisEweeklyData:(NSDictionary *)object
{
    
    //    NSInteger intId = 0;
    //    NSLog(@"%@",object);
    NSString *name = [object objectForKey:@"name"];
    NSString *cover = [object objectForKey:@"cover"];
    NSString *url = [object objectForKey:@"url"];
    NSString *description =[object objectForKey:@"description"];
    
    
    [_nameArray addObject:name];
    [_coverImage addObject:cover];
    [_urlImage addObject:url];
    [_descriptionArray addObject:description];
    
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
