//
//  LHCreatImageMessage.h
//  ForChat
//
//  Created by liuhang on 16/8/8.
//  Copyright © 2016年 刘航. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LHCreatImageMessage : NSObject
+(EMMessage *)createMessageWith:(NSString *)chatter data:(NSData *)data chatType:(EMChatType)type;
@end
