//
//  MainViewController.m
//  CureTeeth
//
//  Created by Denny on 16/7/14.
//  Copyright © 2016年 Denny. All rights reserved.
//

#import "MainViewController.h"
#import "ScanViewController.h"
#import "MainReq.h"
#import "DennyScrollView.h"
#import "ReserveViewController.h"
#import "AskListViewController.h"
#import "SchMangerViewController.h"
#import "MessageViewController.h"
@interface MainViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *headImage;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameText;
@property (weak, nonatomic) IBOutlet UILabel *label1;
@property (weak, nonatomic) IBOutlet UILabel *label2;
@property (weak, nonatomic) IBOutlet UILabel *label3;
@property (weak, nonatomic) IBOutlet UILabel *label4;
@property (weak, nonatomic) IBOutlet UILabel *bardge1;
@property (weak, nonatomic) IBOutlet UILabel *bardge2;
@property (weak, nonatomic) IBOutlet UIView *midView;
@property (weak, nonatomic) IBOutlet DennyScrollView *dennyScrollview;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *topView;

@end

@implementation MainViewController
- (id)init {
    if (self = [super init]) {
        self.title = @"工作台";
         self.tabBarItem = [[UITabBarItem alloc] initWithTitle:NSLocalizedString(@"工作台", nil) image:[UIImage imageNamed:@"desknol"] selectedImage:[[UIImage imageNamed:@"desksel"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    }
    return self;
}

- (void)viewWillLayoutSubviews {
    self.topView.backgroundColor = KMainColor;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    UIView *leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
    UIButton *leftbutton = [[UIButton alloc]initWithFrame:CGRectMake(-15, 0, 44, 44)];
    [leftbutton setImage:[UIImage imageNamed:@"qrcode"] forState:UIControlStateNormal];
    [leftView addSubview:leftbutton];
    [leftbutton addTarget:self action:@selector(onLeftBarButton) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftBarButton = [[UIBarButtonItem alloc]initWithCustomView:leftView];
    self.navigationItem.leftBarButtonItem = leftBarButton;
    
    UIView *righttView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
    UIButton *rtghtButton = [[UIButton alloc]initWithFrame:CGRectMake(15, 0, 44, 44)];
    [rtghtButton setImage:[UIImage imageNamed:@"bell"] forState:UIControlStateNormal];
    [rtghtButton addTarget:self action:@selector(onRightBarButton) forControlEvents:UIControlEventTouchUpInside];
    [righttView addSubview:rtghtButton];
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc]initWithCustomView:righttView];
    self.navigationItem.rightBarButtonItem = rightBarButton;
    self.bardge1.layer.masksToBounds = self.bardge2.layer.masksToBounds = self.headImage.layer.masksToBounds =  YES;
    self.bardge1.layer.cornerRadius = self.bardge2.layer.cornerRadius = 9;
    self.midView.layer.cornerRadius = 5;
    self.headImage.layer.cornerRadius = 45;
    [self getDataSource];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getDataSource) name:KRELOADMAINVIEW object:nil];
}

-(void)getDataSource {
    MainReq *req = [[MainReq alloc]init];
    req.doctorId = [CommonTool readUserDefaultsByKey:KDoctorId];
    [req request:^(NSURLSessionDataTask *task, id responseObject) {
        [self bindData:(NSMutableDictionary *)responseObject[@"data"][@"doctor"]];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
    }];

}
- (void)bindData:(NSMutableDictionary *)dic {
    self.label1.text = dic[@"totalappointmentNum"];
    self.label2.text = dic[@"totaladvisoryNum"];
    self.label3.text = dic[@"todayNum"];
    self.label4.text = dic[@"vipnum"];
    if ([dic[@"appointmentNum"] integerValue] != 0) {
        self.bardge1.text = dic[@"appointmentNum"];
    }else {
        self.bardge1.hidden = YES;
    }
    if ([dic[@"advisoryNum"] integerValue] != 0) {
        self.bardge2.text = dic[@"advisoryNum"];
    }else {
        self.bardge2.hidden = YES;
    }
    [self.headImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://www.yyaai.com/uploads/doctor/%@",dic[@"doctorDetail"][0][@"photo"]]]];
    NSData * imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://www.yyaai.com/uploads/doctor/%@",dic[@"doctorDetail"][0][@"photo"]]]];
//    UIImage *image = [UIImage imageWithData:imageData];
    [[NSUserDefaults standardUserDefaults]setObject:imageData forKey:KDoctorHeaderImage];
    self.nameText.text = dic[@"clinicname"];
    self.phoneLabel.text = dic[@"doctorDetail"][0][@"name"];
    NSMutableArray *iamgeArray = [NSMutableArray array];
    for (NSDictionary *dic1 in dic[@"img"]) {
        [iamgeArray addObject:[NSURL URLWithString:[NSString stringWithFormat:@"http://www.yyaai.com/uploads/%@",dic1[@"advpic"]]]];
    }
    NSInteger count =[dic[@"advisoryNum"] integerValue] + [dic[@"appointmentNum"] integerValue];
    if (count!=0) {
        [self.tabBarItem setBadgeValue:[NSString stringWithFormat:@"%zi",count]];
    }
    [self.dennyScrollview getDennyImageArray:iamgeArray];
//    [SVProgressHUD dismiss];
}
- (void)onRightBarButton {
    MessageViewController *message = [[MessageViewController alloc]init];
    message.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:message animated:YES];
}

- (void)onLeftBarButton {
    ScanViewController *scan = [[ScanViewController alloc] init];
    scan.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:scan animated:YES];
}

- (IBAction)toReserveList:(id)sender {
    ReserveViewController *resever = [[ReserveViewController alloc]init];
    resever.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:resever animated:YES];
}

- (IBAction)toAsk:(id)sender {
    AskListViewController *resever = [[AskListViewController alloc]init];
    resever.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:resever animated:YES];
}

- (IBAction)toSchManger:(UIButton *)sender {
    SchMangerViewController *sch = [[SchMangerViewController alloc]init];
    sch.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:sch animated:YES];

}

-(void)dealloc {
    self.scrollView.delegate = nil;
}
@end
