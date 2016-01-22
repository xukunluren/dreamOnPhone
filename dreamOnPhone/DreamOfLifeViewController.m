//
//  DreamOfLifeViewController.m
//  dreamOnPhone
//
//  Created by admin on 15/8/16.
//  Copyright (c) 2015年 xukun. All rights reserved.
//

#import "DreamOfLifeViewController.h"
#import "UIScrollView+PullToRefreshCoreText.h"
#import "RDVFirstViewController.h"
#import "Plants.h"
#import "UIImageView+WebCache.h"
#import "DreamOfLifeShow.h"
#import "RDVTabBarController.h"
//#import "QRCodeReaderViewController.h"
//#import "Diycell.h"
#import "DiyCellBase.h"



@interface DreamOfLifeViewController ()

@end


@implementation DreamOfLifeViewController
{
    NSArray *_plantsArray;
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"梦生命";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.title = @"梦生命";
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
    [self getlifeData];
    __weak typeof(self) weakSelf = self;
    [self.tableView addPullToRefreshWithPullText:@"下拉刷新" pullTextColor:[UIColor blackColor] pullTextFont:DefaultTextFont refreshingText:@"Refreshing..." refreshingTextColor:[UIColor blueColor] refreshingTextFont:DefaultTextFont action:^{
        [weakSelf loadItems];
        
    }];
    
}
//
//-(void)photo{
//    
//    static QRCodeReaderViewController *reader = nil;
//    static dispatch_once_t onceToken;
//    
//    dispatch_once(&onceToken, ^{
//        reader                        = [QRCodeReaderViewController new];
//        reader.modalPresentationStyle = UIModalPresentationFormSheet;
//    });
//    reader.delegate = self;
//    [reader setCompletionWithBlock:^(NSString *resultAsString) {
//        NSLog(@"Completion with result: %@", resultAsString);
//    }];
//    [self presentViewController:reader animated:YES completion:NULL];
//}
//
//
//#pragma mark - QRCodeReader Delegate Methods
//
//- (void)reader:(QRCodeReaderViewController *)reader didScanResult:(NSString *)result
//{
//    [self dismissViewControllerAnimated:YES completion:^{
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"QRCodeReader" message:result delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
//        [alert show];
//    }];
//}
//
//- (void)readerDidCancel:(QRCodeReaderViewController *)reader
//{
//    [self dismissViewControllerAnimated:YES completion:NULL];
//}

//刷新
- (void)loadItems {
    __weak typeof(UITableView *) weakScrollView = self.tableView;
    
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 3 * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [weakScrollView reloadData];
        [weakScrollView finishLoading];
    });
}

-(NSArray *)getlifeData
{
    NSFetchRequest* request=[[NSFetchRequest alloc] init];
    NSEntityDescription* user=[NSEntityDescription entityForName:@"Plants" inManagedObjectContext:self.mydelegate.managedObjectContext];
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
    _plantsArray = [[NSMutableArray alloc] initWithArray:array];
    NSLog(@"%@",_plantsArray);
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
    NSArray *array = [self getlifeData];
    
    return array.count;
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
    }

    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

    
    [self configureCell:cell forIndexPath:indexPath];
//    cell.textLabel.text= @"xukun";
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return  80;
}

- (void)configureCell:(DiyCellBase *)cell forIndexPath:(NSIndexPath *)indexPath {
 
    
    _plantsArray = [self getlifeData];
    Plants *plant = _plantsArray[indexPath.row];
    cell.title.text = plant.name;
    NSString *address1 = plant.address;
    NSString *address2 = @"原产地";
    NSString *address = [NSString stringWithFormat:@"%@:%@",address2,address1];
    cell.detail.text = address;
    NSString *image = plant.imagelogo;
    NSURL *imageUrl = [NSURL URLWithString:image];
     [cell.image sd_setImageWithURL:imageUrl];
    NSLog(@"每行数据是hi什么%@",_plantsArray);
    

}





// Override to support conditional editing of the table view.
//- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
//    // Return NO if you do not want the specified item to be editable.
//    
//  
//    return YES;
//}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [[self rdv_tabBarController] setTabBarHidden:!self.rdv_tabBarController.tabBarHidden animated:YES];
      
    self.navigationItem.title = @"梦生命";
    Plants *plant = _plantsArray[indexPath.row];
    NSString *signid = plant.singleId;
    DreamOfLifeShow *lifeshow = [[DreamOfLifeShow alloc] initWithNibName:nil bundle:nil];

    self.delegate = lifeshow;
    [self.delegate passValueToShow:signid];
    [self.navigationController pushViewController:lifeshow animated:YES];

    
}

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
