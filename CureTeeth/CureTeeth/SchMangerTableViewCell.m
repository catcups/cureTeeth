
//
//  SchMangerTableViewCell.m
//  CureTeeth
//
//  Created by Denny on 16/7/19.
//  Copyright © 2016年 Denny. All rights reserved.
//

#import "SchMangerTableViewCell.h"

@implementation SchMangerTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.headImage.layer.cornerRadius = 5;
    self.headImage.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(void)setModel:(SchMangerModel *)model {
    self.dname.text = model.dname;
    self.cname .text = model.cname;
    self.reseverTime.text = model.targetDate;
    [self.headImage sd_setImageWithURL:[NSURL URLWithString:model.cphoto]];
}
@end
