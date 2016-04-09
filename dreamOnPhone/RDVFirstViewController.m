// RDVSecondViewController.m
// RDVTabBarController
//
// Copyright (c) 2013 Robert Dimitrov
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import "RDVFirstViewController.h"
#import "RDVTabBarController.h"
#import "UIScrollView+PullToRefreshCoreText.h"
#import "AFNetworking.h"
#import <CoreData/CoreData.h>
#import "Museums.h"
#import "Plants.h"
#import "UIImageView+WebCache.h"
#import "RDVSecondViewController.h"
#import "DreamOfLifeViewController.h"
#import "AppDelegate.h"
#import "Products.h"
#import "Eweekly.h"
#import "DreamOfMuseumShow.h"
//#import "QRCodeReaderViewController.h"
#import "Diycell.h"
#import "Person+CoreDataProperties.h"
#import "saoMiaoResultViewController.h"
#import "Love+CoreDataProperties.h"
#import "Love.h"

#define MainURL            @"http://202.121.66.52:8010"
@interface RDVFirstViewController ()
{
    // CoreData数据操作的上下文，负责所有的数据操作，类似于SQLite的数据库连接句柄
    NSManagedObjectContext *_context;
    NSArray *_museumArray;
    saoMiaoResultViewController *_saoMiao;
    
}
@end


@implementation RDVFirstViewController
{
    NSMutableArray *_priceArray;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
//        self.title = @"梦之园";
    }
    return self;
}

#pragma mark - View lifecycle

-(void)viewDidAppear:(BOOL)animated
{
//    [self showIntroWithSeparatePagesInit];
//    NSLog(@"00000");
    NSUserDefaults *userdefaults = [NSUserDefaults standardUserDefaults];
    [userdefaults removeObjectForKey:@"number"];
    int number =0;
    [userdefaults setInteger:number forKey:@"number"];

}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    self.title = @"梦之园";
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _priceArray = [[NSMutableArray alloc] init];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [self.navigationController.navigationBar
     setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    self.navigationController.navigationBar.translucent = NO;
//    self.navigationController.navigationBar.backgroundColor = [UIColor  colorWithRed:67.0/255.0 green:148.0/255.0 blue:247.0/255.0 alpha:1.0];
//      self.navigationController.navigationBar.tintColor = [UIColor  colorWithRed:67.0/255.0 green:148.0/255.0 blue:247.0/255.0 alpha:1.0];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:67.0/255.0 green:148.0/255.0 blue:247.0/255.0 alpha:1.0];
    self.navigationController.navigationBar.translucent = NO;
//    //设置右barbutton
//    UIImage *image = [UIImage imageNamed:@"Share.png"];
//    UIButton *myCustomButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    myCustomButton.bounds = CGRectMake( 0, 0, image.size.width, image.size.height );
//    [myCustomButton setImage:image forState:UIControlStateNormal];
//    [myCustomButton addTarget:self action:@selector(photo) forControlEvents:UIControlEventTouchUpInside];
//
   
//    
//    UIBarButtonItem *rightbar = [[UIBarButtonItem alloc] initWithCustomView:myCustomButton];
//
//    self.navigationItem.rightBarButtonItem = rightbar;
    self.mydelegate =(AppDelegate *)[[UIApplication sharedApplication]delegate];
    
    
    
//    Person *person = (Person *)[NSEntityDescription insertNewObjectForEntityForName:@"Person" inManagedObjectContext:self.mydelegate.managedObjectContext];
//    NSString *signid = @"xukun";
//    NSString *title = @"shanghaihaiyangdaxue";
//    [person setValue:signid forKey:@"name"];
//    [person setValue:title forKey:@"address"];
//
//    NSString *par = @"Person";
//    NSFetchRequest* request=[[NSFetchRequest alloc] init];
//    NSEntityDescription* user=[NSEntityDescription entityForName:par inManagedObjectContext:self.mydelegate.managedObjectContext];
//    [request setEntity:user];
//    
//    NSError* error=nil;
//    NSMutableArray* mutableFetchResult=[[_mydelegate.managedObjectContext executeFetchRequest:request error:&error] mutableCopy];
//    NSLog(@"%@",mutableFetchResult);

    //获取梦之园的数据
    [self getMuseumsData];
    //获取梦生命的数据
    [self getPlantsData];
    //获取梦生活的数据
    [self getProductData];
    //获取E周刊的数据
    [self getEweakData];
    
    //coreData数据库的建立
    
    
    //add pull to refresh
    __weak typeof(self) weakSelf = self;
    [self.tableView addPullToRefreshWithPullText:@"下拉刷新" pullTextColor:[UIColor blackColor] pullTextFont:DefaultTextFont refreshingText:@"Refreshing..." refreshingTextColor:[UIColor blueColor] refreshingTextFont:DefaultTextFont action:^{
        [weakSelf loadItems];
        
    }];
    
    
//    [self getdatafromCoreData];

    
   
}





