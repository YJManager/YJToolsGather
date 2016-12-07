//
//  SendEmailViewController.m
//  YJToolsGather
//
//  Created by YJHou on 16/12/6.
//  Copyright © 2016年 YJHou. All rights reserved.
//

/**
 PS:1.调用系统自带邮件需要添加MessageUI.framework
      通过上述代码调用的邮件界面是英文的，若需要中文界面需要把调用邮件的xib文件本地化。
 */

#import "SendEmailViewController.h"
#import <MessageUI/MessageUI.h>

#define NUMBERS @"0123456789"

@interface SendEmailViewController () <MFMailComposeViewControllerDelegate, UITextFieldDelegate>

@property (nonatomic, copy) NSString *filePath; /**< 文件路径 */
@property (nonatomic, strong) UITextField *phoneField; /**< 输入手机号 */

@end

@implementation SendEmailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self _setUpSendEmailNavgationView];
    [self _setUpSendEmailMainView];
    [self _loadaendEmailDataFormServer];
}

- (void)_setUpSendEmailNavgationView{
    self.navigationItem.title = @"发送邮件";
}

- (void)_setUpSendEmailMainView{
    
    UIButton *btnInit = [UIButton buttonWithType:UIButtonTypeCustom];
    btnInit.frame = CGRectMake(0, 64, 60, 40);
    btnInit.backgroundColor = [UIColor greenColor];
    [btnInit setTitle:@"写入" forState:UIControlStateNormal];
    [btnInit setTitle:@"写入" forState:UIControlStateHighlighted];
    [btnInit setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btnInit setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [btnInit addTarget:self action:@selector(writeMailContentToDom) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnInit];

    UIButton *sendBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    sendBtn.frame = CGRectMake(120, 64, 60, 40);
    sendBtn.backgroundColor = [UIColor redColor];
    [sendBtn setTitle:@"发送" forState:UIControlStateNormal];
    [sendBtn setTitle:@"发送" forState:UIControlStateHighlighted];
    [sendBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [sendBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [sendBtn addTarget:self action:@selector(sendEmailToMyEmail) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sendBtn];
    
    self.phoneField.backgroundColor = [UIColor redColor];
    
}

// 写入
- (void)writeMailContentToDom{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy_MM_dd_HH_mm"];	// 设置格式为年-月-日 时:分:秒:毫秒
    NSString *timeStr = [dateFormatter stringFromDate:[NSDate date]];
    
    NSString *filePackageName  = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSString *fileNamePackageRes = [[NSString alloc] initWithFormat:@"%@/%@_%@", filePackageName, timeStr, @"log.txt"];
    self.filePath = fileNamePackageRes;

    NSString *strLogData = [[NSString alloc]initWithFormat:@"my is log time:%@", timeStr];
    NSError *error = nil;
    [strLogData writeToFile:fileNamePackageRes atomically:NO encoding:NSUTF8StringEncoding error:&error];
    
    if (error) {
        [self _alertWithTitle:@"" msg:@"写入失败"];
    }else{
        [self _alertWithTitle:@"" msg:@"写入成功"];
    }
}

// 发送
- (void)sendEmailToMyEmail{
    
    BOOL canSendMail = [MFMailComposeViewController canSendMail];
    if (canSendMail) {
        
    }else{
        [self _alertWithTitle:@"" msg:@"不支持发送邮件"];
        return;
    }
    
    NSString *logData = [[NSString alloc] initWithContentsOfFile:self.filePath encoding:NSUTF8StringEncoding error:nil];
    if (logData){
        MFMailComposeViewController *mailCompose = [[MFMailComposeViewController alloc] init];
        
        if(mailCompose){
            [mailCompose setMailComposeDelegate:self];
            
            // 收件
            NSArray *toAddress = @[@"8069060@qq.com"];
            [mailCompose setToRecipients:toAddress];

            // 抄送
            NSArray *ccAddress = @[@"yuejun.hou@rograndec.com"];
            [mailCompose setCcRecipients:ccAddress];
            // 密送
            NSArray *bccAddress = @[@"11283019@qq.com"];
            [mailCompose setBccRecipients:bccAddress];
 
            // 设置邮件内容
            NSString *emailBody = @"<H1>日志信息</H1>";
            [mailCompose setMessageBody:emailBody isHTML:YES];
            
            NSData *pData = [[NSData alloc] initWithContentsOfFile:self.filePath];
            NSLog(@"pData-%@", pData);
            // 设置邮件主题
            [mailCompose setSubject:@"今天下午4点开会"];
            // 设置邮件附件{mimeType:文件格式|fileName:文件名}
            [mailCompose addAttachmentData:pData mimeType:@"txt" fileName:@"日志.txt"];
            
            // 显示
            [self presentViewController:mailCompose animated:YES completion:^{
                NSLog(@"-已经model出");
            }];
        }
    }else{
        [self _alertWithTitle:@"" msg:@"请先点击写入日志按钮"];
    }
}

#pragma mark - <MFMailComposeViewControllerDelegate> -
- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error{
    
    switch (result){
        case MFMailComposeResultCancelled:
            NSLog(@"-%@", @"邮件发送取消");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"-%@", @"邮件保存成功");
            break;
        case MFMailComposeResultSent:
            NSLog(@"-%@", @"邮件发送成功");
            break;
        case MFMailComposeResultFailed:
            NSLog(@"-%@", @"邮件发送失败");
            break;
        default:
            break;
    }

    [self dismissViewControllerAnimated:YES completion:^{
        NSLog(@"-发送邮件视图已经消失");
    }];
}

-(void)_loadaendEmailDataFormServer{
    
}

- (void)_alertWithTitle:(NSString *)title msg:(NSString *)msg{
    if (title && msg){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                        message:msg
                                                       delegate:nil
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil];
        [alert show];
    }
}

#pragma mark - TextFieldDelegate
////＝＝＝＝＝＝＝＝＝＝＝＝＝ 方法一 ＝＝＝＝＝＝＝＝＝＝＝＝＝＝

- (BOOL)textField:(UITextField*)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString*)string{
    NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:NUMBERS] invertedSet];
    NSString*filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
    BOOL basicTest = [string isEqualToString:filtered];
    if(!basicTest) {
        return NO;
    }
    return YES;
}
//＝＝＝＝＝＝＝＝＝＝＝＝＝ 方法二 ＝＝＝＝＝＝＝＝＝＝＝＝＝＝
/*
 - (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
 return [self validateNumber:string];
 }
 
 - (BOOL)validateNumber:(NSString*)number {
 BOOL res = YES;
 NSCharacterSet* tmpSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
 int i = 0;
 while (i < number.length) {
 NSString * string = [number substringWithRange:NSMakeRange(i, 1)];
 NSRange range = [string rangeOfCharacterFromSet:tmpSet];
 if (range.length == 0) {
 res = NO;
 break;
 }
 i++;
 }
 return res;
 }
 */
//＝＝＝＝＝＝＝＝＝＝＝＝＝ 方法二 ＝＝＝＝＝＝＝＝＝＝＝＝＝＝

#pragma mark - Lazy
- (UITextField *)phoneField{
    if (_phoneField == nil) {
        _phoneField =[[UITextField alloc]initWithFrame:CGRectMake(100,110, 160, 40)];
        _phoneField.placeholder = @"只允许输入0~9";
        _phoneField.delegate = self;
        _phoneField.font=[UIFont systemFontOfSize:15];
        _phoneField.borderStyle=UITextBorderStyleNone;
        [self.view addSubview:_phoneField];
    }
    return _phoneField;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    NSLog(@"-SendMial收到内存警告");
}


@end
