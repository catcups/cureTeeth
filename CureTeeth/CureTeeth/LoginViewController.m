//
//  LoginViewController.m
//  CureTeeth
//
//  Created by Denny on 16/7/14.
//  Copyright © 2016年 Denny. All rights reserved.
//

#import "LoginViewController.h"
#import "LoginReq.h"
#import "ForgetPasswordViewController.h"
@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *phoneText;
@property (weak, nonatomic) IBOutlet UITextField *pswText;
@property (weak, nonatomic) IBOutlet UIButton *logButton;

@property (weak, nonatomic) IBOutlet UIButton *checkButton; // 保持登录
@end

@implementation LoginViewController
- (void)viewWillAppear:(BOOL)animated {
    self.navigationController.navigationBarHidden = YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.logButton.layer.cornerRadius = 10;
//    self.phoneText.text = @"15189780989";
//    self.pswText.text = @"123456";
}
- (IBAction)seePswButton:(id)sender {
    if (self.pswText.text.length != 0) {
        self.pswText.secureTextEntry = !self.pswText.secureTextEntry;
    }
}
- (IBAction)onLogin:(UIButton *)sender { // 点击登录
    if (![self check]) {
        return;
    }
    LoginReq *req = [[LoginReq alloc]init];
    req.password = self.pswText.text;
    req.mobile = self.phoneText.text;
    [SVProgressHUD showWithStatus:@"正在登录"];
    [req request:^(NSURLSessionDataTask *task, id responseObject) {
        [SVProgressHUD dismiss];
        if (self.checkButton.selected) {
            [CommonTool storeUserDefaults:@"keepLogin" ForKey:KKeepLogin];
        }
        [CommonTool storeUserDefaults:responseObject[@"mobile"] ForKey:Kmobile];
        [CommonTool storeUserDefaults:responseObject[@"doctor_id"] ForKey:KDoctorId];
        [CommonTool storeUserDefaults:self.pswText.text ForKey:Kpassworld];
        if (self.iDelegate && [self.iDelegate respondsToSelector:@selector(TmpButtonAvtion)]) {
            [self.iDelegate TmpButtonAvtion];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}
- (IBAction)onForgetPsw:(id)sender {
    [self.navigationController pushViewController:[[ForgetPasswordViewController alloc]init] animated:YES];
}

- (BOOL)check {
    if (self.phoneText.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"帐号不能为空!"];
        return NO;
    }
    if (self.pswText.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"密码不能为空!"];
        return NO;
    }
    return YES;
}
- (IBAction)tapgesture:(id)sender {
    [self.view endEditing:YES];
}
- (IBAction)onCheck:(UIButton *)sender {
    sender.selected = !sender.selected;
}


@end
