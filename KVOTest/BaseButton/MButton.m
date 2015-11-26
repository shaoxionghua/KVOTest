//
//  MButton.m
//  KVOTest
//
//  Created by danggui on 15/11/13.
//  Copyright © 2015年 danggui. All rights reserved.
//

#import "MButton.h"

@implementation UIButton (badge)

//显示小红点
- (void)showBadgeOnItemIndex:(id)sender{
    //移除之前的小红点
    [self removeBadgeOnItemIndex:sender];
    //新建小红点
    UIView *badgeView = [[UIView alloc]init];
    badgeView.tag = 888 + [sender tag];
    badgeView.layer.cornerRadius = 4;//圆形
    badgeView.backgroundColor = [UIColor redColor];//颜色：红色
    CGRect tabFrame = self.frame;
    
    UIButton *btn = (UIButton *)sender;
    
    //确定小红点的位置
    float percentX = btn.frame.size.width-8;
    CGFloat x = ceilf(percentX);
    CGFloat y = ceilf(0.1 * tabFrame.size.height-1);
    badgeView.frame = CGRectMake(x, y, 8, 8);//圆形大小为10
    [self addSubview:badgeView];
}

//隐藏小红点
- (void)hideBadgeOnItemIndex:(id)sender{
    //移除小红点
    [self removeBadgeOnItemIndex:sender];
}

//移除小红点
- (void)removeBadgeOnItemIndex:(id)index{
    //按照tag值进行移除
    for (UIView *subView in self.subviews) {
        if (subView.tag == 888+[index tag]) {
            [subView removeFromSuperview];
        }
    }
}


- (void)selectBtn:(UIButton *)sender {
    
    if (sender.selected ==YES) {
        sender.selected = NO;
        [sender showBadgeOnItemIndex:sender];
    }
    else
    {
        sender.selected = YES;
        [sender hideBadgeOnItemIndex:sender];
    }
}


@end

