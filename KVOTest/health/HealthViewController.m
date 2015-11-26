//
//  HealthViewController.m
//  KVOTest
//
//  Created by danggui on 15/11/20.
//  Copyright © 2015年 danggui. All rights reserved.
//

#import "HealthViewController.h"
#import "HealthTableViewCell.h"
#import "DataManager.h"

@interface HealthViewController ()

{
    HealthTableViewCell *menuCell;
    
}
@end

@implementation HealthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [DataManager getInstance].userID = @"1";
    
    _listArr = [[NSMutableArray alloc]init];
    
    for (int i= 0 ; i<4; i++) {
        NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
        [dic setObject:@"脊柱养护" forKey:@"item"];
        [dic setObject:@"2015-09-01 10:20" forKey:@"time"];
        [dic setObject:@"玄喵" forKey:@"pname"];
        [dic setObject:@"image5.jpg" forKey:@"pimage"];
        [dic setObject:@"全身酸痛" forKey:@"symptom"];
        [dic setObject:@"扯犊子" forKey:@"seritem"];
        [dic setObject:@"该吃吃该喝喝" forKey:@"seradvise"];
        
        [_listArr addObject:dic];
    }
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
    return _listArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CellIdentifier";
    menuCell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (menuCell == nil) {
        //通过xib的名称加载自定义的cell
        menuCell = [[HealthTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        menuCell = [[[NSBundle mainBundle] loadNibNamed:@"HealthTableViewCell" owner:self options:nil] lastObject];
        //        menuCell.backgroundColor =  [ColorSet colorWithHexString:ViewBgColor];
    }
    return menuCell.frame.size.height;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    menuCell = (HealthTableViewCell *)[_listView cellForRowAtIndexPath:indexPath];
    [_listView deselectRowAtIndexPath:indexPath animated:NO];
    
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CellIdentifier";
    menuCell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (menuCell == nil) {
        //通过xib的名称加载自定义的cell
        menuCell = [[HealthTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        menuCell = [[[NSBundle mainBundle] loadNibNamed:@"HealthTableViewCell" owner:self options:nil] lastObject];
        menuCell.selectionStyle = UITableViewCellSelectionStyleNone;
        menuCell.Adelegate = self;
    }
    
    NSMutableDictionary *dic = [_listArr objectAtIndex:indexPath.row];
    menuCell.itemName = [dic objectForKey:@"item"];
    menuCell.pnameLab = [dic objectForKey:@"pname"];
    menuCell.timeLab = [dic objectForKey:@"time"];
    menuCell.iconimage.image = [UIImage imageNamed:[dic objectForKey:@"pimage"]];
    menuCell.rLab = [dic objectForKey:@"symptom"];
    menuCell.sLab = [dic objectForKey:@"seritem"];
    menuCell.aLab = [dic objectForKey:@"seradvise"];
    
    return menuCell;
    
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
