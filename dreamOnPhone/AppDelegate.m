//
//  AppDelegate.m
//  dreamOnPhone
//
//  Created by admin on 15/8/6.
//  Copyright (c) 2015年 xukun. All rights reserved.
//

#import "AppDelegate.h"
#import "RDVTabBarController.h"
#import "RDVTabBarItem.h"
#import "RDVFirstViewController.h"
#import "DreamOfLifeViewController.h"
#import "DreamOfProductViewController.h"
#import "DreamOfEweakViewController.h"
#import "RDVFirthViewController.h"
#import "DreamOfEweeklyViewController.h"
#import "UMSocial.h"
#import "NTViewController.h"
#import "DreamViewController.h"
//#import "QRCodeReaderViewController.h"
#import "saoMiaoResultViewController.h"
#import "saoyisaoViewController.h"
#import "UMSocialWechatHandler.h"
#import "Scan_VC.h"
#import "yidaoViewController.h"
#import "CoreNewFeatureVC.h"
#import "dynamicalViewController.h"
#import "EweeklyViewController.h"
#import "CamerViewController.h"


@interface AppDelegate ()
@property(nonatomic,strong)CamerViewController *yyy;
@property(nonatomic,strong)Scan_VC *saomian;
@end

@implementation AppDelegate
{
// saoMiaoResultViewController *_saoMiao;
    UITabBarController *tabBarController;
//    Scan_VC *saomian;
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    NSUserDefaults *userdefaults = [NSUserDefaults standardUserDefaults];
    int number = 0;
    [userdefaults setInteger:number  forKey:@"number"];
    [UMSocialData setAppKey:@"55fcee3ce0f55a4ccb006a88"];

    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
    
   [UMSocialWechatHandler setWXAppId:@"wxd74689eea1f59a10" appSecret:@"5527f924ab4a416a8b8e85ba0f5c0667" url:@"http://www.baidu.com"];
   
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    self.window.backgroundColor = [UIColor whiteColor];
//    [self judgeFirstOpenApp];

    //判断是否需要显示：（内部已经考虑版本及本地版本缓存）
//    BOOL canShow = [CoreNewFeatureVC canShowNewFeature];
//    
//    //测试代码，正式版本应该删除
////    canShow = YES;
//    
//    if(canShow){
//        
//        
//        NewFeatureModel *m1 = [NewFeatureModel model:[UIImage imageNamed:@"f1"]];
//        
//        NewFeatureModel *m2 = [NewFeatureModel model:[UIImage imageNamed:@"f2"]];
//        
//        NewFeatureModel *m3 = [NewFeatureModel model:[UIImage imageNamed:@"f3"]];
//        
//        self.window.rootViewController = [CoreNewFeatureVC newFeatureVCWithModels:@[m1,m2,m3] enterBlock:^{
//            
//            NSLog(@"进入主页面");
//           [self setMainView];
//        }];
//    }else{
//        
//        [self setMainView];
//    }
    
    
     [self setMainView];
     [self.window makeKeyAndVisible];
//    [self customizeInterface];
    
    return YES;
   
}


