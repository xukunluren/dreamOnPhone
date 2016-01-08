//
//  DreamViewController.h
//  dreamOnPhone
//
//  Created by admin on 16/1/6.
//  Copyright © 2016年 xukun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DreamViewController : UIViewController <UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property(strong,nonatomic)UICollectionView *collectionView;

@end
