//
//  AskListViewController.m
//  CureTeeth
//
//  Created by Denny on 16/7/15.
//  Copyright © 2016年 Denny. All rights reserved.
//

#import "AskListViewController.h"
#import "GetAllClinicReq.h"
#import "AskListReq.h"
#import "AskListModel.h"
#import "AskListTableViewCell.h"
#import "AllClinincModel.h"
#import "ChatViewController.h"
#import "KxMenu.h"
@interface AskListViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UIButton *button1;
@property (weak, nonatomic) IBOutlet UIButton *button2;
@property (weak, nonatomic) IBOutlet UIButton *button3;
@property (nonatomic,strong)NSMutableArray *dataSource;
@property (nonatomic,strong)NSMutableDictionary *dataDic;
@property(nonatomic,strong)NSMutableArray *titlrArray;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic,strong)NSString *string1;
@property(nonatomic,strong)NSString *string2;
@property(nonatomic,strong)NSString *string3;
@property (nonatomic,strong)NodataView *noDataView;

@end

@implementation AskListViewController
-(NodataView*)noDataView {
    if (!_noDataView) {
        _noDataView = [[NodataView alloc]initWithFrame:self.tableView.frame];
        [self.view addSubview:_noDataView];
    }
    return _noDataView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"咨询列表";
    self.tableView.tableFooterView = [[UIView alloc]init];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.titlrArray = [NSMutableArray array];
    self.dataDic = [NSMutableDictionary dictionary];
    self.button1.userInteractionEnabled = NO;
    self.string1 = @"allAdvisory";
    self.string2 = @"allAdvisory";
    self.string3 = @"allAdvisoryByState";
    [self getdataSourceWithclinicId:self.string1 time:self.string2 status:self.string3];
    GetAllClinicReq *req = [[GetAllClinicReq alloc]init];
    [req request:^(NSURLSessionDataTask *task, id responseObject) {
        self.button1.userInteractionEnabled = YES;
        for (AllClinincModel *model in responseObject) {
            [self.titlrArray addObject:model.name];
            [self.dataDic setObject:model.clinincId forKey:model.name];
        }
        [self.titlrArray insertObject:@"所有咨询" atIndex:0];
        [self.dataDic setObject:@"allAdvisory" forKey:@"所有咨询"];

    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        self.button1.userInteractionEnabled = NO;
    }];
}

-(void)getdataSourceWithclinicId:(NSString *)clinicId time:(NSString *)orderByTime status:(NSString *)orderByStatus {
    [SVProgressHUD show];
    AskListReq *req = [[AskListReq alloc]init];
    req.start = [NSNumber numberWithInteger:0];
    req.count = [NSNumber numberWithInteger:10];
    req.clinicId = clinicId;
    req.orderByTime = orderByTime;
    req.orderByStatus = orderByStatus;
    [req request:^(NSURLSessionDataTask *task, id responseObject) {
        [SVProgressHUD dismiss];
        self.dataSource = [NSMutableArray arrayWithArray:responseObject];
        if (self.dataSource.count == 0) {
            self.noDataView.hidden = NO;
        }else{
            self.noDataView.hidden = YES;
        }
        [self.tableView reloadData];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        self.noDataView.hidden = NO;
    }];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AskListModel*model = self.dataSource[indexPath.row];
    AskListTableViewCell *cell = [[[NSBundle mainBundle]loadNibNamed:@"AskListTableViewCell" owner:nil options:nil] lastObject];
    cell.model = model;
    return cell;
}
- (IBAction)leftButton:(UIButton *)sender {
    NSMutableArray *menuItems = [NSMutableArray array];
    for (int i = 0 ;i <self.titlrArray.count ; i ++) {
        [menuItems addObject:[KxMenuItem menuItem:self.titlrArray[i]
                                            image:nil
                                           target:self
                                           action:@selector(pushMenuItem1:)]];
    }
    [KxMenu setTintColor:KMainColor];
    [KxMenu showMenuInView:self.view
                  fromRect:sender.frame
                 menuItems:menuItems];

}
- (IBAction)midButton:(UIButton *)sender {
    NSArray *array =@[@"所有咨询",@"最新咨询",@"历史咨询"];
    NSMutableArray *menuItems = [NSMutableArray array];
    for (int i = 0 ;i <array.count ; i ++) {
        [menuItems addObject:[KxMenuItem menuItem:array[i]
                                            image:nil
                                           target:self
                                           action:@selector(pushMenuItem2:)]];
    }
    [KxMenu setTintColor:KMainColor];
    [KxMenu showMenuInView:self.view
                  fromRect:sender.frame
                 menuItems:menuItems];
}
- (IBAction)rightButton:(UIButton *)sender {
    NSArray *array =@[@"咨询状况",@"已处理咨询",@"未处理咨询"];
    NSMutableArray *menuItems = [NSMutableArray array];
    for (int i = 0 ;i <array.count ; i ++) {
        [menuItems addObject:[KxMenuItem menuItem:array[i]
                                            image:nil
                                           target:self
                                           action:@selector(pushMenuItem3:)]];
    }
    [KxMenu setTintColor:KMainColor];
    [KxMenu showMenuInView:self.view
                  fromRect:sender.frame
                 menuItems:menuItems];
}
- (void)pushMenuItem1:(KxMenuItem *)sender {
    self.string1 = [self.dataDic objectForKey:sender.title];
    [self getdataSourceWithclinicId:self.string1 time:self.string2 status:self.string3];
    [self.button1 setTitle:sender.title forState:UIControlStateNormal];
}

- (void)pushMenuItem2:(KxMenuItem *)sender {
    [self.button2 setTitle:sender.title forState:UIControlStateNormal];
    if ([sender.title isEqualToString:@"所有咨询"]) {
        self.string2 = @"allAdvisory";
    }
    if ([sender.title isEqualToString:@"最新咨询"]) {
        self.string2 = @"newAdv";
    }
    if ([sender.title isEqualToString:@"历史咨询"]) {
        self.string2 = @"ordAdv";
    }
    [self getdataSourceWithclinicId:self.string1 time:self.string2 status:self.string3];
}

- (void)pushMenuItem3:(KxMenuItem *)sender {
    [self.button3 setTitle:sender.title forState:UIControlStateNormal];
    if ([sender.title isEqualToString:@"咨询状况"]) {
        self.string3 = @"allAdvisoryByState";
    }
    if ([sender.title isEqualToString:@"已处理咨询"]) {
        self.string3 = @"trAdvisory";
    }
    if ([sender.title isEqualToString:@"未处理咨询"]) {
        self.string3 = @"unAdvisory";
    }
    [self getdataSourceWithclinicId:self.string1 time:self.string2 status:self.string3];
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    AskListModel*model = self.dataSource[indexPath.row];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    ChatViewController *chat = [[ChatViewController alloc]init];
    chat.advisoryId = model.askId;
    [self.navigationController pushViewController:chat animated:YES];
}

-(void)backAction {
    [[NSNotificationCenter defaultCenter]postNotificationName:KRELOADMAINVIEW object:nil];
    [self.navigationController popViewControllerAnimated:YES];
}
@end
