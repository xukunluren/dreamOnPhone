
//
//  MuseumsPictureAndVideo.m
//  dreamOnPhone
//
//  Created by admin on 16/1/8.
//  Copyright © 2016年 xukun. All rights reserved.
//

#import "MuseumsPictureAndVideo.h"
#import "MuseumExihibit.h"
#import "UMSocial.h"
#import "AXPopoverView.h"
#import "AXPopoverLabel.h"
#import "Scan_VC.h"
#import "UIImageView+WebCache.h"
#import "common.h"


@interface MuseumsPictureAndVideo ()<passvalueDelegate,passvalueFromSaoMiaoDelegate>
@property(strong, nonatomic) AXPopoverView *popoverView;
@property(strong, nonatomic) AXPopoverLabel *popoverLabel;
@end

@implementation MuseumsPictureAndVideo
{
    UIImageView *_museumsImageView;
    NSString *_imageString;
    NSString *_stroy;
    NSString *_mp3Url;
    UIButton *_button;
    NSString *_title;
    NSString *_content;
    UIButton *_moreButton;
    

}


-(void)viewWillAppear:(BOOL)animated
{
    self.tabBarController.tabBar.hidden = YES;
    [self.tabBarController.view subviews].lastObject.hidden = YES;
//    self.tabBarController.view.hidden = YES;
}
-(void)viewWillDisappear:(BOOL)animated
{ self.tabBarController.tabBar.hidden = NO;
    [self.tabBarController.view subviews].lastObject.hidden = NO;
    [player stop];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.view.backgroundColor = [UIColor redColor];
    [self setViewOfUI];
    //设置右barbutton
    UIImage *image = [UIImage imageNamed:@"Share.png"];
    UIButton *myCustomButton = [UIButton buttonWithType:UIButtonTypeCustom];
    myCustomButton.bounds = CGRectMake( 0, 0, image.size.width, image.size.height );
    [myCustomButton setImage:image forState:UIControlStateNormal];
    [myCustomButton addTarget:self action:@selector(share) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightbar = [[UIBarButtonItem alloc] initWithCustomView:myCustomButton];
    self.navigationItem.rightBarButtonItem = rightbar;
    
    
    _popoverView = [[AXPopoverView alloc] initWithFrame:CGRectMake(0, 0, 300, 150)];
    _popoverView.priority = AXPopoverPriorityVertical;
    _popoverLabel = [[AXPopoverLabel alloc] initWithFrame:CGRectMake(0, 0, 300, 150)];
    _popoverLabel.priority = AXPopoverPriorityVertical;
    
    
    [self yibuPlayer];
    
}


//异步播放歌曲，边缓冲边播放,异步连接
-(void)yibuPlayer{
    NSString * urlString = _mp3Url;
    //不能辨识汉字，需要把汉字转换成UTF8格式
    //    NSString * urlString = [@"http://127.0.0.1/没那么简单.mp3"
    //                            stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"url = %@",urlString);
    NSURL * url = [[NSURL alloc] initWithString:urlString];
    
    NSURLRequest * urlRequest = [[NSURLRequest alloc] initWithURL:url];
    
    //异步请求数据
    [NSURLConnection connectionWithRequest:urlRequest delegate:self];
    //给状态栏加菊花
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    
}
-(void)share
{
    NSString *shareUrl = [NSString stringWithFormat:@"%@%@",SHARE_URL,self.ider];
    
    NSString *shareText = [NSString stringWithFormat:@"%@--%@",_title,_stroy];             //分享内嵌文字
    UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:_imageString]]];
    
    
    //    NSURL *url = [NSURL URLWithString: _museumscoverImage];
    //    //    UIImage *imagea = [UIImage imageWithData: [NSData dataWithContentsOfURL:url]];
    //    UIImage *shareImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:url]];          //分享内嵌图片
    //
    //调用快速分享接口
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:@"55fcee3ce0f55a4ccb006a88"
                                      shareText:shareText
                                     shareImage:image
                                shareToSnsNames:@[UMShareToWechatSession,UMShareToWechatTimeline,UMShareToWechatFavorite,UMShareToSina,UMShareToTencent,UMShareToSms]
                                       delegate:nil];
    
    [UMSocialData defaultData].extConfig.wechatSessionData.url =shareUrl;
    
    [UMSocialData defaultData].extConfig.wechatTimelineData.url = shareUrl;
}


