//
//  ReserveViewController.m
//  CureTeeth
//
//  Created by Denny on 16/7/15.
//  Copyright © 2016年 Denny. All rights reserved.
//

#import "ReserveViewController.h"
#import "ReserveListTableViewCell.h"
#import "ReseverLIstReq.h"
#import "AllClinincModel.h"
#import "GetAllClinicReq.h"
#import "ReserveListModel.h"
#import "ChangeReseverStatusReq.h"
@interface ReserveViewController ()<UITableViewDelegate,UITableViewDataSource,ReserveListTableViewCellDelegate,CustomPickerViewDelegate,UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UIButton *unButton;
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (nonatomic,strong)NSMutableArray *dataSource;
@property (nonatomic,strong)CustomPickerView *allClinicPicker;
@property (nonatomic,strong)NSMutableDictionary *dataDic;
@property (weak, nonatomic) IBOutlet UIButton *topButton;
@property (nonatomic,strong)NodataView *noDataView;
@property (nonatomic,assign)CGFloat page;
@property (nonatomic,strong)NSString *clinicName;
@property (nonatomic,strong)UIAlertView *agreeAlert;
@property (nonatomic,strong)UIAlertView *rejectAlert;
@property (nonatomic,strong)ReserveListModel *reseverModel;
@property(nonatomic,strong)NSString *operation;

@end

@implementation ReserveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"预约列表";
    self.page = 0;
    self.clinicName = @"allAppointment";
    [self getdataSourceWithClinicName:self.clinicName];
    self.tableview.tableFooterView = [[UIView alloc]init];
    self.topButton.userInteractionEnabled = NO;
    self.topButton.layer.cornerRadius =self.unButton.layer.cornerRadius= 5.;
    self.topButton.layer.borderColor =self.unButton.layer.borderColor= KGrayColor.CGColor;
    self.topButton.layer.borderWidth=self.unButton.layer.borderWidth = 0.5;
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.dataDic = [NSMutableDictionary dictionary];
    GetAllClinicReq *req = [[GetAllClinicReq alloc]init];
    [req request:^(NSURLSessionDataTask *task, id responseObject) {
        self.topButton.userInteractionEnabled = YES;
        NSMutableArray *array = [NSMutableArray array];
        for (AllClinincModel *model in responseObject) {
            [array addObject:model.name];
            [self.dataDic setObject:model.clinincId forKey:model.name];
        }
        [self.dataDic setObject:@"allAppointment" forKey:@"所有预约"];
        [array insertObject:@"所有预约" atIndex:0];
        self.allClinicPicker.options = array;
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        self.topButton.userInteractionEnabled = NO;
    }];
    self.tableview.mj_header =  [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self getdataSourceWithClinicName:self.clinicName];
    }];
    self.tableview.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [self loadMoreDataFromNet];
    }];
}
-(void)backAction {
    [[NSNotificationCenter defaultCenter]postNotificationName:KRELOADMAINVIEW object:nil];
    [self.navigationController popViewControllerAnimated:YES];
}
-(NodataView*)noDataView {
    if (!_noDataView) {
        _noDataView = [[NodataView alloc]initWithFrame:self.tableview.frame];
        [self.view addSubview:_noDataView];
    }
    return _noDataView;
}
-(CustomPickerView *)allClinicPicker {
    if (!_allClinicPicker) {
        _allClinicPicker = [[CustomPickerView alloc] initWithDelegate:self];
    }
    return _allClinicPicker;
}
- (void)getdataSourceWithClinicName:(NSString *)clinicName{
    [SVProgressHUD show];
    ReseverLIstReq *req = [[ReseverLIstReq alloc]init];
    req.clinicName = clinicName;
    req.start = [NSNumber numberWithInteger:0];
    req.count = [NSNumber numberWithInteger:10];
    [req request:^(NSURLSessionDataTask *task, id responseObject) {
        [SVProgressHUD dismiss];
        self.dataSource = [NSMutableArray arrayWithArray:responseObject];
        if (self.dataSource.count == 0) {
            self.noDataView.hidden = NO;
        }else{
            self.noDataView.hidden = YES;
        }
        [self.tableview reloadData];
        [self.tableview.mj_header endRefreshing];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        self.noDataView.hidden = NO;
        [SVProgressHUD dismiss];
        [self.tableview.mj_header endRefreshing];
    }];
}