//
//-(void)photo{
//
//static QRCodeReaderViewController *reader = nil;
//static dispatch_once_t onceToken;
//
//dispatch_once(&onceToken, ^{
//    reader                        = [QRCodeReaderViewController new];
//    reader.modalPresentationStyle = UIModalPresentationFormSheet;
//});
//reader.delegate = self;
//[reader setCompletionWithBlock:^(NSString *resultAsString) {
//
//}];
//[self presentViewController:reader animated:YES completion:NULL];
//}
//
//
//
//#pragma mark - QRCodeReader Delegate Methods
//
//- (void)reader:(QRCodeReaderViewController *)reader didScanResult:(NSString *)result
//{
//   
//    [self dismissViewControllerAnimated:YES completion:^{
////        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"QRCodeReader" message:result delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
////        [alert show];
//        _saoMiao = [[saoMiaoResultViewController alloc] init];
//        _saoMiao.saoMiaoResult = result;
//        [self.navigationController pushViewController:_saoMiao animated:YES];
//        NSLog(@"%@",result);
//    }];
//}
//
//- (void)readerDidCancel:(QRCodeReaderViewController *)reader
//{
//    [self dismissViewControllerAnimated:YES completion:NULL];
//}
- (void)loadItems {
    __weak typeof(UITableView *) weakScrollView = self.tableView;
    
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 3 * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [weakScrollView reloadData];
        [weakScrollView finishLoading];
    });
}

/**
 *  获取梦之园的数据
 */
-(void)getMuseumsData
{
    
    [_priceArray removeAllObjects];
    NSString *museums = @"museums";
    NSString *stringURL = [NSString stringWithFormat:@"%@/%@",MainURL,museums];
    
    NSURL *url = [NSURL URLWithString:[stringURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
//    NSLog(@"%@",url);
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *html = operation.responseString;
        NSData* data=[html dataUsingEncoding:NSUTF8StringEncoding];
        NSArray *result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        //        NSLog(@"%@",result);
        //对数据进行解析
        for(NSDictionary *dic in result){
            [self analysisData:dic];
        }
        NSLog(@"成功");
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"%@失败",error);
    }];
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [queue addOperation:operation];
    
}
/**
 *  获取梦生命的数据
 */
-(void)getPlantsData
{
    NSString *museums = @"plants";
    NSString *stringURL = [NSString stringWithFormat:@"%@/%@",MainURL,museums];
    
    NSURL *url = [NSURL URLWithString:[stringURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *html = operation.responseString;
        NSData* data=[html dataUsingEncoding:NSUTF8StringEncoding];
        NSArray *result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        //        NSLog(@"%@",result);
        //对数据进行解析
        for(NSDictionary *dic in result){
            [self analysisPlantsData:dic];
        }
        NSLog(@"成功");
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"%@失败",error);
    }];
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [queue addOperation:operation];

}


/**
 *  获取梦生命的数据
 */
-(void)getProductData
{
    NSString *items = @"products";
    NSString *stringURL = [NSString stringWithFormat:@"%@/%@",MainURL,items];
    NSLog(@"%@",stringURL);
    NSURL *url = [NSURL URLWithString:[stringURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *html = operation.responseString;
        NSData* data=[html dataUsingEncoding:NSUTF8StringEncoding];
        NSArray *result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        //        NSLog(@"%@",result);
        //对数据进行解析
        for(NSDictionary *dic in result){
            [self analysisProductsData:dic];
        }
        NSLog(@"成功");
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"%@失败",error);
    }];
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [queue addOperation:operation];

    
}

/**
 *  获取E周刊的数据
 */
