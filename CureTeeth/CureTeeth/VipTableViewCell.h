//
//  VipTableViewCell.h
//  CureTeeth
//
//  Created by Denny on 16/7/14.
//  Copyright © 2016年 Denny. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VipModel.h"
@interface VipTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *bview;
@property (weak, nonatomic) IBOutlet UIButton *phoneButton;
@property (weak, nonatomic) IBOutlet UIImageView *headImage;
@property (nonatomic,strong)VipModel *model;
@end
