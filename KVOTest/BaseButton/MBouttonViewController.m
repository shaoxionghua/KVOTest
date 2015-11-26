//
//  MBouttonViewController.m
//  KVOTest
//
//  Created by danggui on 15/11/13.
//  Copyright © 2015年 danggui. All rights reserved.
//

#import "MBouttonViewController.h"
#import "ViewController.h"

#import "MButton.h"

@interface MBouttonViewController ()

@end

@implementation MBouttonViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"MButton";
    
    [self.mybtn showBadgeOnItemIndex:self.mybtn];

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/**
 *  Mboutton--自定义方法
 */


- (IBAction)selectBtn:(id)sender
{
    [self.mybtn selectBtn:self.mybtn];
}

@end
