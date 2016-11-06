//
//  LHCreatImageMessage.m
//  ForChat
//
//  Created by liuhang on 16/8/8.
//  Copyright © 2016年 刘航. All rights reserved.
//

#import "LHCreatImageMessage.h"

@implementation LHCreatImageMessage
+(EMMessage *)createMessageWith:(NSString *)chatter data:(NSData *)data chatType:(EMChatType)type
{
    EMImageMessageBody *body = [[EMImageMessageBody alloc] initWithData:data displayName:nil];
    NSString *from = [[EMClient sharedClient] currentUsername];
    
    //生成Message
    EMMessage *message = [[EMMessage alloc] initWithConversationID:chatter from:from to:chatter body:body ext:nil];
    message.chatType = type;// 设置为单聊消息
    //message.chatType = EMChatTypeGroupChat;// 设置为群聊消息
    //message.chatType = EMChatTypeChatRoom;// 设置为聊天室消息
    return message;
}
@end
