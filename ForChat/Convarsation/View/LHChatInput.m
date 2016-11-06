//
//  LHChatInput.m
//  ForChat
//
//  Created by liuhang on 16/8/6.
//  Copyright © 2016年 刘航. All rights reserved.
//

#import "LHChatInput.h"
#import "LHAddBtnView.h"
#import "LHChatViewController.h"
#import "LHCreatWordMessage.h"
#define selfViewH 200
@interface LHChatInput ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *textPut;
//长按发送语音按钮
@property (weak, nonatomic) IBOutlet UIButton *longVoiceBtn;
//创建add的View
@property (nonatomic,strong) LHAddBtnView * addView;
@end
@implementation LHChatInput

+ (instancetype)instance
{
    return  [[NSBundle mainBundle]loadNibNamed:@"LHChatInput" owner:nil options:nil].firstObject;
    
}
//懒加载
- (LHAddBtnView *)addView
{
    if (!_addView) {
        _addView = [LHAddBtnView instanceis];
        //设置frame
        UIView * view = self.superview;
        _addView.frame = CGRectMake(view.frame.origin.x,view.frame.size.height, view.frame.size.width, selfViewH);
        [view addSubview:_addView];
    }
    return _addView;
}


- (void)awakeFromNib
{
    //消息观察者
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(chageStatus) name:@"keyBoard" object:nil];
    //创建'发语音'button
    self.longVoiceBtn.hidden = YES;
    self.textPut.delegate = self;

}
- (void)chageStatus
{
    [self.textPut resignFirstResponder];
}
- (IBAction)voiceBtn:(UIButton *)sender {
    if (!sender.selected) {
        [self.textPut resignFirstResponder];
        if (![self isFirstResponder]) {
            UIView * view = self.superview;
            CGRect rect = CGRectMake(0,0, view.frame.size.width, view.frame.size.height);
            [UIView animateWithDuration:0.25 animations:^{
                view.frame = rect;
            }];
        }
        sender.selected = YES;
        self.longVoiceBtn.hidden = NO;
        self.textPut.hidden = YES;
    }else
    {
        self.textPut.hidden = NO;
        [self.textPut becomeFirstResponder];
        self.longVoiceBtn.hidden = YES;
        sender.selected = NO;
    }
    
}
- (IBAction)LongTouch:(UIButton *)sender {
    NSLog(@"dianji le Voice");

}
- (IBAction)addBtn:(UIButton *)sender {
    
    if ([self.textPut isFirstResponder]) {
        [LHChatViewController shareInstance].isAnnimation = NO;
        [self.textPut resignFirstResponder];
        [self addView];
        UIView * view = self.superview;
        CGRect rect = CGRectMake(view.frame.origin.x,-selfViewH, view.frame.size.width, view.frame.size.height);
        [UIView animateWithDuration:0.25 animations:^{
            view.frame = rect;
        }completion:^(BOOL finished) {
            [LHChatViewController shareInstance].isAnnimation = YES;
        }];
        NSLog(@"是");        
    }else
    {
        [self.textPut becomeFirstResponder];
        self.longVoiceBtn.hidden = YES;
        self.textPut.hidden = NO;
        NSLog(@"不是");
    }
    
}
- (IBAction)emoijBtn:(UIButton *)sender {
    
}
#pragma mark -- 实现textField的代理方法
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{   //创建文字消息
   EMMessage * mes = [LHCreatWordMessage createMessageWith:[LHChatViewController shareInstance].chatter text:self.textPut.text chatType:EMChatTypeChat];
    //发送文字消息
    [[EMClient sharedClient].chatManager asyncSendMessage:mes progress:nil completion:^(EMMessage *message, EMError *error) {
        if (!error) {
            NSLog(@"消息发送成功");
        }
    }];
    self.textPut.text = nil;
    return YES;
}
@end