-(void)setMainView
{
     tabBarController = [[UITabBarController alloc]init];
    
    //用于设置字体的问题（颜色和大小等）
    [[UITabBarItem appearance] setTitleTextAttributes:@{UITextAttributeFont : [UIFont systemFontOfSize:12],UITextAttributeTextColor : [UIColor whiteColor]} forState:UIControlStateNormal];
    
    [[UITabBarItem appearance] setTitleTextAttributes:@{UITextAttributeFont : [UIFont fontWithName:@"Arial-BoldMT" size:12],UITextAttributeTextColor:[UIColor whiteColor]} forState:UIControlStateSelected];
    
    
    RDVFirstViewController *wind = [[RDVFirstViewController alloc]init];
    //    wind.navigationController.navigationBar.backgroundColor = [UIColor  colorWithRed:67.0/255.0 green:148.0/255.0 blue:247.0/255.0 alpha:1.0];
    //  wind.navigationController.navigationBar.barTintColor = [UIColor  colorWithRed:67.0/255.0 green:148.0/255.0 blue:247.0/255.0 alpha:1.0];
    //可用于解决图片灰色问题
    wind.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"梦之园" image:[[UIImage imageNamed:@"home.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"home.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
   self.saomian = [[Scan_VC alloc] init];
//    UIViewController *yyy = [[UIViewController alloc] init];
   _yyy = [[CamerViewController alloc] init];
//    self.saomian.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"扫一扫" image:[[UIImage imageNamed:@"scaning.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"scaning.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    self.saomian.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"扫一扫" image:[[UIImage imageNamed:@"scaning.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"scaning.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
//    QRCodeReaderViewController *photoq = [[QRCodeReaderViewController alloc] init];
//    //    photoq.delegate = self;
//    photoq.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"扫一扫" image:[[UIImage imageNamed:@"scaning.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"scaning.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    //    DreamOfLifeViewController *wave = [[DreamOfLifeViewController alloc]init];
    //    //可用于解决图片灰色问题
    //    wave.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"梦生命" image:[[UIImage imageNamed:@"plant.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"plant.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
//    DreamOfProductViewController *flow = [[DreamOfProductViewController alloc]init];
    dynamicalViewController *flow = [[dynamicalViewController alloc] init];
    flow.titleString = @"乐活动";
    flow.tag = @"0";
//    flow.view.backgroundColor = [UIColor colorWithRed:230.0/255.0 green:230.0/255.0 blue:230.0/255.0 alpha:1.0];

    //可用于解决图片灰色问题
    flow.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"乐活动" image:[[UIImage imageNamed:@"shopping.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"shopping.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    //    DreamOfEweakViewController *four = [[DreamOfEweakViewController alloc]init];
    
    
//    DreamViewController *four = [[DreamViewController alloc] init];
//    rootViewController *four = [[rootViewController alloc] init];
    EweeklyViewController *four = [[EweeklyViewController alloc] init];
    //可用于解决图片灰色问题
     
    four.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"E周刊" image:[[UIImage imageNamed:@"eweekly.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"eweekly.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    RDVFirthViewController *longTide = [[RDVFirthViewController alloc]init];
    //可用于解决图片灰色问题
    longTide.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"我的" image:[[UIImage imageNamed:@"mysetting.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"mysetting.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    //navigation
    
    UINavigationController *navFrist = [[UINavigationController alloc]initWithRootViewController:wind];
    
    [tabBarController addChildViewController:navFrist];
    
    //    UINavigationController *navSecond = [[UINavigationController alloc]initWithRootViewController:wave];
    //    //    navSecond.navigationBar.backgroundColor = BarColor;
    //    [tabBarController addChildViewController:navSecond];
    
    UINavigationController *navThrid = [[UINavigationController alloc]initWithRootViewController:flow];
    //    navThrid.navigationBar.backgroundColor = BarColor;
//    navThrid.view.backgroundColor = [UIColor colorWithRed:230.0/255.0 green:230.0/255.0 blue:230.0/255.0 alpha:1.0];
    [tabBarController addChildViewController:navThrid];
    UINavigationController *photo = [[UINavigationController alloc] initWithRootViewController:
                                     self.saomian];
    [tabBarController addChildViewController:photo];
    //    UINavigationController *photo = [[UINavigationController alloc] initWithRootViewController:viewController];
    UINavigationController *navForth = [[UINavigationController alloc]initWithRootViewController:four];
    //    navForth.navigationBar.backgroundColor = BarColor;
    
    [tabBarController addChildViewController:navForth];
    
    UINavigationController *navFifth = [[UINavigationController alloc]initWithRootViewController:longTide];
    
    //    navFifth.navigationBar.backgroundColor = BarColor;
    [tabBarController addChildViewController:navFifth];
    tabBarController.navigationController.navigationBar.backgroundColor = [UIColor  colorWithRed:67.0/255.0 green:148.0/255.0 blue:247.0/255.0 alpha:1.0];
    
    tabBarController.tabBar.barTintColor = [UIColor colorWithRed:67.0/255.0 green:148.0/255.0 blue:247.0/255.0 alpha:1.0];
    [tabBarController.tabBar setShadowImage:[UIImage imageNamed:@"tabarborderimag.png"]];
    self.window.rootViewController = tabBarController;
    
    
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
//    [btn addTarget:self action:@selector(saoMiaoTiaozhuan) forControlEvents:UIControlEventTouchUpInside];
    btn.backgroundColor=[UIColor  colorWithRed:67.0/255.0 green:148.0/255.0 blue:247.0/255.0 alpha:1];
    [btn setTintColor:[UIColor colorWithRed:67.0/255.0 green:148.0/255.0 blue:247.0/255.0 alpha:1.0]];
    btn.frame=CGRectMake(self.window.frame.size.width*0.5-40, self.window.frame.size.height-80, 80, 80);
    UIImageView *imagview = [[UIImageView alloc] init];
    imagview.frame = CGRectMake(22, 15, 40, 40);
    UIImage *image = [UIImage imageNamed:@"code.png"];
    imagview.image = image;
    [btn addSubview:imagview];
    btn.center=tabBarController.tabBar.center;
    btn.layer.cornerRadius = btn.frame.size.width/2.0;
    btn.layer.borderWidth = 0.5;
    btn.layer.borderColor = (__bridge CGColorRef _Nullable)([UIColor whiteColor]);
    btn.layer.masksToBounds = btn.frame.size.width/2.0;
    [btn addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
    [tabBarController.view addSubview:btn];
}
-(void)click
{
    UIViewController *view = tabBarController.viewControllers[2];
    tabBarController.selectedViewController = view;

}

-(void)saoMiaoTiaozhuan
{
    Scan_VC *saoMian = [[Scan_VC alloc] init];
    [self.window.rootViewController presentViewController:saoMian animated:YES completion:^{
    }];

}

- (void)customizeInterface {
    UINavigationBar *navigationBarAppearance = [UINavigationBar appearance];
    
    UIImage *backgroundImage = nil;
    NSDictionary *textAttributes = nil;
    
    if (NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_6_1) {
        backgroundImage = [UIImage imageNamed:@"navigationbar_background_tall"];
        
        textAttributes = @{
                           NSFontAttributeName: [UIFont boldSystemFontOfSize:18],
                           NSForegroundColorAttributeName: [UIColor blackColor],
                           };
    } else {
#if __IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_7_0
        backgroundImage = [UIImage imageNamed:@"navigationbar_background"];
        
        textAttributes = @{
                           UITextAttributeFont: [UIFont boldSystemFontOfSize:18],
                           UITextAttributeTextColor: [UIColor blackColor],
                           UITextAttributeTextShadowColor: [UIColor clearColor],
                           UITextAttributeTextShadowOffset: [NSValue valueWithUIOffset:UIOffsetZero],
                           };
#endif
    }
    
    [navigationBarAppearance setBackgroundImage:backgroundImage
                                  forBarMetrics:UIBarMetricsDefault];
    [navigationBarAppearance setTitleTextAttributes:textAttributes];
}



- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}

#pragma mark - Core Data stack

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory {
    // The directory the application uses to store the Core Data store file. This code uses a directory named "cn.shou.xukun.dreamOnPhone" in the application's documents directory.
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
    // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"dreamOnPhone" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    // The persistent store coordinator for the application. This implementation creates and return a coordinator, having added the store for the application to it.
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    // Create the coordinator and store
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"dreamOnPhone.sqlite"];
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        // Report any error we got.
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        // Replace this with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }

    return _persistentStoreCoordinator;
}


- (NSManagedObjectContext *)managedObjectContext {
    
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] init];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

 //

@end
