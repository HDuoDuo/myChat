//
//  LHChatViewCell.h
//  ForChat
//
//  Created by liuhang on 16/8/9.
//  Copyright © 2016年 刘航. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LHChatViewCell : UITableViewCell
/** 消息模型 */
@property (nonatomic,strong) EMMessage * mes;

//***************cell******************//
/** contentView */
@property (nonatomic,readonly) UIImageView * bgView;
/** 文字label */
@property (nonatomic,readonly) UILabel * text;
/** 时间label */
@property (nonatomic,readonly) UILabel * timeLabel;
/** 头像imageVIew */
@property (nonatomic,readonly) UIButton * iconBtn;
/** 消息属于谁 */
@property (nonatomic,readonly) BOOL isMe;
//cell的高度
@property (nonatomic,readonly) CGFloat cellH;

@end
