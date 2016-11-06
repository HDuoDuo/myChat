//
//  NSString+LHTimeSwitch.m
//  ForChat
//
//  Created by liuhang on 16/8/9.
//  Copyright © 2016年 刘航. All rights reserved.
//

#import "NSString+LHTimeSwitch.h"

@implementation NSString (LHTimeSwitch)
+ (NSString *)switchTime:(long long)time
{
    NSDate * date = [[NSDate alloc]initWithTimeIntervalSince1970:time];
    NSDateFormatter * formatter = [[NSDateFormatter alloc]init];
    formatter.dateFormat = [NSString stringWithFormat:@"MM月dd日 HH:MM"];
    return [formatter stringFromDate:date];
}
@end
