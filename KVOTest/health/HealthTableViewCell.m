//
//  HealthTableViewCell.m
//  KVOTest
//
//  Created by danggui on 15/11/20.
//  Copyright © 2015年 danggui. All rights reserved.
//

#import "HealthTableViewCell.h"
#import "HealthViewController.h"

@implementation HealthTableViewCell
@synthesize Adelegate;

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSSet *allTouches = [event allTouches];    //返回与当前接收者有关的所有的触摸对象
    UITouch *touch = [allTouches anyObject];   //视图中的所有对象
    CGPoint point = [touch locationInView:[touch view]]; //返回触摸点在视图中的当前坐标
    int x = point.x;
    int y = point.y;
    NSLog(@"touch (x, y) is (%d, %d)", x, y);
    
    if (y>=40 && y<=100) {
            [Adelegate delegateMethod];
    }

    
}

@end