- (void)passimage:(NSArray *)imagearray withTitle:(NSString *)title story:(NSString *)story baidu:(NSString *)baidu mp3:(NSString *)mp3Url content:(NSString *)content
{
    NSLog(@"%@",story);
//    _stroy = story;
    _mp3Url = mp3Url;
    self.navigationItem.title = title;
    _title = title;
//    self.navigationController.title = title;
    NSCharacterSet *set = [NSCharacterSet characterSetWithCharactersInString:@"@／：；（）¥「」＂、[]{}#%-*+=_\\|~＜＞$€^•'@#$%^&*()<br />_+'\""];
    NSString *stroy11 = [story stringByTrimmingCharactersInSet:set];
    _stroy = [self stringDeleteString:stroy11];
    _imageString = imagearray.firstObject;
    _content = content;
    
    
}
-(void)passvideoFromSaoMiao:(NSArray *)image withTitle:(NSString *)title mp3:(NSString *)mp3Url content:(NSString *)content story:(NSString *)story
{
    _mp3Url = mp3Url;
    self.navigationItem.title = title;
    _title = title;
    //    self.navigationController.title = title;
    NSCharacterSet *set = [NSCharacterSet characterSetWithCharactersInString:@"@／：；（）¥「」＂、[]{}#%-*+=_\\|~＜＞$€^•'@#$%^&*()<br />_+'\""];
    NSString *stroy11 = [story stringByTrimmingCharactersInSet:set];
    _stroy = [self stringDeleteString:stroy11];
    _imageString = image.firstObject;
    _content = content;
}

-(NSString *) stringDeleteString:(NSString *)str
{
    NSMutableString *str1 = [NSMutableString stringWithString:str];
    for (int i = 0; i < str1.length; i++) {
        unichar c = [str1 characterAtIndex:i];
        NSRange range = NSMakeRange(i, 1);
        if (c == '<' || c == 'b' || c == 'r' || c == '/' || c == '>') { //此处可以是任何字符
            [str1 deleteCharactersInRange:range];
            --i;
        }
    }
    NSString *newstr = [NSString stringWithString:str1];
    return newstr;
}
-(void)setViewOfUI
{
    NSURL *url = [NSURL URLWithString:_imageString];
    NSData *data = [NSData dataWithContentsOfURL:url];
    UIImage *image111 = [[UIImage alloc] initWithData:data];
    
    _museumsImageView = [[UIImageView alloc] init];
    CGFloat imageH = self.view.frame.size.height;
    CGFloat width = self.view.frame.size.width;
    _museumsImageView.frame  = CGRectMake(0, 0, width, imageH);
//    _museumsImageView.backgroundColor = [UIColor redColor];
    _museumsImageView.layer.masksToBounds = YES;
    [_museumsImageView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"loading.jpg"]];
//    _museumsImageView.image = image111;
    _museumsImageView.layer.cornerRadius = 5;
    _museumsImageView.contentMode = UIViewContentModeScaleAspectFill;
    _museumsImageView.userInteractionEnabled = YES;
    [self.view addSubview:_museumsImageView];
    
    
    
    
    UILabel *story = [[UILabel alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height*0.55, self.view.frame.size.width, self.view.frame.size.height*0.25)];
