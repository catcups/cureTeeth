//
//  ChatViewController.m
//  CureTeeth
//
//  Created by Denny on 16/7/16.
//  Copyright © 2016年 Denny. All rights reserved.
//

#import "ChatViewController.h"
#import <SRWebSocket.h>
#import "ChatListReq.h"
#import "ReplyReq.h"

@interface ChatViewController ()<SRWebSocketDelegate>
@property (nonatomic,strong)SRWebSocket *webSocket;
@property (nonatomic,strong)NSString *toId;
@property (nonatomic,strong)NSString *type;
@end

@implementation ChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(reConnectWebSocket) name:@"KPostNamereconnectWebsocket" object:nil];
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH-45-64) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//    _tableView.contentOffset = CGPointMake(CGFLOAT_MAX, CGFLOAT_MAX);
    [self.view addSubview:_tableView];
    [self createBttomView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardFrameChanged:) name:UIKeyboardWillChangeFrameNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textViewDidChangeText:) name:UITextViewTextDidChangeNotification object:self.textView];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];    // Do any additional setup after loading the view from its nib.
    [self connectWebSocket];
    ChatListReq *req = [[ChatListReq alloc]init];
    [SVProgressHUD show];
    req.advisoryId = self.advisoryId;
    [req request:^(NSURLSessionDataTask *task, id responseObject) {
        [SVProgressHUD dismiss];
        CGFloat contentOffSet = 0.;
        for (Message *message in responseObject) {
            contentOffSet += (message.frame.size.height + 96);
            if (!message.isSelf) {
                self.toId = message.customerId;
                self.title = message.cname;
            }
        }
        if(contentOffSet > 500){
            [_tableView setContentOffset:CGPointMake(0, contentOffSet) animated:YES];
        }
        self.currentContentOffsetY = contentOffSet;
        _DataArray = [NSMutableArray arrayWithArray:responseObject];
        [_tableView reloadData];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        ;
    }];
}

#pragma mark -----------UI
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _DataArray.count;
}

-(void)createBttomView {
    _toobarView = [[UIView alloc]initWithFrame:CGRectMake(0,kScreenH-45-64, kScreenW, 45)];
    _toobarView.backgroundColor = [UIColor whiteColor];
    _toobarView.layer.borderWidth = 0.5;
    _toobarView.layer.borderColor = [UIColor grayColor].CGColor;
    [self.view addSubview:_toobarView];
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn1 setImage:[UIImage imageNamed:@"calendar"] forState:UIControlStateNormal];
    [btn1 setImage:[UIImage imageNamed:@"calendar"] forState:UIControlStateHighlighted];
    btn1.frame = CGRectMake(5, 5, 35, 35);
    [btn1 addTarget:self action:@selector(btn1Aciton) forControlEvents:UIControlEventTouchUpInside];
    [_toobarView addSubview:btn1];
    self.textView = [[MSPlaceHolderTextView alloc] initWithFrame:CGRectMake(47, 6, kScreenW - 47 - 65, 33)];
    self.textView.backgroundColor = [UIColor whiteColor];
    self.textView.layer.borderWidth = 0.5;
    self.textView.layer.borderColor = [UIColor colorWithWhite:0.8 alpha:1].CGColor;
    self.textView.layer.cornerRadius = 5.0f;
    self.textView.font = [UIFont systemFontOfSize:15];
    self.textView.textColor = [UIColor grayColor];
    self.textView.tintColor = KMainColor;
    self.textView.alwaysBounceVertical = NO;
    self.textView.textContainerInset = UIEdgeInsetsMake(5, 2, 4, 2);
    self.textView.contentInset = UIEdgeInsetsMake(4, 0, 4, 0);
    self.textView.delegate = self;
    [_toobarView addSubview:self.textView];
    self.btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.btn2 setTitle:@"回复" forState:UIControlStateNormal];
    self.btn2.layer.cornerRadius = 5;
    self.btn2.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.btn2 addTarget:self action:@selector(onBtn2) forControlEvents:UIControlEventTouchUpInside];
    [self.btn2 setTitleColor:[UIColor whiteColor]forState:UIControlStateNormal];
    [self.btn2 setBackgroundColor:KMainColor];
    self.btn2.frame = CGRectMake(kScreenW-60, 5, 50, 35);
    [_toobarView addSubview:self.btn2];
}