-(void)getEweakData
{
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
        NSLog(@"成功");
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"%@失败",error);
    }];
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [queue addOperation:operation];

}
/**
 *  解析梦生命获取的数据
 *
 *  @param object
 */
-(void)analysisPlantsData:(NSDictionary *)object
{
    NSInteger intid = 0;
//    NSLog(@"%@",object);
    NSString *title = [object objectForKey:@"name"];
    NSNumber *iD = [object objectForKey:@"id"];
    NSString *signid = [[NSString alloc]initWithFormat:@"%@",iD];
//    NSLog(@"植物ID是多少==%@",signid);
    NSString *address = [object objectForKey:@"country_of_origin"];
    NSDictionary *image = [object objectForKey:@"image"];
    NSString *imageaddress1 = [image objectForKey:@"url"];
    NSString *imageurl = [NSString stringWithFormat:@"%@%@",MainURL,imageaddress1];
    NSDictionary *image1 = [image objectForKey:@"logo"];
    NSString *imagelogo1 = [image1 objectForKey:@"url"];
    NSString *imagelogo = [NSString stringWithFormat:@"%@%@",MainURL,imagelogo1];
    
    NSString *plants = @"Plants";
    NSArray *signarray = [self getdatafromCoreData:plants];
//    NSLog(@"梦生命中的数据为%@",signarray);
    for ( Plants *plant in signarray) {
        NSLog(@"%@ = =%@",plant.singleId,signid);
        if ([plant.singleId isEqualToString:signid]) {
            intid =1;
            NSLog(@"有重复数据");
        }
    }
//    NSLog(@"%ld",(long)intid);
    if (intid == 0) {
//        NSLog(@"此处添加数据");
        Plants *plant = (Plants *)[NSEntityDescription insertNewObjectForEntityForName:@"Plants" inManagedObjectContext:self.mydelegate.managedObjectContext];
        [plant setValue:signid forKey:@"singleId"];
        [plant setValue:title forKey:@"name"];
        [plant setValue:address forKey:@"address"];
        [plant setValue:imageurl forKey:@"imageurl"];
        [plant setValue:imagelogo forKey:@"imagelogo"];
        NSError* error;
        BOOL isSaveSuccess=[self.mydelegate.managedObjectContext save:&error];
        if (!isSaveSuccess) {
            NSLog(@"Error:%@",error);
        }else{
            NSLog(@"Save successful!");
        }
        
    }
}
/**
 *  解析梦之园获取的数据
 *
 *  @param object
 */