//    story.text = _story;
    
    
    
    story.font = [UIFont systemFontOfSize:16.0];
    story.numberOfLines = 4;
    story.backgroundColor = [UIColor blackColor];
    story.alpha = 0.6;
    story.textAlignment = NSTextAlignmentCenter;
    story.text = @"ds";
    story.text = _stroy;
    story.textColor = [UIColor whiteColor];
    [_museumsImageView addSubview:story];
    
    //建立缓冲进度条
    progress = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
    progress.frame = CGRectMake(self.view.frame.size.width*0.22,self.view.frame.size.height*0.85,self.view.frame.size.width*0.5, 20);
    progress.progress = 0;
    [self.view addSubview:progress];
    
    
    
    
    _button = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width*0.1,self.view.frame.size.height*0.82, 40,40)];
//    _button.backgroundColor = [UIColor whiteColor];
    [_button setBackgroundImage:[UIImage imageNamed:@"pause.png"] forState:UIControlStateNormal];
    
    [_button addTarget:self action:@selector(playButton) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_button];
    
    _moreButton = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width*0.75,self.view.frame.size.height*0.82, 40,40)];
    //    _button.backgroundColor = [UIColor whiteColor];
    [_moreButton setBackgroundImage:[UIImage imageNamed:@"moreinfo.png"] forState:UIControlStateNormal];
    
    [_moreButton addTarget:self action:@selector(moreButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_moreButton];
    //初始化button
    //异步播放歌曲，边缓冲边播放,异步连接
//    [self buildButtonWithFrame:CGRectMake(self.view.frame.size.width*0.2,self.view.frame.size.height*0.8, 50, 50) Title:@"play" Image:@"play.png" Action:@selector(playButton)];
//    [self buildButtonWithFrame:CGRectMake(100, 100, 120, 40) Title:@"pause" Action:@selector(doPause)];
//    [self buildButtonWithFrame:CGRectMake(100, 150, 120, 40) Title:@"stop" Action:@selector(doStop)];
    
    
}
-(void)playButton
{
    if (player.isPlaying) {
        [_button setBackgroundImage:[UIImage imageNamed:@"play.png"] forState:UIControlStateNormal];
        [player stop];
    }else{
        [_button setBackgroundImage:[UIImage imageNamed:@"pause.png"] forState:UIControlStateNormal];
        [player play];
    }
    
}
-(void)moreButton:(UIButton *)sender
{
    
    [AXPopoverLabel showFromView:sender animated:YES duration:10.0 title:_title detail:_content configuration:^(AXPopoverLabel *popoverLabel) {
        popoverLabel.showsOnPopoverWindow = NO;
        popoverLabel.translucent = NO;
        popoverLabel.titleFont = [UIFont systemFontOfSize:15.0];
        //         popoverLabel.titleTextColor = [UIColor blackColor];
        //         popoverLabel.detailTextColor = [[UIColor blackColor] colorWithAlphaComponent:0.9];
        popoverLabel.preferredArrowDirection = AXPopoverArrowDirectionBottom;
        popoverLabel.translucentStyle = AXPopoverTranslucentLight;
    }];

}

//-(void)buildButtonWithFrame:(CGRect)frame Title:(NSString *)title Image:(NSString *)image Action:(SEL)selector{
//    UIButton * aButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//    aButton.frame = frame;
//    aButton.imageView.image = [UIImage imageNamed:image];
//    [aButton addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:aButton];
//}

#pragma mak - NSURLConnectionDataDelegate
-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    NSLog(@"response++++++++++++++++++ %@",[response suggestedFilename]);
    if (receiveData) {
    }
    receiveData = [[NSMutableData alloc] init];
    
    allLength = [response expectedContentLength];
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    
    [receiveData  appendData:data];
    
    if ([receiveData length] > 20000) {
        
        if (player == nil) {
            
            player = [[AVAudioPlayer alloc] initWithData:receiveData error:nil];
            [player prepareToPlay];
            
        }else if (player.isPlaying == NO){
            
            [player play];
            
        }
        
    }
    
    
    
    
    //改变进度条进度
    progress.progress = [receiveData length]/allLength;
    
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection{
    NSLog(@"_____________finishloading");
    
    //缓冲完成后关闭
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
}

#pragma mark - NSURLConnectionDelegate
-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    
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
