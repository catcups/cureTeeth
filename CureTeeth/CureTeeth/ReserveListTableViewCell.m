//
//  ReserveListTableViewCell.m
//  CureTeeth
//
//  Created by Denny on 16/7/15.
//  Copyright © 2016年 Denny. All rights reserved.
//

#import "ReserveListTableViewCell.h"

@implementation ReserveListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.headImage.layer.cornerRadius = 30;
    self.leftButton.layer.cornerRadius =  self.rightButton.layer.cornerRadius =self.bView.layer.cornerRadius= 5;
    self.bView.layer.borderWidth = 0.5;
    self.bView.layer.borderColor = KGrayColor.CGColor;
    self.headImage.layer.masksToBounds =self.leftButton.layer.masksToBounds = self.leftButton.layer.masksToBounds = self.bView.layer.masksToBounds =YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setModel:(ReserveListModel *)model {
    _model = model;
    [self.headImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",model.photo]]];
    self.userName.text = model.customerName;
    self.time1.text = model.lastApp;
    self.time2.text = model.orderTime;
    self.time3LB.text = model.time3;
    self.historyLabel.text = model.appointment;
    self.askLabel.text = model.advisory;
    if ([model.orderStatus isEqualToString:@"2"]) {
        [self.leftButton setTitle:@"已同意" forState:UIControlStateNormal];
        self.leftButton.userInteractionEnabled = NO;
        self.rightButton.hidden = YES;
    }
    if ([model.orderStatus isEqualToString:@"3"]) {
        [self.leftButton setTitle:@"已拒绝" forState:UIControlStateNormal];
        [self.leftButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        self.leftButton.userInteractionEnabled = NO;
        self.rightButton.hidden = YES;
    }
    if ([model.orderStatus isEqualToString:@"4"]) {
        [self.leftButton setTitle:@"已完成" forState:UIControlStateNormal];
        self.leftButton.userInteractionEnabled = NO;
        self.rightButton.hidden = YES;

    }
    
}
- (IBAction)rightButton:(id)sender {
    if(self.delegate &&[self.delegate respondsToSelector:@selector(ReserveListTableViewCellDelegateRightButton:model:)]){
        [self.delegate ReserveListTableViewCellDelegateRightButton:self model:self.model];
    }
}
- (IBAction)leftButton:(id)sender {
    if(self.delegate &&[self.delegate respondsToSelector:@selector(ReserveListTableViewCellDelegateLeftButton:model:)]){
        [self.delegate ReserveListTableViewCellDelegateLeftButton:self model:self.model];
    }
}

@end
