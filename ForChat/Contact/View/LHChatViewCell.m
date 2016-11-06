//
//  LHChatViewCell.m
//  ForChat
//
//  Created by liuhang on 16/8/9.
//  Copyright © 2016年 刘航. All rights reserved.
//

#import "LHChatViewCell.h"
#import "NSString+LHTimeSwitch.h"
#define marginW 8
#define TextmaxW 200
#define timeH 15
@interface LHChatViewCell ()
//***************cell******************//
/** contentView */
@property (nonatomic,strong) UIImageView * bgView;
/** 文字label */
@property (nonatomic,strong) UILabel * text;
/** 时间label */
@property (nonatomic,strong) UILabel * timeLabel;
/** 头像imageVIew */
@property (nonatomic,strong) UIButton * iconBtn;
/** 消息属于谁 */
@property (nonatomic,assign) BOOL isMe;
//cell的高度
@property (nonatomic,assign) CGFloat cellH;
@end

@implementation LHChatViewCell
- (void)createUI
{
    _bgView = [[UIImageView alloc]init];
    _text = [[UILabel alloc]init];
    _text.numberOfLines = 0;
    _timeLabel  = [[UILabel alloc]init];
    _iconBtn = [[UIButton alloc]init];
}
-(void)calculator
{
    //计算text的frame
    //宽度不变，根据字的多少计算label的高度
    CGSize sizeS = CGSizeMake(200, CGFLOAT_MAX);
    CGSize size = [_text.text boundingRectWithSize:sizeS options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSAttachmentAttributeName:[UIFont systemFontOfSize:15]} context:nil].size;
    //根据计算结果重新设置UILabel的尺寸
    if (_isMe) {
        _iconBtn.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - marginW - 40, marginW + timeH, 40, 40);
        [_text setFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - marginW * 2 - TextmaxW - 40, marginW + timeH, size.width, size.height)];
    }else
    {
        _iconBtn.frame = CGRectMake(marginW, marginW + timeH, 40, 40);
       [_text setFrame:CGRectMake( 2 * marginW + 40, marginW + timeH, size.width, size.height)];
    }
    
    
    _iconBtn.frame = CGRectMake(0, 0, 50, 50);
    
    _iconBtn.backgroundColor = [UIColor redColor];
    
    
    _bgView.frame = CGRectMake(_text.frame.origin.x-5, _text.frame.origin.y -5,_text.frame.size.width + 10,_text.frame.size.height + 10);
    _timeLabel.center = CGPointMake(([UIScreen mainScreen].bounds.size.width - size.width) * 0.5, 20);
    //cell的高度
    _cellH = timeH  + size.height;
    [self.contentView addSubview:_bgView];
    [self.contentView addSubview:_text];
    [self.contentView addSubview:_iconBtn];
    [self.contentView addSubview:_timeLabel];
    
}
- (CGFloat)cellH
{
    [self calculator];
    return _cellH;
}
-(void)setMes:(EMMessage *)mes
{
    _mes = mes;
    [self createUI];
    //获取当前登录者
    NSString *userName = [[EMClient sharedClient] currentUsername];
    
    //给模型属性赋值
    if ([mes.from isEqualToString:userName]) {
        _isMe = YES;
        //背景图
        _bgView.image = [UIImage imageNamed:@"chat_sender_bg"];
    }else
    {
        //背景图
        _bgView.image = [UIImage imageNamed:@"chat_receiver_bg"];
    }
    
    [_iconBtn setBackgroundImage:[UIImage imageNamed:@"chatListCellHead"] forState:UIControlStateNormal];
    _iconBtn.backgroundColor = [UIColor redColor];
    //timeLabel
    _timeLabel.text = [NSString switchTime:mes.timestamp];
    NSLog(@"time - %@",[NSString switchTime:mes.localTime]);
    //解析message
        EMMessageBody *msgBody = mes.body;
            switch (msgBody.type) {
            case EMMessageBodyTypeText:
            {
                // 收到的文字消息
                EMTextMessageBody *textBody = (EMTextMessageBody *)mes.body;
                _text.text = textBody.text;
                NSLog(@"收到的文字是 txt -- %@",_text.text);
            }
                break;
//            case EMMessageBodyTypeImage:
//            {
//                // 得到一个图片消息body
//                EMImageMessageBody *body = ((EMImageMessageBody *)msgBody);
//                NSLog(@"大图remote路径 -- %@"   ,body.remotePath);
//                NSLog(@"大图local路径 -- %@"    ,body.localPath); // // 需要使用sdk提供的下载方法后才会存在
//                NSLog(@"大图的secret -- %@"    ,body.secretKey);
//                NSLog(@"大图的W -- %f ,大图的H -- %f",body.size.width,body.size.height);
//                NSLog(@"大图的下载状态 -- %d",body.downloadStatus);
//                
//                
//                // 缩略图sdk会自动下载
//                NSLog(@"小图remote路径 -- %@"   ,body.thumbnailRemotePath);
//                NSLog(@"小图local路径 -- %@"    ,body.thumbnailLocalPath);
//                NSLog(@"小图的secret -- %@"    ,body.thumbnailSecretKey);
//                NSLog(@"小图的W -- %f ,大图的H -- %f",body.thumbnailSize.width,body.thumbnailSize.height);
//                NSLog(@"小图的下载状态 -- %d",body.thumbnailDownloadStatus);
//            }
//                break;
//            case EMMessageBodyTypeLocation:
//            {
//                EMLocationMessageBody *body = (EMLocationMessageBody *)msgBody;
//                NSLog(@"纬度-- %f",body.latitude);
//                NSLog(@"经度-- %f",body.longitude);
//                NSLog(@"地址-- %@",body.address);
//            }
//                break;
//            case EMMessageBodyTypeVoice:
//            {
//                // 音频sdk会自动下载
//                EMVoiceMessageBody *body = (EMVoiceMessageBody *)msgBody;
//                NSLog(@"音频remote路径 -- %@"      ,body.remotePath);
//                NSLog(@"音频local路径 -- %@"       ,body.localPath); // 需要使用sdk提供的下载方法后才会存在（音频会自动调用）
//                NSLog(@"音频的secret -- %@"        ,body.secretKey);
//                NSLog(@"音频文件大小 -- %lld"       ,body.fileLength);
//                NSLog(@"音频文件的下载状态 -- %d"   ,body.downloadStatus);
//                NSLog(@"音频的时间长度 -- %d"      ,body.duration);
//            }
//                break;
//            case EMMessageBodyTypeVideo:
//            {
//                EMVideoMessageBody *body = (EMVideoMessageBody *)msgBody;
//                
//                NSLog(@"视频remote路径 -- %@"      ,body.remotePath);
//                NSLog(@"视频local路径 -- %@"       ,body.localPath); // 需要使用sdk提供的下载方法后才会存在
//                NSLog(@"视频的secret -- %@"        ,body.secretKey);
//                NSLog(@"视频文件大小 -- %lld"       ,body.fileLength);
//                NSLog(@"视频文件的下载状态 -- %d"   ,body.downloadStatus);
//                NSLog(@"视频的时间长度 -- %d"      ,body.duration);
//                NSLog(@"视频的W -- %f ,视频的H -- %f", body.thumbnailSize.width, body.thumbnailSize.height);
//                
//                // 缩略图sdk会自动下载
//                NSLog(@"缩略图的remote路径 -- %@"     ,body.thumbnailRemotePath);
//                NSLog(@"缩略图的local路径 -- %@"      ,body.thumbnailLocalPath);
//                NSLog(@"缩略图的secret -- %@"        ,body.thumbnailSecretKey);
//                NSLog(@"缩略图的下载状态 -- %d"      ,body.thumbnailDownloadStatus);
//            }
//                break;
//            case EMMessageBodyTypeFile:
//            {
//                EMFileMessageBody *body = (EMFileMessageBody *)msgBody;
//                NSLog(@"文件remote路径 -- %@"      ,body.remotePath);
//                NSLog(@"文件local路径 -- %@"       ,body.localPath); // 需要使用sdk提供的下载方法后才会存在
//                NSLog(@"文件的secret -- %@"        ,body.secretKey);
//                NSLog(@"文件文件大小 -- %lld"       ,body.fileLength);
//                NSLog(@"文件文件的下载状态 -- %d"   ,body.downloadStatus);
//            }
//                break;
                
            default:
                break;
        }
}

@end
