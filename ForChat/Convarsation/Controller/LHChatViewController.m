//
//  LHChatViewController.m
//  ForChat
//
//  Created by liuhang on 16/8/6.
//  Copyright © 2016年 刘航. All rights reserved.
//

#import "LHChatViewController.h"
#import "LHChatInput.h"
#import "LHChatViewCell.h"
static NSString * const cellID = @"CellID";

@interface LHChatViewController ()<UITableViewDataSource,UITableViewDelegate,EMChatManagerDelegate>
//输入view
@property (strong, nonatomic) LHChatInput *textPutView;
//会话
@property (nonatomic,strong)EMConversation * conversasion;
//tableVIew
@property (nonatomic,strong) UITableView * tableView;
//消息数组
@property (nonatomic,strong) NSMutableArray * dataArray;
//记录cell的高度
@property (nonatomic,assign)CGFloat CellHeight;
@end

@implementation LHChatViewController
//重写init方法获取chatter,conversationType
+ (instancetype)shareInstance
{
    static LHChatViewController * vc;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        vc = [[self alloc]init];
    });
    return vc;
}

//懒加载
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,64, self.view.frame.size.width, self.view.frame.size.height - navigationBarH - tabBarH)];
        //设置代理
        _tableView.delegate = self;
        _tableView.dataSource  = self;
        //注册
        [_tableView registerClass:[LHChatViewCell class] forCellReuseIdentifier:cellID];
        
    }
    return _tableView;
}
- (LHChatInput *)textPutView
{
    if (!_textPutView) {
        _textPutView = [LHChatInput instance];
        _textPutView.frame = CGRectMake(0, self.view.frame.size.height - tabBarH, self.view.frame.size.width, tabBarH);
    }
    return _textPutView;
}
- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        
        //获取消息
        NSArray * array = [self.conversasion loadMoreMessagesFromId:nil limit:10 direction:EMMessageSearchDirectionUp];
        NSLog(@"取到的消息条数%ld",[array count]);
        _dataArray = [[NSMutableArray alloc]initWithArray:array];
    }
    return _dataArray;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    //创建会话
    self.conversasion = [[EMClient sharedClient].chatManager getConversation:self.chatter type:self.consarvasionType createIfNotExist:YES];
    //消息回调:EMChatManagerChatDelegate
    //注册消息回调
    [[EMClient sharedClient].chatManager addDelegate:self delegateQueue:nil];
    //初始化输入栏View
    [self setupInputView];
}


////初始化输入栏View
- (void)setupInputView
{
    //添加
    [self.view addSubview:self.textPutView];
    [self.view addSubview:self.tableView];
    //注册键盘观察者
    self.isAnnimation = YES;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWilldo:) name:UIKeyboardWillChangeFrameNotification object:nil];
}
- (void)keyBoardWilldo:(NSNotification *)info
{
    if (self.isAnnimation) {
        //获取键盘位置改变时间
        NSInteger dur = [info.userInfo[@"UIKeyboardAnimationDurationUserInfoKey"] integerValue];
        //获取键盘弹出后的位置
        CGRect rect = [info.userInfo[@"UIKeyboardFrameEndUserInfoKey"] CGRectValue];
        CGFloat viewY = rect.origin.y - screenH;
        //输入框要在的位置
        CGRect rec = CGRectMake(self.view.frame.origin.x,viewY,self.view.frame.size.width,self.view.frame.size.height);
        self.view.frame = rec;
        [UIView animateWithDuration:dur animations:^{
            //刷新UI
            [self.view setNeedsLayout];
        }];
    }
}


//从服务器获取到了消息获取到了消息
- (void)didReceiveMessages:(NSArray *)aMessages
{
    [self.dataArray addObjectsFromArray:aMessages];
    [self.tableView reloadData];
    //保存消息
    for (EMMessage * mes in aMessages) {
        [[EMClient sharedClient].chatManager updateMessage:mes];
    }
}



#pragma mark -- tableView代理方法
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LHChatViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    if (!cell) {
        cell = [[LHChatViewCell alloc]init];
    }
    EMMessage * mes = self.dataArray[indexPath.row];
    cell.mes = mes;
    self.CellHeight = cell.cellH;
    return cell;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"%ld",self.dataArray.count);
    return self.dataArray.count;
}
//设置cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%lf",self.CellHeight);
    if (self.CellHeight < 60) {
        return 80;
    }
    return  self.CellHeight + 10;
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
       [[NSNotificationCenter defaultCenter] postNotificationName:@"keyBoard" object:nil];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    //在界面将要消失时移除第一响应者,不然在编辑状态突然pop移除视图时键盘会突然消失,影响视觉效果
    [[NSNotificationCenter defaultCenter] postNotificationName:@"keyBoard" object:nil];
}
-(void)dealloc
{
    //移除消息回调
    [[EMClient sharedClient].chatManager removeDelegate:self];
}
@end
