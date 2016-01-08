//
//  OCJSObject.h
//  KVOTest
//
//  Created by danggui on 16/1/7.
//  Copyright © 2016年 danggui. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JavaScriptCore/JavaScriptCore.h>  

//首先创建一个实现了JSExport协议的协议
@protocol TestJSObjectProtocol <JSExport>


//-(void)PublicMethod:(NSString *)message;
//-(void)LoginJudge:(NSString *)message;
//-(void)PayMethondParameter:(NSString *)message1 SecondParameter:(NSString *)message2;


-(void)PublicMethod:(NSString *)message;
-(void)LoginJudge:(NSString *)message;
-(void)PayMethondParameter:(NSString *)message;


@end


@interface OCJSObject : NSObject<TestJSObjectProtocol>


@end
