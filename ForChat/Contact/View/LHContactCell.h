//
//  LHContactCell.h
//  ForChat
//
//  Created by liuhang on 16/8/5.
//  Copyright © 2016年 刘航. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LHContactCell : UITableViewCell
//联系人列表label
@property (weak, nonatomic) IBOutlet UILabel *ContactListLB;
//联系人头像
@property (weak, nonatomic) IBOutlet UIImageView *contactListImg;
@end