-(void)analysisData:(NSDictionary *)object
{
    NSInteger intId = 0;
//    NSLog(@"%@",object);
    NSString *title = [object objectForKey:@"name"];
    NSNumber *iD = [object objectForKey:@"id"];
    NSString *signid = [[NSString alloc]initWithFormat:@"%@",iD];
    NSLog(@"%@",signid);
    NSString *address = [object objectForKey:@"address"];
//    NSLog(@"地址是多少%@",address);
    NSDictionary *image = [object objectForKey:@"image"];
    NSString *imageaddress1 = [image objectForKey:@"url"];
    NSString *imageUrl = [NSString stringWithFormat:@"%@%@",MainURL,imageaddress1];
    NSDictionary *image1 = [image objectForKey:@"logo"];
    NSString *imagelogo1 = [image1 objectForKey:@"url"];
    NSString *imagelogo = [NSString stringWithFormat:@"%@%@",MainURL,imagelogo1];
    NSDictionary *cover = [object objectForKey:@"coverimage"];
    NSString *coverimage1 = [cover objectForKey:@"url"];
    NSString *coverimage = [NSString stringWithFormat:@"%@%@",MainURL,coverimage1];
    NSString *info = [object objectForKey:@"info"];
    NSDictionary *infoimage1 = [object objectForKey:@"info_image"];
    NSString *info_image1 = [infoimage1 objectForKey:@"url"];
    NSString *infoimage = [NSString stringWithFormat:@"%@%@",MainURL,info_image1];
    NSString *feature = [object objectForKey:@"feature"];
    NSNumber *price1= [object objectForKey:@"price"];
    NSNumberFormatter* numberFormatter = [[NSNumberFormatter alloc] init];
    NSString *price = [numberFormatter stringFromNumber:price1];
    
    //新增接口数据
    NSString *tel = [object objectForKey:@"tel"];
    NSString *opentime =[object objectForKey:@"open_time"];
    NSLog(@"%@",opentime);
//    NSString *tel = @"021-888888";
//    NSString *opentime = @"09:30-16:30";
    
    if (price == nil || price == NULL) {
        price = @"免费";
    }if ([price isKindOfClass:[NSNull class]]) {
        price = @"免费";
    }
//    [_priceArray addObject:price];
    NSLog(@"%@",price);
    NSString *museums = @"Museums";
    NSArray *signarray = [self getdatafromCoreData:museums];
    for (Museums *museum in signarray) {
        if ([museum.signid isEqualToString:signid]) {
            intId =1;
//            NSLog(@"有重复数据");
        }
    }
    NSLog(@"%ld",(long)intId);
    if (intId == 0) {
//        NSLog(@"此处添加数据");
        Museums *museum = (Museums *)[NSEntityDescription insertNewObjectForEntityForName:@"Museums" inManagedObjectContext:self.mydelegate.managedObjectContext];

        
        [museum setValue:signid forKey:@"signid"];
        [museum setValue:title forKey:@"name"];
        [museum setValue:address forKey:@"adress"];
        [museum setValue:imageUrl forKey:@"imageUrl"];
        [museum setValue:imagelogo forKey:@"imageLogo"];
        [museum setValue:coverimage forKey:@"coverImage"];
        [museum setValue:infoimage forKey:@"info_Image"];
        [museum setValue:info forKey:@"info"];
        [museum setValue:feature forKey:@"feature"];
        //新增数据存储到coredata中
        if (tel == nil || tel == NULL) {
            tel = @"---";
        }if (opentime == nil||opentime == NULL) {
            opentime= @"---";
        }
        if ([tel isKindOfClass:[NSNull class]]) {
            tel = @"---";
        } if ([opentime isKindOfClass:[NSNull class]]) {
            opentime = @"---";
        }
        [museum setValue:tel forKey:@"tel"];
        [museum setValue:opentime forKey:@"opentime"];
        [museum setValue:price forKey:@"price"];
        
        
//        if (price1 == nil || price1 == NULL) {
//            price = 0;
//        }if ([price1 isKindOfClass:[NSNull class]]) {
//             price = 0;
//        }
////        if ([[price stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
////             price = @"免费";
////        }
//        [museum setValue:price forKey:@"price"];
        
 
        NSError* error;
        BOOL isSaveSuccess=[self.mydelegate.managedObjectContext save:&error];
        if (!isSaveSuccess) {
            NSLog(@"Error:%@",error);
        }else{
            NSLog(@"Save successful!");
        }
    }
    [self.tableView reloadData];
}


/**
 *  解析梦生活获取的数据
 *
 *  @param object
 */
