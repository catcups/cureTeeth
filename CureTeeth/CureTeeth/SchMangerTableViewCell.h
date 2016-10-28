//
//  SchMangerTableViewCell.h
//  CureTeeth
//
//  Created by Denny on 16/7/19.
//  Copyright © 2016年 Denny. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SchMangerModel.h"
@interface SchMangerTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *dname;
@property(nonatomic,strong)SchMangerModel *model;
@property (weak, nonatomic) IBOutlet UILabel *cname;
@property (weak, nonatomic) IBOutlet UILabel *reseverTime;
@property (weak, nonatomic) IBOutlet UIImageView *headImage;



@end
