//
//  ReserveListTableViewCell.h
//  CureTeeth
//
//  Created by Denny on 16/7/15.
//  Copyright © 2016年 Denny. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ReserveListModel.h"
@class ReserveListTableViewCell;
@protocol ReserveListTableViewCellDelegate <NSObject>

- (void)ReserveListTableViewCellDelegateLeftButton:(ReserveListTableViewCell *)cell model:(ReserveListModel *)model ;
- (void)ReserveListTableViewCellDelegateRightButton:(ReserveListTableViewCell *)cell model:(ReserveListModel *)model;

@end
@interface ReserveListTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *time3LB;
@property (weak, nonatomic) IBOutlet UIImageView *headImage;
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UILabel *time1;
@property (weak, nonatomic) IBOutlet UILabel *time2;
@property (weak, nonatomic) IBOutlet UILabel *historyLabel;
@property (weak, nonatomic) IBOutlet UILabel *askLabel;
@property (weak, nonatomic) IBOutlet UIButton *leftButton;
@property (weak, nonatomic) IBOutlet UIButton *rightButton;
@property(nonatomic,strong)ReserveListModel *model;
@property (weak, nonatomic) IBOutlet UIView *bView;
@property(nonatomic,assign)id<ReserveListTableViewCellDelegate>delegate;
@end