-(void)analysisProductsData:(NSDictionary *)object
{
    
    NSInteger intId = 0;
    //    NSLog(@"%@",object);
    NSString *name = [object objectForKey:@"name"];
    NSNumber *iD = [object objectForKey:@"id"];
    NSString *signid = [[NSString alloc]initWithFormat:@"%@",iD];
    NSLog(@"%@",signid);
    NSNumber *price1 = [object objectForKey:@"price"];
    NSString *price = [[NSString alloc] initWithFormat:@"%@",price1];
    NSString *url = [object objectForKey:@"url"];
    NSDictionary *image = [object objectForKey:@"image"];
    NSString *imageaddress1 = [image objectForKey:@"url"];
    NSString *imageurl = [NSString stringWithFormat:@"%@%@",MainURL,imageaddress1];
    NSDictionary *image1 = [image objectForKey:@"logo"];
    NSString *imagelogo1 = [image1 objectForKey:@"url"];
    NSString *imagelogo = [NSString stringWithFormat:@"%@%@",MainURL,imagelogo1];
    NSDictionary *salers = [object objectForKey:@"salers"];
    NSString *salersname = [salers objectForKey:@"name"];
    
    NSString *items = @"Products";
    NSArray *signarray = [self getdatafromCoreData:items];
    for (Products *items in signarray) {
        if ([items.signid isEqualToString:signid]) {
            intId =1;
            NSLog(@"%@",items);
            //            NSLog(@"有重复数据");
        }
    }
    NSLog(@"%ld",(long)intId);
    if (intId == 0) {
        //        NSLog(@"此处添加数据");
        Products *items = (Products *)[NSEntityDescription insertNewObjectForEntityForName:@"Products" inManagedObjectContext:self.mydelegate.managedObjectContext];
        
        
        [items setValue:signid forKey:@"signid"];
        [items setValue:name forKey:@"name"];
        [items setValue:price forKey:@"price"];
        [items setValue:imageurl forKey:@"imageurl"];
        [items setValue:imagelogo forKey:@"imagelogo"];
        [items setValue:url forKey:@"url"];
        [items setValue:salersname forKey:@"salersname"];
        
        
        NSError* error;
        BOOL isSaveSuccess=[self.mydelegate.managedObjectContext save:&error];
        if (!isSaveSuccess) {
            NSLog(@"Error:%@",error);
        }else{
            NSLog(@"Save successful!");
        }
    }

    
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
    NSString *coverurl = [cover objectForKey:@"url"];
    NSDictionary *logo = [cover objectForKey:@"logo"];
    NSString *coverlogo = [logo objectForKey:@"url"];
    
    
    NSString *url = [object objectForKey:@"url"];
    
//    NSString *introduction = [object objectForKey:@"introduction"];
//    NSString *date = [object objectForKey:@"publish_date"];
    NSNumber *number1 = [object objectForKey:@"no"];
    NSString *number = [[NSString alloc] initWithFormat:@"%@",number1];
    

    
    NSString *items = @"Eweekly";
    NSArray *signarray = [self getdatafromCoreData:items];
    for (Products *items in signarray) {
        if ([items.signid isEqualToString:signid]) {
            intId =1;
            NSLog(@"%@",items);
            //            NSLog(@"有重复数据");
        }
    }
    NSLog(@"%ld",(long)intId);
    if (intId == 0) {
        //        NSLog(@"此处添加数据");
        Eweekly *items = (Eweekly *)[NSEntityDescription insertNewObjectForEntityForName:@"Eweekly" inManagedObjectContext:self.mydelegate.managedObjectContext];
        
        
        [items setValue:signid forKey:@"signid"];
        [items setValue:name forKey:@"name"];
//        [items setValue:cover forKey:@"cover"];
        [items setValue:coverurl forKey:@"coverurl"];
        [items setValue:coverlogo forKey:@"coverlogo"];
        [items setValue:url forKey:@"url"];
        [items setValue:number forKey:@"number"];
        
        
        
        NSError* error;
        BOOL isSaveSuccess=[self.mydelegate.managedObjectContext save:&error];
        if (!isSaveSuccess) {
            NSLog(@"Error:%@",error);
        }else{
            NSLog(@"Save successful!");
        }
    }
    
    
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

#pragma mark - Methods

- (void)configureCell:(Diycell *)cell forIndexPath:(NSIndexPath *)indexPath {
    NSString *museums = @"Museums";

    NSArray *cellArray = [self getdatafromCoreData:museums];
    _museumArray = cellArray;
    Museums *museumcell = cellArray[indexPath.row];

//    NSLog(@"每一行的数据是神马%@",museumcell.adress);
    NSString *featur = @"";
    NSLog(@"%@",museumcell.feature);
    if (![museumcell.feature isEqualToString:featur]) {
        cell.saomiao.hidden = NO;
        NSString *feature = museumcell.feature;
        [cell.saomiao  setTitle:feature forState:UIControlStateNormal];
    }
//    
//    NSString *price = [NSString stringWithFormat:@"%@:%@",@"票价",_priceArray[indexPath.row]];
//    cell.price.text = price;
    NSString *imagelogo = museumcell.coverImage;
    NSURL *imageurl = [NSURL URLWithString:imagelogo];
    cell.title.text = museumcell.name;
    cell.detail.text = museumcell.adress;
    
     NSString *price = [NSString stringWithFormat:@"%@:%@",@"票价",museumcell.price];
     cell.price.text = price;
   
    cell.image.contentMode = UIViewContentModeScaleToFill;
    cell.image.image = [UIImage imageNamed:@"centerback.jpeg"];
    [cell.image sd_setImageWithURL:imageurl placeholderImage:[UIImage imageNamed:@"loading.jpg"]];
//    [cell.love addTarget:self action:@selector(shoucang:indexPath:) forControlEvents:UIControlEventTouchUpInside];
//    NSLog(@"%@",imageurl);
//    cell.imageView.contentMode = UIViewContentModeScaleAspectFit;
//    [cell.imageView sd_setImageWithURL:imageurl];
//    .
//    cell.textLabel.text = museumcell.name;
//    cell.detailTextLabel.text = museumcell.adress;

}
-(void)shoucang:(NSIndexPath *)indexPath
{
    
    Museums *museum = _museumArray[indexPath.row];
    NSString *singleId = museum.signid;
    NSString *coverImage = museum.coverImage;
    NSString *name = museum.name;
    NSString *info = museum.info;
    NSString *infoImage = museum.info_Image;
    NSString *tel = museum.tel;
    NSString *opentime = museum.opentime;
    NSInteger intId = 0;
    NSString *museums = @"Love";
    
    NSArray *signarray = [self getdatafromCoreData:museums];
    for (Love *museum in signarray) {
        if ([museum.ider isEqualToString:singleId]) {
            intId =1;
            //            NSLog(@"有重复数据");
        }
    }
    NSLog(@"%ld",(long)intId);
    if (intId == 0) {
        //        NSLog(@"此处添加数据");
        Love *love = (Love *)[NSEntityDescription insertNewObjectForEntityForName:@"Love" inManagedObjectContext:self.mydelegate.managedObjectContext];
        
        
        [love setValue:singleId forKey:@"ider"];
        [love setValue:name forKey:@"name"];
        [love setValue:coverImage forKey:@"coverImage"];
        [love setValue:infoImage forKey:@"infoImage"];
        [love setValue:info forKey:@"info"];
        NSString *price = _priceArray[indexPath.row];
        [love setValue:price forKey:@"price"];
        
        
        NSError* error;
        BOOL isSaveSuccess=[self.mydelegate.managedObjectContext save:&error];
        if (!isSaveSuccess) {
            NSLog(@"Error:%@",error);
        }else{
            NSLog(@"Save successful!");
        }
    }
    
}

#pragma mark - Table view

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    static NSString *CellIdentifier = @"Cell";
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//    if (!cell) {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
//    }
    static NSString *CellIdentifier = @"TableViewCell";
    //自定义cell类
    Diycell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        //通过xib的名称加载自定义的cell
        cell = [[[NSBundle mainBundle] loadNibNamed:@"Diycell" owner:self options:nil] lastObject];
    }
