//
//  DataManager.m
//  KVOTest
//
//  Created by danggui on 15/11/23.
//  Copyright © 2015年 danggui. All rights reserved.
//

#import "DataManager.h"

@implementation DataManager


+(instancetype)getInstance
{
    static DataManager *person;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        person = [[DataManager alloc] init];
    });
    return person;
}


+ (DataManager *)defaultPerson {
    static DataManager * nowUser = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        nowUser = [[DataManager alloc] init];
    });
    
    return nowUser;
}

- (instancetype)init
{
    self = [super init];
    return self;
}


- (void)encodeWithCoder:(NSCoder *)aCoder;
{
    // 这里放置需要持久化的属性
    [aCoder encodeObject:self.userID forKey:@"userID"];
    [aCoder encodeObject:self.isLogin forKey:@"isLogin"];
    [aCoder encodeObject:self.avatarUrl forKey:@"avatarUrl"];
    [aCoder encodeObject:self.cellNum forKey:@"cellNum"];
    [aCoder encodeObject:self.level forKey:@"level"];
    [aCoder encodeObject:self.nickName forKey:@"nickName"];
    
}
- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [self init])
    {
        //  这里务必和encodeWithCoder方法里面的内容一致，不然会读不到数据
        
        self.userID = [aDecoder decodeObjectForKey:@"userID"];
        self.isLogin= [aDecoder decodeObjectForKey:@"isLogin"];
        self.avatarUrl= [aDecoder decodeObjectForKey:@"avatarUrl"];
        self.cellNum= [aDecoder decodeObjectForKey:@"cellNum"];
        self.level= [aDecoder decodeObjectForKey:@"level"];
        self.nickName= [aDecoder decodeObjectForKey:@"nickName"];

        
    }
    return self;
}



@end
