//
//  AddClinicViewController.m
//  CureTeeth
//
//  Created by Denny on 16/7/15.
//  Copyright © 2016年 Denny. All rights reserved.
//

#import "AddClinicViewController.h"
#import "AddClinicReq.h"
@interface AddClinicViewController ()

@end

@implementation AddClinicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"加入诊所";
    self.submitButton.layer.cornerRadius = 5;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)submit:(id)sender {
    if (self.textfield.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入邀请码"];
        return;
    }
    AddClinicReq *req = [[AddClinicReq alloc]init];
    req.code = self.textfield.text;
    [req  request:^(NSURLSessionDataTask *task, id responseObject) {
        [SVProgressHUD showSuccessWithStatus:@"加入成功"];

    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"加入失败"];

    }];
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
