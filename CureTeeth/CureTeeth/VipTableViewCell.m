//
//  VipTableViewCell.m
//  CureTeeth
//
//  Created by Denny on 16/7/14.
//  Copyright © 2016年 Denny. All rights reserved.
//

#import "VipTableViewCell.h"

@implementation VipTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.headImage.layer.cornerRadius = 30;
    self.bview.layer.cornerRadius = 5;
    self.headImage.layer.masksToBounds =self.bview.layer.masksToBounds= YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)callPhone:(UIButton *)sender {
    if (sender.titleLabel.text) {
        [StringUtils makeCall:sender.titleLabel.text];
    }
}

-(void)setModel:(VipModel *)model {
    [self.headImage sd_setImageWithURL:[NSURL URLWithString:model.photo]];
    [self.phoneButton setTitle:model.mobile forState:UIControlStateNormal];
}
@end
