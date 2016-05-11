//
//  MuseumExihibit.m
//  dreamOnPhone
//
//  Created by admin on 15/9/4.
//  Copyright (c) 2015年 xukun. All rights reserved.
//

#import "MuseumExihibit.h"
#import "AFNetworking.h"
#import <CoreData/CoreData.h>
#import "DiyCellBase.h"
#import "DreamOfMuseumShow.h"
#import "Items.h"
#import "UIImageView+WebCache.h"
#import "MuseumsPictureShow.h"
#import "MuseumsPictureAndVideo.h"
#import "UMSocial.h"


#define MainURL            @"http://202.121.66.52:8010"

@interface MuseumExihibit ()<passIdToDetailShowDelegate>

@end

@implementation MuseumExihibit
{
    NSString *_museumname;
    NSString *_ider;
    NSString *_image1;
    NSString *_image2;
    NSString *_image3;
    NSString *_image4;
    NSString *_story;
    NSString *_baidu;
    NSArray *_itemsArray;
    NSArray *imageArray;
    NSArray *ImageVideoArray;
    
    NSMutableArray *_imageUrlArray;
    NSMutableArray *_titleArray;
    NSMutableArray *_descArray;
    NSMutableArray *_imageArray1;
    NSMutableArray *_imageArray2;
    NSMutableArray *_imageArray3;
    NSMutableArray *_imageArray4;
    NSMutableArray *_wikiUrl;
    NSMutableArray *_storyArray;
    NSMutableArray *_contentArray;
    NSMutableArray *_infoArray;
    NSMutableArray *_mp3Array;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _imageUrlArray = [[NSMutableArray alloc] init];
    _titleArray = [[NSMutableArray alloc] init];
    _descArray = [[NSMutableArray alloc] init];
    _imageArray1 = [[NSMutableArray alloc] init];
    _imageArray2 = [[NSMutableArray alloc] init];
    _imageArray3 = [[NSMutableArray alloc] init];
    _imageArray4 = [[NSMutableArray alloc] init];
    _wikiUrl = [[NSMutableArray alloc] init];
    _storyArray = [[NSMutableArray alloc] init];
    _contentArray = [[NSMutableArray alloc] init];
    _mp3Array = [[NSMutableArray alloc] init];
     _infoArray = [[NSMutableArray alloc] init];
     self.mydelegate =(AppDelegate *)[[UIApplication sharedApplication]delegate];
    
    [self getItemsData];
    
    [self.tableView reloadData];
    //设置右barbutton
    UIImage *image = [UIImage imageNamed:@"share.png"];
    UIButton *myCustomButton = [UIButton buttonWithType:UIButtonTypeCustom];
    myCustomButton.bounds = CGRectMake( 0, 0, image.size.width, image.size.height );
    [myCustomButton setImage:image forState:UIControlStateNormal];
    [myCustomButton addTarget:self action:@selector(share) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIBarButtonItem *rightbar = [[UIBarButtonItem alloc] initWithCustomView:myCustomButton];
    
//    self.navigationItem.rightBarButtonItem = rightbar;
    
}

-(void)share
{
    NSString *shareText = @"nihao";             //分享内嵌文字
    
    
//    NSURL *url = [NSURL URLWithString: _museumscoverImage];
//    //    UIImage *imagea = [UIImage imageWithData: [NSData dataWithContentsOfURL:url]];
//    UIImage *shareImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:url]];          //分享内嵌图片
    //
    //调用快速分享接口
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:@"55fcee3ce0f55a4ccb006a88"
                                      shareText:shareText
                                     shareImage:nil
                                shareToSnsNames:nil
                                       delegate:nil];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 *  获取梦之园的数据
 */

-(void)getItemsData
{
    
    
    [_imageUrlArray removeAllObjects];
    [_titleArray removeAllObjects];
    [_descArray removeAllObjects];
    [_imageArray1 removeAllObjects];
    [_imageArray2 removeAllObjects];
    [_imageArray3 removeAllObjects];
    [_imageArray4 removeAllObjects];
    [_wikiUrl removeAllObjects];
    [_storyArray removeAllObjects];
    [_contentArray removeAllObjects];
    [_mp3Array removeAllObjects];
    [_infoArray removeAllObjects];
//    NSString *museums = @"items";
    NSString *stringURL = [NSString stringWithFormat:@"%@/%@/%@/%@",MainURL,@"items",@"museum",_ider];
    
    NSURL *url = [NSURL URLWithString:[stringURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSLog(@"%@",url);
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
        [self.tableView reloadData];
        NSLog(@"%@",_titleArray);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"%@失败",error);
    }];
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [queue addOperation:operation];
    [self.tableView reloadData];
    
}


