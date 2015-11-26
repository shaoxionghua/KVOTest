//
//  DataManager.h
//  KVOTest
//
//  Created by danggui on 15/11/23.
//  Copyright © 2015年 danggui. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataManager : NSObject<NSCoding>

@property (nonatomic, copy) NSString *userID;//用户id（后台设定）
@property (nonatomic, copy) NSString *isLogin;//判断是否登录
@property (nonatomic, copy) NSString *avatarUrl;//头像
@property (nonatomic, copy) NSString *cellNum;//用户名（手机号码）
@property (nonatomic, copy) NSString *level;//用户等级
@property (nonatomic, copy) NSString *nickName;//昵称

@property (nonatomic, copy) NSString *deviceToken;//推送token


+(DataManager *)getInstance;


@end
