//
//  ViewController.h
//  KVOTest
//
//  Created by danggui on 15/11/12.
//  Copyright © 2015年 danggui. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CellDelegate

-(void)delegateMethod;

@end


@interface ViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,CellDelegate>

@property (weak, nonatomic) IBOutlet UITableView *Mytabview;

@end




