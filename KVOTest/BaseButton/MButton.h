//
//  MButton.h
//  KVOTest
//
//  Created by danggui on 15/11/13.
//  Copyright © 2015年 danggui. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UIButton (badge)

- (void)showBadgeOnItemIndex:(id)sender;   //显示小红点
- (void)hideBadgeOnItemIndex:(id)sender; //隐藏小红点
- (void)selectBtn:(UIButton *)sender;


@end
