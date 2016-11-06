//
//  LHCreatWordMessage.h
//  ForChat
//
//  Created by liuhang on 16/8/8.
//  Copyright © 2016年 刘航. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LHCreatWordMessage : NSObject
+ (EMMessage *)createMessageWith:(NSString *)chatter text:(NSString *)text chatType:(EMChatType)type;
@end
