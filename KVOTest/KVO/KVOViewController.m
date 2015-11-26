//
//  KVOViewController.m
//  KVOTest
//
//  Created by danggui on 15/11/12.
//  Copyright © 2015年 danggui. All rights reserved.
//

#import "KVOViewController.h"
#import "ViewController.h"
#import "KVOObject.h"

@interface KVOViewController ()
{
    KVOObject *KVO;
}
@end

@implementation KVOViewController
@synthesize Adelegate;


- (void)viewDidLoad{
    [super viewDidLoad];
    self.title = @"KVO";
    [Adelegate delegateMethod];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (void)mytest{
    NSLog(@"KVO---done");
}

@end
