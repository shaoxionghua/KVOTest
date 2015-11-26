//
//  HealthTableViewCell.h
//  KVOTest
//
//  Created by danggui on 15/11/20.
//  Copyright © 2015年 danggui. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HealthTableViewCell : UITableViewCell

{
    id Adelegate;
}

@property(nonatomic,retain) id Adelegate;



@property (weak, nonatomic) IBOutlet UILabel *itemName;
@property (weak, nonatomic) IBOutlet UILabel *timeLab;
@property (weak, nonatomic) IBOutlet UIImageView *iconimage;
@property (weak, nonatomic) IBOutlet UILabel *pnameLab;
@property (weak, nonatomic) IBOutlet UILabel *rLab;
@property (weak, nonatomic) IBOutlet UILabel *sLab;
@property (weak, nonatomic) IBOutlet UILabel *aLab;


@end
