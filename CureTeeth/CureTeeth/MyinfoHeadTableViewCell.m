//
//  MyinfoHeadTableViewCell.m
//  CureTeeth
//
//  Created by Denny on 16/7/14.
//  Copyright © 2016年 Denny. All rights reserved.
//

#import "MyinfoHeadTableViewCell.h"

@implementation MyinfoHeadTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.headImage.layer.cornerRadius = 30;
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

@end