-(void)btn1Aciton {
    self.type = @"1";
    [self handMessageContent];
}
-(void)onBtn2{
    self.type = @"0";

    [self handMessageContent];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MessageCell *cell = [[MessageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    Message *message =_DataArray[indexPath.row];
    cell.message = message;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    Message *message = _DataArray[indexPath.row];
    if (message.isSelf) {
        message.content = message.message;
    }else {
        message.content = message.content;
    }
    CGFloat height = message.frame.size.height;
    return height +55 + 30;
}
- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {

    self.oldContentOffsetY = targetContentOffset->y;
    [self.textView resignFirstResponder];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    self.type = @"0";
   return [self handMessageContent];
}

-(void)keyboardWillShow:(NSNotification *)obj {
    NSDictionary* userInfo = [obj userInfo];
    CGRect keyboardRect = [[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    keyboardRect = [self.view convertRect:keyboardRect fromView:self.view.superview];
    if (_tableView.contentSize.height >  CGRectGetHeight(_tableView.frame) - keyboardRect.size.height) {
        CGFloat tmpOffSetY = _tableView.contentSize.height - CGRectGetHeight(_tableView.frame) + keyboardRect.size.height ;
        [UIView animateWithDuration:0.2 animations:^{
            _tableView.contentOffset = CGPointMake(0, tmpOffSetY);
            self.currentContentOffsetY = tmpOffSetY;
        }];
    }
}


- (void)keyboardWillHide:(NSNotification *)obj {
    if(_tableView.contentSize.height > self.view.bounds.size.height){
        _tableView.contentOffset = CGPointMake(0, _tableView.contentSize.height - _tableView.frame.size.height);
        self.currentContentOffsetY = _tableView.contentSize.height - _tableView.frame.size.height;
    }
    if(_tableView.contentSize.height <= self.view.bounds.size.height){
        _tableView.contentOffset = CGPointMake(0, self.oldContentOffsetY);
        self.currentContentOffsetY = self.oldContentOffsetY;
    }
}


- (void)keyboardFrameChanged:(NSNotification *)noti
{
    CGRect keyboardFrame = [[noti.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat keyboardHeight = [UIScreen mainScreen].bounds.size.height - keyboardFrame.origin.y;
    [self keyboardWillChangeToHeight:@(keyboardHeight)];
}

- (void)textViewDidChangeText:(NSNotification *)noti{
//    [_toobarView textDidChanged];
    self.btn2.enabled = self.textView.text.length > 0 && ![self isBlankString:self.textView.text];
}

- (BOOL) isBlankString:(NSString *)string {
    if (string == nil || string == NULL) {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return YES;
    }
    return NO;
}

- (void)keyboardWillChangeToHeight:(NSNumber *)height {
    CGFloat keyboardHeight = [height floatValue];
    __block CGRect inputViewFrame = _toobarView.frame;
    inputViewFrame.origin.y = self.view.frame.size.height - keyboardHeight - _toobarView.frame.size.height;
    self.keyboardHeight = keyboardHeight;
    _toobarView.frame = inputViewFrame;
}
- (BOOL)handMessageContent{
    self.textView.text = [self.textView.text stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    self.textView.text = [self.textView.text stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    self.textView.text = [self.textView.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    if (self.textView.text.length == 0 && ![self.type isEqualToString:@"1"]) {
        return NO;
    }
    ReplyReq *req = [[ReplyReq alloc]init];
    req.toId = self.toId;
    req.fromId = [CommonTool readUserDefaultsByKey:KDoctorId];
    req.advisoryId = self.advisoryId;
    req.type = self.type;
    if ([self.type isEqualToString:@"1"]) {
         req.message = @"点击图片进行预约";
    }else{
        req.message = self.textView.text;
    }
    NSDictionary *dic = [NSMutableDictionary dictionary];
    [dic setValue:req.message forKey:@"message"];
    [dic setValue:self.toId forKey:@"to_id"];
    [dic setValue:[CommonTool readUserDefaultsByKey:KDoctorId] forKey:@"from_id"];
    [dic setValue:self.type forKey:@"type"];
    [dic setValue:self.advisoryId forKey:@"advisory_id"];
    [req request:^(NSURLSessionDataTask *task, id responseObject) {
        if(self.webSocket.readyState == SR_CONNECTING){
            [self.webSocket send:[self DataTOjsonString:dic]];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        ;
    }];
    Message *message1 = [[Message alloc]init];
    message1.toId = self.toId;
    message1.fromId = [CommonTool readUserDefaultsByKey:KDoctorId];
    message1.isSelf = YES;
    message1.type = self.type;
    message1.chatTime = [StringUtils timeChange:[StringUtils getCurrentSpTime]];
    message1.advisoryId = self.advisoryId;
    message1.message = self.textView.text;
    [_DataArray addObject:message1];
    [_tableView reloadData];
    self.textView.text = @"";
    CGFloat height = message1.frame.size.height + 55 + 30;
    [UIView animateWithDuration:0.15 animations:^{
        [_tableView setContentOffset:CGPointMake(0, self.currentContentOffsetY +height )];
    }completion:^(BOOL finished) {
        self.currentContentOffsetY = self.currentContentOffsetY + height;
    }];
    return YES;
}
#pragma mark - 单机窗口键盘隐藏
//说明：其实是选中到单元格了
- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //直接调用隐藏键盘的方法即可
    [self.textView resignFirstResponder];
}

#pragma mark - 滑动窗口时，键盘隐藏
- (void) scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    //直接调用隐藏键盘的方法即可
    [self.textView resignFirstResponder];
}

#pragma mark -------------SRWebSocket
- (void)connectWebSocket {
    self.webSocket.delegate = nil;
    [self.webSocket close];
    NSString *urlString = @"http://www.msduorourou.com:9502";
    self.webSocket = [[SRWebSocket alloc] initWithURL:[NSURL URLWithString:urlString]];
    self.webSocket .delegate = self;
    [self.webSocket open];
    [self webSocketDidOpen:self.webSocket];
}

- (void)webSocketDidOpen:(SRWebSocket *)newWebSocket {
//    NSDictionary *dic = [NSMutableDictionary dictionary];
//    [dic setValue:@"23"forKey:@"message"];
//    [dic setValue:self.toId forKey:@"to_id"];
//    [dic setValue:[CommonTool readUserDefaultsByKey:KDoctorId] forKey:@"from_id"];
//    [dic setValue:self.type forKey:@"type"];
//    [dic setValue:self.advisoryId forKey:@"advisory_id"];
//    [self.webSocket send:[self DataTOjsonString:dic]];
//    [newWebSocket send:[NSString stringWithFormat:@"Hello from %@", [UIDevice currentDevice].name]];

}
- (void)webSocket:(SRWebSocket *)webSocket didCloseWithCode:(NSInteger)code reason:(NSString *)reason wasClean:(BOOL)wasClean {
    NSLog(@"Websocket Closed: %li, %@, %i", (long)code, reason, wasClean);
}
- (void)webSocket:(SRWebSocket *)webSocket didFailWithError:(NSError *)error {
    [self connectWebSocket];
}

//- (void)webSocket:(SRWebSocket *)webSocket didCloseWithCode:(NSInteger)code reason:(NSString *)reason wasClean:(BOOL)wasClean {
//    [self connectWebSocket];
//}

- (void)webSocket:(SRWebSocket *)webSocket didReceiveMessage:(id)message {
    //    self.messagesTextView.text = [NSString stringWithFormat:@"%@\n%@", self.messagesTextView.text, message];
}

-(NSString*)DataTOjsonString:(id)object
{
    NSString *jsonString = nil;
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:object
                                                       options:NSJSONWritingPrettyPrinted // Pass 0 if you don't care about the readability of the generated string
                                                         error:&error];
    if (! jsonData) {
        NSLog(@"Got an error: %@", error);
    } else {
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    return jsonString;
}
-(void)reConnectWebSocket {
    [self.webSocket open];
    [self webSocketDidOpen:self.webSocket];
}
@end