- (void)loadMoreDataFromNet {
    ReseverLIstReq *req = [[ReseverLIstReq alloc]init];
    req.clinicName = self.clinicName;
    req.start = [NSNumber numberWithInteger:++self.page];
    req.count = [NSNumber numberWithInteger:10];
    [req request:^(NSURLSessionDataTask *task, id responseObject) {
        [self.dataSource addObjectsFromArray:responseObject];
        if (self.dataSource.count == 0) {
            self.noDataView.hidden = NO;
        }else{
          self.noDataView.hidden = YES;
        }
        [self.tableview.mj_footer endRefreshing];
        [self.tableview reloadData];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        self.noDataView.hidden = NO;
        [self.tableview.mj_footer endRefreshing];
    }];

}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
   return  self.dataSource.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ReserveListModel *model = self.dataSource[indexPath.row];
    ReserveListTableViewCell *cell = [[[NSBundle mainBundle]loadNibNamed:@"ReserveListTableViewCell" owner:nil options:nil] lastObject];
    model.indexPathRow = indexPath.row;
    cell.model = model;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.delegate = self;
    return cell;
    
}
- (IBAction)topButton:(id)sender {
    [_allClinicPicker show];
}
//拒绝
-(void)ReserveListTableViewCellDelegateRightButton:(ReserveListTableViewCell *)cell model:(ReserveListModel *)model{
    self.rejectAlert = [[UIAlertView alloc]initWithTitle:nil message:@"是否确定要拒绝此预约" delegate:self cancelButtonTitle:@"否" otherButtonTitles:@"是", nil];
    [self.rejectAlert show];
    self.reseverModel = model;
}


-(void)reloaTableviewWithModel:(ReserveListModel *)model orderStatus:(NSString *)orderStatus{
    model.orderStatus = orderStatus;
    [self.dataSource replaceObjectAtIndex:model.indexPathRow withObject:model];
    [self.tableview reloadData];
    
}
//同意
-(void)ReserveListTableViewCellDelegateLeftButton:(ReserveListTableViewCell *)cell model:(ReserveListModel *)model {
    self.agreeAlert = [[UIAlertView alloc]initWithTitle:nil message:@"是否关闭此预约时段" delegate:self cancelButtonTitle:@"否" otherButtonTitles:@"是", nil];
    [self.agreeAlert show];
    self.reseverModel = model;
}

- (void)setPickerDoneCallback:(NSInteger)index PickerView:(CustomPickerView *)pickerView {
    self.clinicName = pickerView.options[index];
    [self.topButton setTitle:pickerView.options[index] forState:UIControlStateNormal];
    [self getdataSourceWithClinicName:[self.dataDic objectForKey:pickerView.options[index]]];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if ([alertView isEqual:self.agreeAlert]) {
        ChangeReseverStatusReq *req = [[ChangeReseverStatusReq alloc]init];
        req.clinicId = self.reseverModel.clinicId;
        req.timeslot = self.reseverModel.timeslot;
        req.doctorId = self.reseverModel.doctorId;
        req.targetDate =self.reseverModel.targetDate;
        if (buttonIndex != alertView.cancelButtonIndex) {
            req.operation = @"1";
        }else {
            req.operation = @"2";
        }
        req.holdTime =self.reseverModel.holdTime;
        req.orderId=  self.reseverModel.orderId;
        [SVProgressHUD show];
        [req request:^(NSURLSessionDataTask *task, id responseObject) {
            [self reloaTableviewWithModel:self.reseverModel orderStatus:@"2"];
            [SVProgressHUD showSuccessWithStatus:@"修改成功!"];
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            [SVProgressHUD showSuccessWithStatus:@"修改失败!"];
        }];
    }else if ([alertView isEqual:self.rejectAlert]){
        if (buttonIndex != alertView.cancelButtonIndex) {
            ChangeReseverStatusReq *req = [[ChangeReseverStatusReq alloc]init];
            req.clinicId = self.reseverModel.clinicId;
            req.timeslot = self.reseverModel.timeslot;
            req.doctorId = self.reseverModel.doctorId;
            req.targetDate =self.reseverModel.targetDate;
            req.operation = @"0";
            req.holdTime =self.reseverModel.holdTime;
            req.orderId=  self.reseverModel.orderId;
            [SVProgressHUD show];
            [req request:^(NSURLSessionDataTask *task, id responseObject) {
                [self reloaTableviewWithModel:self.reseverModel orderStatus:@"3"];
                [SVProgressHUD showSuccessWithStatus:@"修改成功!"];
            } failure:^(NSURLSessionDataTask *task, NSError *error) {
                [SVProgressHUD showSuccessWithStatus:@"修改失败!"];
            }];
        }
    }
}
@end
