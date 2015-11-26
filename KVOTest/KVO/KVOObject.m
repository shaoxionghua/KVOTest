//
//  KVOObject.m
//  KVOTest
//
//  Created by danggui on 15/11/12.
//  Copyright © 2015年 danggui. All rights reserved.
//

#import "KVOObject.h"

static KVOObject *KVO;

@implementation KVOObject

+(instancetype)getInstance
{
    
    if (KVO == nil) {
        KVO = [[KVOObject alloc] init];
    }

    
    return KVO;
}


- (instancetype)init
{
    self = [super init];
    return self;
}


+ (void)CreatNotification:(id)sender
{
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(sender) name:@"sender" object:nil];
}


+ (void)RemoveNotification:(id)sender
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(sender) name:@"sender" object:nil];
}

+(void)myMethond:(id)sender
{
    
}
@end
