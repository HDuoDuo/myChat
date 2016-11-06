//
//  LHCreatVoiceMessage.h
//  ForChat
//
//  Created by liuhang on 16/8/8.
//  Copyright © 2016年 刘航. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LHCreatVoiceMessage : NSObject
+(EMMessage *)createMessageWith:(NSString *)chatter Path:(NSString *)path duration:(int)duration chatType:(EMChatType)type;
@end
