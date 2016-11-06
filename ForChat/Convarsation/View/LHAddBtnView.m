//
//  LHAddBtnView.m
//  ForChat
//
//  Created by liuhang on 16/8/7.
//  Copyright © 2016年 刘航. All rights reserved.
//

#import "LHAddBtnView.h"

@interface LHAddBtnView ()

@end
@implementation LHAddBtnView
+(instancetype)instanceis
{
    return [[NSBundle mainBundle]loadNibNamed:@"LHAddBtnView" owner:nil options:nil].firstObject;
}
- (void)awakeFromNib
{
    
}
- (IBAction)imgBtn:(UIButton *)sender {
}
- (IBAction)locationBtn:(UIButton *)sender {
}
- (IBAction)cameraBtn:(UIButton *)sender {
}
- (IBAction)phoneBtn:(UIButton *)sender {
}
- (IBAction)videoBtn:(UIButton *)sender {
}
- (IBAction)redBagBtn:(UIButton *)sender {
}

@end
