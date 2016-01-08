//
//  OCJSObject.m
//  KVOTest
//
//  Created by danggui on 16/1/7.
//  Copyright © 2016年 danggui. All rights reserved.
//

#import "OCJSObject.h"

@implementation OCJSObject


//一下方法都是只是打了个log 等会看log 以及参数能对上就说明js调用了此处的iOS 原生方法
-(void)PublicMethod:(NSString *)message
{
    NSLog(@"this is ios TestNOParameter");
}
-(void)LoginJudge:(NSString *)message
{
    NSLog(@"this is ios TestOneParameter=%@",message);
}
-(void)PayMethondParameter:(NSString *)message1
{
    NSLog(@"this is ios TestTowParameter=%@",message1);
}


@end
