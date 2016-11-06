//
//  LHCreatWordMessage.m
//  ForChat
//
//  Created by liuhang on 16/8/8.
//  Copyright © 2016年 刘航. All rights reserved.
//

#import "LHCreatWordMessage.h"

@implementation LHCreatWordMessage

+ (EMMessage *)createMessageWith:(NSString *)chatter text:(NSString *)text chatType:(EMChatType)type
{
    EMTextMessageBody *body = [[EMTextMessageBody alloc] initWithText:text];
    NSString *from = [[EMClient sharedClient] currentUsername];
    NSLog(@"%@",from);
    //生成Message
    EMMessage *message = [[EMMessage alloc] initWithConversationID:chatter from:from to:chatter body:body ext:nil];
    message.chatType = type;
    return message;
}
@end
