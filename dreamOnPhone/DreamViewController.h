//
//  DreamViewController.h
//  dreamOnPhone
//
//  Created by admin on 16/1/6.
//  Copyright © 2016年 xukun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DreamViewController : UIViewController <UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
@private
UIScrollView * mainScrollView;
//UITableView * _tableView;
      UIButton * button;
}

//@property(strong,nonatomic)UICollectionView *collectionView;
@property(strong,nonatomic)UITableView *tableView;

@end
