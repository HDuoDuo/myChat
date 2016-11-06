//
//  LHCreatVoiceMessage.m
//  ForChat
//
//  Created by liuhang on 16/8/8.
//  Copyright © 2016年 刘航. All rights reserved.
//

#import "LHCreatVoiceMessage.h"

@implementation LHCreatVoiceMessage
+(EMMessage *)createMessageWith:(NSString *)chatter Path:(NSString *)path duration:(int)duration chatType:(EMChatType)type
{
    EMVoiceMessageBody *body = [[EMVoiceMessageBody alloc] initWithLocalPath:path displayName:nil];
    body.duration = duration;
    NSString *from = [[EMClient sharedClient] currentUsername];
    
    // 生成message
    EMMessage *message = [[EMMessage alloc] initWithConversationID:chatter from:from to:chatter body:body ext:nil];
    message.chatType = type;
    return message;
    
}
@end