//    cell.title.text = @"nihao";
//    cell.detail.text = @"nihao";
    
    [self configureCell:cell forIndexPath:indexPath];
//    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSString *museums = @"Museums";

    NSArray *array = [self getdatafromCoreData:museums];
    return array.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return  260;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
 
    [[self rdv_tabBarController] setTabBarHidden:!self.rdv_tabBarController.tabBarHidden animated:YES];
//    self.navigationController.tabBarController.tabBar.hidden = YES;
    NSLog(@"%lu",(unsigned long)_museumArray.count);
    Museums *museum = _museumArray[indexPath.row];
    NSString *singleId = museum.signid;
    NSString *coverImage = museum.coverImage;
    NSString *name = museum.name;
    NSString *info = museum.info;
    NSString *infoImage = museum.info_Image;
    NSString *price = museum.price;
    NSString *address = museum.adress;
    NSString *tel = museum.tel;
    NSString *opentime = museum.opentime;
   

    NSLog(@"%@",price);
    DreamOfMuseumShow *dreamOfMuseums = [[DreamOfMuseumShow alloc] initWithNibName:nil bundle:nil];
    self.delegate = dreamOfMuseums;
    [self.delegate passsigleIdToShowView:singleId withname:name andcoverimage:coverImage andInfo:info andInfoImage:infoImage andPrice:price andTel:tel andopenTime:opentime andAddress:address];
    [UIView transitionWithView:self.navigationController.view duration:0.5 options:UIViewAnimationOptionTransitionCurlUp animations:^{
        //      UIViewAnimationOptionTransitionCurlUp
        //        UIViewAnimationOptionTransitionCrossDissolve
    [self.navigationController pushViewController:dreamOfMuseums animated:NO];
    } completion:^(BOOL finished) {
        
    }];
    
    
    
}




//字和图距离要离近些，定位提供当前距离，字太小
//图更换
//添加收藏
//地址  开馆时间 电话

//展品导览字体太小

@end

// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com
