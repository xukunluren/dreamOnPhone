//
//  AppDelegate.h
//  dreamOnPhone
//
//  Created by admin on 15/8/6.
//  Copyright (c) 2015年 xukun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "NTViewController.h"
#import "EAIntroView.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate,EAIntroDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UIViewController *viewController;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property(retain,atomic) UITabBarController *tabbarController;

@property (strong ,nonatomic) NTViewController *NTviewController;


- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;



@end

