//
//  LHLoginViewController.m
//  ForChat
//
//  Created by liuhang on 16/8/5.
//  Copyright © 2016年 刘航. All rights reserved.
//

#import "LHLoginViewController.h"
#import "LHTabBarViewController.h"
@interface LHLoginViewController ()

@end

@implementation LHLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}
- (IBAction)loginBtn:(UIButton *)sender {
    //登录
    
    if (self.countTextField.text != nil && self.passwordTextField != nil) {
       //设置自动登录
        [[EMClient sharedClient].options setIsAutoLogin:YES];
       EMError * error = [[EMClient sharedClient] loginWithUsername:self.countTextField.text password:self.passwordTextField.text];
        if (!error) {
            NSLog(@"登录成功");
            //跳转到主页面
            
            UIStoryboard * sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
           UITabBarController * tabBar = [sb instantiateViewControllerWithIdentifier:@"tabBar"];
            [self presentViewController:tabBar animated:YES completion:nil];
        }else
        {
            NSLog(@"登录失败");
        }
    }
}
- (IBAction)registerBtn:(UIButton *)sender {
}




@end