-(void)analysisData:(NSDictionary *)object
{
    NSInteger intId = 0;
    NSLog(@"%@",object);
    NSString *title = [object objectForKey:@"name"];
    NSNumber *iD = [object objectForKey:@"id"];
    NSString *signid = [[NSString alloc]initWithFormat:@"%@",iD];
    NSLog(@"%@",signid);
    NSString *description = [object objectForKey:@"description"];
    
    NSString *content = [object objectForKey:@"info"];
    NSDictionary *imageDic1 = [object objectForKey:@"image"];
    NSString *imageaddress1 = [imageDic1 objectForKey:@"url"];
    NSString *image1 = [NSString stringWithFormat:@"%@%@",MainURL,imageaddress1];
    
    NSDictionary *imageLogo = [imageDic1 objectForKey:@"logo"];
    NSString *imagelogo1 = [imageLogo objectForKey:@"url"];
    NSString *logo = [NSString stringWithFormat:@"%@%@",MainURL,imagelogo1];
    
    NSDictionary *imageDic2 = [object objectForKey:@"image2"];
    NSString *imageaddress2 = [imageDic2 objectForKey:@"url"];
    NSString *image2 = [NSString stringWithFormat:@"%@%@",MainURL,imageaddress2];
    
    NSDictionary *imageDic3 = [object objectForKey:@"image3"];
    NSString *imageaddress3 = [imageDic3 objectForKey:@"url"];
    NSString *image3 = [NSString stringWithFormat:@"%@%@",MainURL,imageaddress3];
    
    NSDictionary *imageDic4 = [object objectForKey:@"image4"];
    NSString *imageaddress4 = [imageDic4 objectForKey:@"url"];
    NSString *image4 = [NSString stringWithFormat:@"%@%@",MainURL,imageaddress4];
    
    NSDictionary *voice = [object objectForKey:@"voice"];
    NSString *voiceUrl = [voice objectForKey:@"url"];
    NSString *mp3Url = [NSString stringWithFormat:@"%@%@",MainURL,voiceUrl];
    
    
    NSString *contentString = [object objectForKey:@"content"];
    if ([mp3Url isEqual:[NSNull null]]) {
        mp3Url = @"http://202.121.66.52:8010/uploads/item/voice/3/___7-____.mp3";
    }
  
    NSString *story = [object objectForKey:@"story"];
    
    NSLog(@"%@",story);
    if ([story isEqual:[NSNull null]]) {
        story = @"nihao";
    }
    NSString *wikiurl = [object objectForKey:@"wikiurl"];
    if ([wikiurl isEqual:[NSNull null]]) {
        wikiurl = @"nihao";
    }
 
    NSNumber *museumid1 = [object objectForKey:@"museum_id"];
    NSString *museumId = [[NSString alloc]initWithFormat:@"%@",museumid1];
    
    
    
    [_imageUrlArray addObject:logo];
    [_titleArray addObject:title];
    [_descArray addObject:description];
    [_imageArray1 addObject:image1];
    [_imageArray2 addObject:image2];
    [_imageArray3 addObject:image3];
    [_imageArray4 addObject:image4];
    [_wikiUrl addObject:wikiurl];
    [_storyArray addObject:story];
    [_infoArray addObject:content];
    [_mp3Array addObject:mp3Url];
    [_contentArray addObject:contentString];
    
    NSString *items = @"Items";
    NSArray *signarray = [self getdatafromCoreData:items];
    for (Items *item in signarray) {
        if ([item.signId isEqualToString:signid]) {
            intId =1;
            //            NSLog(@"有重复数据");
        }
    }
//    NSLog(@"%ld",(long)intId);
    if (intId == 0) {
        //        NSLog(@"此处添加数据");
        Items *item = (Items *)[NSEntityDescription insertNewObjectForEntityForName:@"Items" inManagedObjectContext:self.mydelegate.managedObjectContext];
        
        
        [item setValue:signid forKey:@"signId"];
        [item setValue:title forKey:@"name"];
        [item setValue:description forKey:@"desc"];
        [item setValue:logo forKey:@"logo"];
        [item setValue:image1 forKey:@"image1"];
        [item setValue:image2 forKey:@"image2"];
        [item setValue:image3 forKey:@"image3"];
        [item setValue:image4 forKey:@"image4"];
        [item setValue:story forKey:@"story"];
        [item setValue:wikiurl forKey:@"wikiurl"];
        [item setValue:museumId forKey:@"museumId"];
        
        
      
        
        
        
        
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

-(void)passIdToDetailShow:(NSString *)name ider:(NSString *)ider andInfo:(NSString *)info andInfoimage:(NSString *)infoimage
{
    
    _museumname = name;
    _ider = ider;
    NSLog(@"%@===%@",_museumname,ider);
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

//    NSArray *array = [self getdatafromCoreData:@"Items"];
    NSLog(@"%lu",(unsigned long)_imageUrlArray.count);
    return _imageUrlArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"TableViewCell";
    //自定义cell类
    DiyCellBase *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        //通过xib的名称加载自定义的cell
        cell = [[[NSBundle mainBundle] loadNibNamed:@"DiyCellBase" owner:self options:nil] lastObject];
    }

    [self configureCell:cell forIndexPath:indexPath];
//     cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return  80;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"TableViewCell";
    DiyCellBase *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];

    NSString *titl = cell.title.text;
    NSLog(@"====%@",titl);
//    Items *item = _itemsArray[indexPath.row];
    _image1 = _imageArray1[indexPath.row];
    _image2 = _imageArray2[indexPath.row];
    _image3 = _imageArray3[indexPath.row];
    _image4 = _imageArray4[indexPath.row];
    NSString *title = _titleArray[indexPath.row];
    NSString *mp3 = _mp3Array[indexPath.row];
    
    NSLog(@"%@----",title);
    NSString *iii = @"4";
    
    NSLog(@"%@",_image2);
    if ( [_image4 isEqualToString:@"http://202.121.66.52:8010<null>"]) {
       iii = @"3";
    }
    if ( [_image3 isEqualToString:@"http://202.121.66.52:8010<null>"]) {
        iii = @"2";
    }
    if ([_image2 isEqualToString:@"http://202.121.66.52:8010<null>"]) {
       iii= @"1";
    }
//    NSString *biaozhi = @"http://202.121.66.52:8010<null>";
//    if ([_image4 isEqualToString:biaozhi]) {
//    NSArray *imageArray = @[_image1,_image2,_image3];
//    }else if ([_image3 isEqualToString:biaozhi])
//    {
//     NSArray *imageArray = @[_image1,_image2];
//    }else if ([_image2 isEqualToString:biaozhi])
//    {
//    NSArray *imageArray = @[_image1];
//    }
        if ([iii isEqualToString:@"4"]) {
        imageArray = @[_image1,_image2,_image3,_image4];
    }else if ([iii isEqualToString:@"3"])
    {
        imageArray = @[_image1,_image2,_image3];
    }else if ([iii isEqualToString:@"2"])
    {
         imageArray = @[_image1,_image2];
    }else if ([iii isEqualToString:@"1"])
    {
         imageArray = @[_image1];
    }
    
    ImageVideoArray = @[_image1];
    _story = _storyArray[indexPath.row];
    NSString *info = _infoArray[indexPath.row];
    NSString *content = _contentArray[indexPath.row];
    _baidu = _wikiUrl[indexPath.row];
//    NSLog(@"%@==%@==%@==%@==%@",_image1,_image2,_image3,_image4,_story);
    if ([_ider isEqualToString:@"1"]) {
        MuseumsPictureShow *pictureShow = [[MuseumsPictureShow alloc] initWithNibName:nil bundle:nil];
        self.delegate = pictureShow;
        [self.delegate passimage:imageArray withTitle:title story:_story baidu:_baidu];
        [UIView transitionWithView:self.navigationController.view duration:0.5 options:UIViewAnimationOptionTransitionCurlUp animations:^{
            //      UIViewAnimationOptionTransitionCurlUp
            //        UIViewAnimationOptionTransitionCrossDissolve
            [self.navigationController pushViewController:pictureShow animated:NO];
            
        } completion:^(BOOL finished) {
            
        }];

    }else{
        MuseumsPictureAndVideo *pictureVideo = [[MuseumsPictureAndVideo alloc] initWithNibName:nil bundle:nil];
        self.delegate = pictureVideo;
        [self.delegate passimage:ImageVideoArray withTitle:title story:info baidu:_baidu mp3:mp3 content:content];
        [UIView transitionWithView:self.navigationController.view duration:0.5 options:UIViewAnimationOptionTransitionCurlUp animations:^{
            //      UIViewAnimationOptionTransitionCurlUp
            //        UIViewAnimationOptionTransitionCrossDissolve
            [self.navigationController pushViewController:pictureVideo animated:NO];
            
        } completion:^(BOOL finished) {
            
        }];

    }
   

}

- (void)configureCell:(DiyCellBase *)cell forIndexPath:(NSIndexPath *)indexPath {
//    NSString *items = @"Items";
//    NSArray *cellArray = [self getdatafromCoreData:items];
////    NSLog(@"%@",cellArray);
//    _itemsArray = cellArray;
//    Items *itemsCell = cellArray[indexPath.row];
//    if ([itemsCell.museumId isEqualToString:@"1"]) {
//        cell.title.text = itemsCell.name;
//        cell.detail.text = itemsCell.desc;
//        NSString *imagelogo = itemsCell.logo;
//        NSURL *url = [NSURL URLWithString:imagelogo];
//        [cell.image sd_setImageWithURL:url];
//    }

    cell.title.text = _titleArray[indexPath.row];
    
    NSString *detail = _descArray[indexPath.row];
//    CGSize size = [detail sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(200,10000.0f)lineBreakMode:UILineBreakModeWordWrap];
    cell.detail.numberOfLines = 0;
    cell.detail.text = detail;
    NSString *imagelogo = _imageUrlArray[indexPath.row];
    NSURL *url = [NSURL URLWithString:imagelogo];
    [cell.image sd_setImageWithURL:url];
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
