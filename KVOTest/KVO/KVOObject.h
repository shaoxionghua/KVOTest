//
//  KVOObject.h
//  KVOTest
//
//  Created by danggui on 15/11/12.
//  Copyright © 2015年 danggui. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KVOObject : NSObject

+(KVOObject *)getInstance;

+(void)CreatNotification:(id)sender;
+(void)RemoveNotification:(id)sender;

+(void)myMethond:(id)sender;

@end
