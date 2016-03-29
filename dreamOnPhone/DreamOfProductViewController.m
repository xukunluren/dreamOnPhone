//
//  DreamOfLifeViewController.m
//  dreamOnPhone
//
//  Created by admin on 15/8/16.
//  Copyright (c) 2015年 xukun. All rights reserved.
//

#import "DreamOfProductViewController.h"
#import "UIScrollView+PullToRefreshCoreText.h"
#import "RDVFirstViewController.h"
#import "Products.h"
#import "UIImageView+WebCache.h"
#import "DiyCellBase.h"

#import "TOWebViewController.h"


@interface DreamOfProductViewController ()

@end

@implementation DreamOfProductViewController
{
    NSArray *_productsArray;
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"梦生活";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.title = @"梦生活";
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [self.navigationController.navigationBar
     setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    self.navigationController.navigationBar.translucent = NO;
    //右键相机设置
    
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:67.0/255.0 green:148.0/255.0 blue:247.0/255.0 alpha:1.0];
    self.navigationController.navigationBar.translucent = NO;
    
//    UIBarButtonItem *rightbar = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCamera target:self action:nil];
    
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
    NSEntityDescription* user=[NSEntityDescription entityForName:@"Products" inManagedObjectContext:self.mydelegate.managedObjectContext];
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
    _productsArray = [[NSMutableArray alloc] initWithArray:array];
    NSLog(@"%@",_productsArray);
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
    NSArray *array = [self getProductsData];
    
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
    //    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

    
    [self configureCell:cell forIndexPath:indexPath];
//    cell.textLabel.text= @"xukun";
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{
    DiyCellBase *cell = (DiyCellBase *)[tableView cellForRowAtIndexPath:indexPath];
    NSLog(@"%@",cell.urllabel.text);
    NSString *url = cell.urllabel.text;
//    NSURL *url = [NSURL URLWithString:text];
    TOWebViewController *webViewController = [[TOWebViewController alloc] initWithURL:[NSURL URLWithString:url]];
    [self presentViewController:[[UINavigationController alloc] initWithRootViewController:webViewController] animated:YES completion:nil];


}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return  80;
}

- (void)configureCell:(DiyCellBase *)cell forIndexPath:(NSIndexPath *)indexPath {
 
    
    _productsArray = [self getProductsData];
    Products *product = _productsArray[indexPath.row];
    cell.title.text = product.name;
    NSString *price2 = product.price;
    NSString *price1= @"¥ ：";
    NSString *price3 = @"元";
    NSString *price = [NSString stringWithFormat:@"%@%@ %@",price1,price2,price3];
    cell.detail.text = price;
    NSString *image = product.imagelogo;
    NSURL *imageUrl = [NSURL URLWithString:image];
     [cell.image sd_setImageWithURL:imageUrl];
    NSLog(@"每行数据是hi什么%@",_productsArray);
    cell.urllabel.text = product.url;
    

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
