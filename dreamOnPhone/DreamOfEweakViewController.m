//
//  DreamOfLifeViewController.m
//  dreamOnPhone
//
//  Created by admin on 15/8/16.
//  Copyright (c) 2015年 xukun. All rights reserved.
//

#import "DreamOfEweakViewController.h"
#import "UIScrollView+PullToRefreshCoreText.h"
#import "RDVFirstViewController.h"
#import "Eweekly.h"
#import "UIImageView+WebCache.h"
#import "DiyCellBase.h"
#import "AFNetworking.h"
#define MainURL @"http://202.121.66.52:8010"


@interface DreamOfEweakViewController ()

@end

@implementation DreamOfEweakViewController
{
    NSArray *_EweeklyArray;
    NSMutableArray *_eweeklyImage;
    NSMutableArray *_eweeklyTitle;
    NSMutableArray *_eweeklyNum;
    NSMutableArray *_eweeklyDate;
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"E周刊";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _eweeklyImage = [[NSMutableArray alloc] init];
    _eweeklyDate = [[NSMutableArray alloc] init];
    _eweeklyNum = [[NSMutableArray alloc] init];
    _eweeklyTitle = [[NSMutableArray alloc] init];
    
     self.title = @"E周刊";
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [self.navigationController.navigationBar
     setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    self.navigationController.navigationBar.translucent = NO;
    
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:67.0/255.0 green:148.0/255.0 blue:247.0/255.0 alpha:1.0];
    self.navigationController.navigationBar.translucent = NO;
    //右键相机设置
    UIImage *image = [UIImage imageNamed:@"scaning.png"];
    UIButton *myCustomButton = [UIButton buttonWithType:UIButtonTypeCustom];
    myCustomButton.bounds = CGRectMake( 0, 0, image.size.width, image.size.height );
    [myCustomButton setImage:image forState:UIControlStateNormal];
    //    [myCustomButton addTarget:nil action:@selector(goBack:) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIBarButtonItem *rightbar = [[UIBarButtonItem alloc] initWithCustomView:myCustomButton];

    self.navigationItem.rightBarButtonItem = rightbar;
    self.mydelegate =(AppDelegate *)[[UIApplication sharedApplication]delegate];
    [self getProductsData];
    __weak typeof(self) weakSelf = self;
    [self.tableView addPullToRefreshWithPullText:@"下拉刷新" pullTextColor:[UIColor blackColor] pullTextFont:DefaultTextFont refreshingText:@"Refreshing..." refreshingTextColor:[UIColor blueColor] refreshingTextFont:DefaultTextFont action:^{
        [weakSelf loadItems];
        
    }];
    
    [self getEweakData];
    
}
- (void)loadItems {
    __weak typeof(UITableView *) weakScrollView = self.tableView;
    
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 3 * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [weakScrollView reloadData];
        [weakScrollView finishLoading];
    });
}


-(NSArray *)getProductsData
{
    NSFetchRequest* request=[[NSFetchRequest alloc] init];
    NSEntityDescription* user=[NSEntityDescription entityForName:@"Eweekly" inManagedObjectContext:self.mydelegate.managedObjectContext];
    [request setEntity:user];
    
    NSError* error=nil;
    NSMutableArray* mutableFetchResult=[[_mydelegate.managedObjectContext executeFetchRequest:request error:&error] mutableCopy];
    if (mutableFetchResult==nil) {
        NSLog(@"Error:%@",error);
    }
    NSLog(@"The count of entry: %lu",(unsigned long)[mutableFetchResult count]);
    NSLog(@"%@",mutableFetchResult);
    return mutableFetchResult;
}

-(void)passValueArray:(NSArray *)array
{
    _EweeklyArray = [[NSMutableArray alloc] initWithArray:array];
    NSLog(@"%@",_EweeklyArray);
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    // Return the number of rows in the section.
//    NSArray *array = [self getProductsData];
    
//    return array.count;
    return  _eweeklyDate.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    static NSString *CellIdentifier = @"Cell";
//    
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//    if (cell == nil) {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
//    }

    static NSString *CellIdentifier = @"TableViewCell";
    //自定义cell类
    DiyCellBase *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        //通过xib的名称加载自定义的cell
        cell = [[[NSBundle mainBundle] loadNibNamed:@"DiyCellBase" owner:self options:nil] lastObject];
    }//    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

    
    [self configureCell:cell forIndexPath:indexPath];
//    cell.textLabel.text= @"xukun";
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return  60;
}

- (void)configureCell:(DiyCellBase *)cell forIndexPath:(NSIndexPath *)indexPath {
 
    
//    _EweeklyArray = [self getProductsData];
//    Eweekly *eweekly = _EweeklyArray[indexPath.row];
    cell.title.text = _eweeklyTitle[indexPath.row];
    NSString *number = _eweeklyNum[indexPath.row];
    NSString *date= _eweeklyDate[indexPath.row];
    NSString *item1 = @"第";
    NSString *item2 = @"期";
    NSString *detail = [NSString stringWithFormat:@"%@%@%@  %@",item1,number,item2,date];
    cell.detail.text = detail;
    NSString *image = _eweeklyImage[indexPath.row];
    NSURL *imageUrl = [NSURL URLWithString:image];
    [cell.image sd_setImageWithURL:imageUrl];
    NSLog(@"每行数据是hi什么%@",_EweeklyArray);
    

}


-(void)getEweakData
{
    
    [_eweeklyImage removeAllObjects];
    [_eweeklyNum removeAllObjects];
    [_eweeklyTitle removeAllObjects];
    [_eweeklyDate removeAllObjects];
    
    
    NSString *items = @"eweekly2";
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
        
         [self.tableView reloadData];
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
    NSDictionary *cover = [object objectForKey:@"cover"];
    NSString *coverurl1 = [cover objectForKey:@"url"];
    NSString *coverurl = [NSString stringWithFormat:@"%@%@",MainURL,coverurl1];
    NSDictionary *logo = [cover objectForKey:@"logo"];
    NSString *coverlogo1 = [logo objectForKey:@"url"];
    NSString *coverlogo = [NSString stringWithFormat:@"%@%@",MainURL,coverlogo1];
    
    NSString *url = [object objectForKey:@"url"];
//    NSString *introduction = [object objectForKey:@"introduction"];
//    NSString *date = [object objectForKey:@"publish_date"];
    NSNumber *number1 = [object objectForKey:@"no"];
    NSString *number = [[NSString alloc] initWithFormat:@"%@",number1];
    
    [_eweeklyImage addObject:coverlogo];
    [_eweeklyTitle addObject:name];
    [_eweeklyNum addObject:number];
//    [_eweeklyDate addObject:cove];
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

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
