//
//  shoucangMuseumTableViewController.m
//  dreamOnPhone
//
//  Created by admin on 16/1/11.
//  Copyright © 2016年 xukun. All rights reserved.
//

#import "shoucangMuseumTableViewController.h"
#import "Love+CoreDataProperties.h"
#import "Love.h"
#import "DiyCellBase.h"
#import "UIImageView+WebCache.h"
#import "RDVTabBarController.h"
#import "DreamOfMuseumShow.h"
@interface shoucangMuseumTableViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation shoucangMuseumTableViewController
{
    UITableView *_tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.mydelegate =(AppDelegate *)[[UIApplication sharedApplication]delegate];
    NSString *museums = @"Love";
    self.view.backgroundColor = [UIColor redColor];
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
    [self getdatafromCoreData:museums];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}



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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSString *museums = @"Love";
    NSArray *array = [self getdatafromCoreData:museums];
    NSLog(@"%lu",(unsigned long)array.count);
    return array.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return  80;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"TableViewCell";
    //自定义cell类
    DiyCellBase *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        //通过xib的名称加载自定义的cell
        cell = [[[NSBundle mainBundle] loadNibNamed:@"DiyCellBase" owner:self options:nil] lastObject];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    [self configureCell:cell forIndexPath:indexPath];
    return cell;
}

- (void)configureCell:(DiyCellBase *)cell forIndexPath:(NSIndexPath *)indexPath {
    NSString *museums = @"Love";
    
    NSArray *cellArray = [self getdatafromCoreData:museums];
    //    _museumArray = cellArray;
    Love *museumcell = cellArray[indexPath.row];
    NSString *imagelogo = museumcell.infoImage;
    NSURL *imageurl = [NSURL URLWithString:imagelogo];
    cell.title.text = museumcell.name;
    cell.detail.text = museumcell.address;
    [cell.image sd_setImageWithURL:imageurl];
    //    [cell.love addTarget:self action:@selector(shoucang:indexPath:) forControlEvents:UIControlEventTouchUpInside];
    //    NSLog(@"%@",imageurl);
    //    cell.imageView.contentMode = UIViewContentModeScaleAspectFit;
    //    [cell.imageView sd_setImageWithURL:imageurl];
    //    .
    //    cell.textLabel.text = museumcell.name;
    //    cell.detailTextLabel.text = museumcell.adress;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    //
    [[self rdv_tabBarController] setTabBarHidden:!self.rdv_tabBarController.tabBarHidden animated:YES];
    //    self.navigationController.tabBarController.tabBar.hidden = YES;
    NSArray *cellArray = [self getdatafromCoreData:@"Love"];
    Love *museum = cellArray[indexPath.row];
    NSString *singleId = museum.ider;
    NSString *coverImage = museum.coverImage;
    NSString *name = museum.name;
    NSString *info = museum.info;
    NSString *infoImage = museum.infoImage;
    NSString *price = museum.price;
    NSString *adress = museum.address;
    NSString *tel = museum.tel;
    NSString *opentime = museum.opentime;
    
    NSLog(@"%@",price);
    DreamOfMuseumShow *dreamOfMuseums = [[DreamOfMuseumShow alloc] initWithNibName:nil bundle:nil];
    self.delegate = dreamOfMuseums;
    [self.delegate passsigleIdToShowViewFromCenter:singleId withname:name andcoverimage:coverImage andInfo:info andInfoImage:infoImage andPrice:price andTel:tel andOpentime:opentime];
    
    
    [UIView transitionWithView:self.navigationController.view duration:0.5 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
        //      UIViewAnimationOptionTransitionCurlUp
        //        UIViewAnimationOptionTransitionCrossDissolve
        [self.navigationController pushViewController:dreamOfMuseums animated:NO];
    } completion:^(BOOL finished) {
        
    }];
    
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
