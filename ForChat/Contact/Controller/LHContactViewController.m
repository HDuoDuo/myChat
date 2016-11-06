//
//  LHContactViewController.m
//  ForChat
//
//  Created by liuhang on 16/8/5.
//  Copyright © 2016年 刘航. All rights reserved.
//

#import "LHContactViewController.h"
#import "LHContactCell.h"
#import "ChineseString.h"
#import "LHChatViewController.h"

static NSString * const contactCellID = @"ContactListCell";

@interface LHContactViewController ()<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate>
//搜索框
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
//联系人表格
@property (weak, nonatomic) IBOutlet UITableView *contactTableView;
//联系人数组
@property (nonatomic,strong) NSMutableArray * contactArray;
//sectionsTitle数组
@property (nonatomic,strong) NSMutableArray * sectionsTitleArray;
@end

@implementation LHContactViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getContacts];
    [self setupTableView];
    [self setupSearchBar];
}
//懒加载
- (NSMutableArray *)contactArray
{
    if (!_contactArray) {
        _contactArray = [[NSMutableArray alloc]init];
        //设置第一个section的数据
        NSArray * array = [NSArray arrayWithObjects:@"申请与通知",@"群组",@"聊天室列表", nil];
        [_contactArray addObject:array];
    }
    return _contactArray;
}
- (NSMutableArray *)sectionsTitleArray
{
    if (!_sectionsTitleArray) {
        _sectionsTitleArray = [[NSMutableArray alloc]init];
    }
    return _sectionsTitleArray;
}
//初始化searchBar
- (void)setupSearchBar
{
    self.searchBar.delegate = self;
}
//初始化tableView
- (void)setupTableView
{
    //注册tableVIew
    [self.contactTableView registerNib:[UINib nibWithNibName:@"LHContactCell" bundle:nil] forCellReuseIdentifier:contactCellID];
    
}
//获取好友
- (void)getContacts
{
   NSArray * array =  [[EMClient sharedClient].contactManager getContactsFromDB];
    //对数据进行处理分组
    //右侧数据
    self.sectionsTitleArray = [ChineseString IndexArray:array];
    //联系人数据
    NSMutableArray * mArray = [ChineseString LetterSortArray:array];
    //遍历添加到联系人数组中
    for (id arr in mArray) {
        [self.contactArray addObject:arr];
    }
    [self.contactTableView reloadData];
}

#pragma mark -- 实现searchBar的代理方法
//结束编辑时
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    NSLog(@"开始搜索");
    [searchBar resignFirstResponder];
}
#pragma mark -- 实现TableView的代理方法
/*
 **右侧栏
 */
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return self.sectionsTitleArray;
}
//返回每个索引的内容
//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
//{
//    if (section == 0) {
//        return 0;
//    }
//    NSString * key = self.sectionsTitleArray[section - 1];
//    return key;
//}
- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    return ++index;
}
/*
 **表格
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LHContactCell * cell = [tableView dequeueReusableCellWithIdentifier:contactCellID];
    //要使用的数据
    NSArray * arr = self.contactArray[indexPath.section];
    cell.ContactListLB.text = arr[indexPath.row];
    return cell;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.contactArray[section] count];
}
//当选中某个Cell时
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //获取到该单元的属性
   NSString * str = [self.contactArray[indexPath.section] objectAtIndex:indexPath.row];
    //获取到该用户的属性
    LHChatViewController * chatVC = [LHChatViewController shareInstance];
    chatVC.chatter = @"321";
    chatVC.consarvasionType = EMConversationTypeChat;
    chatVC.hidesBottomBarWhenPushed = YES;
    
    [self.navigationController pushViewController:chatVC animated:YES];
    
    
}
/*
 ** sectionsHeader
 */
//设置headerView
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    if (section == 0) {
        return 0;
    }else
    {
       UILabel * lab = [[UILabel alloc]init];
        lab.text = self.sectionsTitleArray[section - 1];
        return lab;
    }
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 0;
    }
    return 20;
}
//设置返回section的组数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.sectionsTitleArray.count + 1;
}
@end
