//
//  InfoDetailViewController.m
//  CureTeeth
//
//  Created by Denny on 16/7/15.
//  Copyright © 2016年 Denny. All rights reserved.
//

#import "InfoDetailViewController.h"

@interface InfoDetailViewController ()
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UILabel *sex;
@property (weak, nonatomic) IBOutlet UIButton *phoneButton;
@property (weak, nonatomic) IBOutlet UITextView *aboutMe;
@property (weak, nonatomic) IBOutlet UIButton *backbutton;

@end

@implementation InfoDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"个人信息";
    self.userName.text = self.infoModel.name;
    self.backbutton.layer.cornerRadius = 5;
    self.backbutton.backgroundColor = KMainColor;
    [self.phoneButton setTitle:self.infoModel.mobile forState:UIControlStateNormal];
    self.aboutMe.text = self.infoModel.aboutMe;
    self.sex.text = self.infoModel.sex;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)makeCall:(UIButton *)sender {
    if (sender.titleLabel.text) {
        [StringUtils makeCall:sender.titleLabel.text];
    }
}
- (IBAction)backButton:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
