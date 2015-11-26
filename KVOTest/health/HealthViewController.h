//
//  HealthViewController.h
//  KVOTest
//
//  Created by danggui on 15/11/20.
//  Copyright © 2015年 danggui. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MyDelegate

-(void)delegateMethod;

@end

@interface HealthViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,MyDelegate>

@property (weak, nonatomic) IBOutlet UITableView *listView;
@property (retain,nonatomic) NSMutableArray *listArr;


@end
