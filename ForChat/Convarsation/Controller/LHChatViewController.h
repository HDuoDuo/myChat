//
//  LHChatViewController.h
//  ForChat
//
//  Created by liuhang on 16/8/6.
//  Copyright © 2016年 刘航. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LHChatViewController : UIViewController
//好友名
@property (nonatomic,copy)NSString * chatter;
//会话类型
@property (nonatomic,assign)EMConversationType consarvasionType;
//判断是否执行动画
@property (nonatomic,assign)BOOL isAnnimation;
//创建聊天室单例
+ (instancetype)shareInstance;
@end
