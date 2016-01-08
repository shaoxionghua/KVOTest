//
//  ViewController.m
//  KVOTest
//
//  Created by danggui on 15/11/12.
//  Copyright © 2015年 danggui. All rights reserved.
//

#import "ViewController.h"
#import "MBouttonViewController.h"
#import "KVOViewController.h"
#import "MButton.h"
#import "HealthViewController.h"
#import "MapViewController.h"
#import "CoreDataViewController.h"
#import "OCJSViewController.h"
@interface ViewController ()
{
    NSMutableArray *listArr;
    
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"控件";
    listArr = [[NSMutableArray alloc]initWithObjects:@"KVO",@"BaseButton",@"BaseLabel",@"NetWorking",@"healthDemo",@"MapDemo",@"CoreData",@"OC和JS相互调用",nil];

//    NSString *mystr = @"testooooooooooooooooo名字";
//    
//    NSString *regex = @"^[a-zA-Z\u4e00-\u9fa5][a-zA-Z0-9\u4e00-\u9fa5]{1,15}$";
//    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
//    BOOL isMatch = [pred evaluateWithObject:mystr];
//    NSLog(@"ojc");
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - tabViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return listArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        
        KVOViewController *KVO = [[KVOViewController alloc]init];
        KVO.Adelegate = self;
        [self.navigationController pushViewController:KVO animated:YES];
        
    }
    if (indexPath.row == 1) {
        
        MBouttonViewController *MB = [[MBouttonViewController alloc]init];

        [self.navigationController pushViewController:MB animated:YES];
        
    }
    if (indexPath.row == 2) {
        
        MBouttonViewController *MB = [[MBouttonViewController alloc]init];
        [self.navigationController pushViewController:MB animated:YES];
        
    }
    if (indexPath.row == 3) {
        
        MBouttonViewController *MB = [[MBouttonViewController alloc]init];
        [self.navigationController pushViewController:MB animated:YES];
        
    }
    
    if (indexPath.row == 4) {
        
        HealthViewController *h = [[HealthViewController alloc]init];
        [self.navigationController pushViewController:h animated:YES];
        
    }
    
    if (indexPath.row == 5) {
        
        MapViewController *h = [[MapViewController alloc]init];
        [self.navigationController pushViewController:h animated:YES];
        
    }
    if (indexPath.row == 6) {
        
        CoreDataViewController *h = [[CoreDataViewController alloc]init];
        [self.navigationController pushViewController:h animated:YES];
        
    }
    
    if (indexPath.row == 7) {
        
        OCJSViewController *h = [[OCJSViewController alloc]init];
        [self.navigationController pushViewController:h animated:YES];
        
    }
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    cell.textLabel.text= [listArr objectAtIndex:indexPath.row];
    return cell;
    
}

/**
 *  A--delegate
 */

-(void)delegateMethod
{
    NSLog(@"delegateMethod");
    
    UIAlertView *alt = [[UIAlertView alloc]initWithTitle:@"A_delegate" message:@"delegate实现成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
    [alt show];
    
}




@end
