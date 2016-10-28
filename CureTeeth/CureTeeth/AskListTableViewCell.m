//
//  AskListTableViewCell.m
//  CureTeeth
//
//  Created by Denny on 16/7/16.
//  Copyright © 2016年 Denny. All rights reserved.
//

#import "AskListTableViewCell.h"

@implementation AskListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.headImage.layer.cornerRadius = 30;
    self.bView.layer.cornerRadius = 5;
    self.bView.layer.masksToBounds = YES;
    self.bView.layer.borderWidth = 0.5;
    self.bView.layer.borderColor = [UIColor grayColor].CGColor;
    self.headImage.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)makeCall:(UIButton *)sender {
    if (sender.titleLabel.text) {
        [StringUtils makeCall:sender.titleLabel.text];
    }
}

-(void)setModel:(AskListModel *)model {
    [self.headImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",model.photo]]];
    [self.phoneButton setTitle:model.mobile forState:UIControlStateNormal];
    self.timeLabel.text = model.time;
    self.haveImageLabel.text = model.havePhoto;
    self.contentLabel.text = model.content;
    if ([model.state isEqualToString:@"0"]) {
        [self.rightImageView setImage:[UIImage imageNamed:@"unfin"]];
    }else {
        [self.rightImageView setImage:[UIImage imageNamed:@"fin"]];
    }
    
}

@end
