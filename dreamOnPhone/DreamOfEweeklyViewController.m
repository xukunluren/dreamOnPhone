//
//  DreamOfEweeklyViewController.m
//  dreamOnPhone
//
//  Created by admin on 16/1/5.
//  Copyright © 2016年 xukun. All rights reserved.
//

#import "DreamOfEweeklyViewController.h"
#import "BaseCollectionViewCell.h"
#import "AFNetworking.h"
#import "UIImageView+WebCache.h"
#define MainURL @"http://202.121.66.52:8010"
@interface DreamOfEweeklyViewController ()

@end

@implementation DreamOfEweeklyViewController
{
    NSMutableArray *_eweeklyImage;
    NSMutableArray *_eweeklyTitle;
    NSMutableArray *_eweeklyNum;
    NSMutableArray *_eweeklyDate;
}

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    [self getEweakData];
    
    // Do any additional setup after loading the view.
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

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
#warning Incomplete implementation, return the number of sections
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of items
    return _eweeklyTitle.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
//    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
// BaseCollectionViewCell *cell = (BaseCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"collectionCellID" forIndexPath:indexPath];
    //自定义cell类
    BaseCollectionViewCell *cell = (BaseCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    if (cell == nil) {
        //通过xib的名称加载自定义的cell
        cell = [[[NSBundle mainBundle] loadNibNamed:@"BaseCollectionViewCell" owner:self options:nil] lastObject];
    }//    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

    NSString *number = _eweeklyNum[indexPath.row];
    NSString *date= _eweeklyDate[indexPath.row];
    NSString *item1 = @"第";
    NSString *item2 = @"期";
    NSString *detail = [NSString stringWithFormat:@"%@%@%@  %@",item1,number,item2,date];
    cell.date.text = detail;
    NSString *image = _eweeklyImage[indexPath.row];
    NSURL *imageUrl = [NSURL URLWithString:image];
    [cell.image sd_setImageWithURL:imageUrl];
    
    return cell;
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
        
        [self.collectionView reloadData];
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
//    [_eweeklyDate addObject:date];
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


#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
