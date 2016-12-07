//
//  YJMainViewController.m
//  YJToolsGather
//
//  Created by YJHou on 16/10/12.
//  Copyright © 2016年 YJHou. All rights reserved.
//

#import "YJMainViewController.h"
#import "MonitorMuteManager.h"
#import "SegmentationViewController.h"
#import "ConvertTypeViewController.h"
#import "PlaySoundAndShockViewController.h"
#import <MessageUI/MessageUI.h>
#import <AddressBook/AddressBook.h>
#import "RuntimeViewController.h"
#import "YaoYiYaoViewController.h"
#import "ShowToastViewController.h"
#import "SendEmailViewController.h"
#import "PinYinViewController.h"

@interface YJMainViewController () <UITableViewDataSource, UITableViewDelegate, MonitorMuteManagerDelegate, MFMessageComposeViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray * dataSource;
@property (nonatomic, strong) UILabel * muteModelLabel; /**< 手机静音模式 */

@end

@implementation YJMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self _setUpMainNavView];
    [self _setUpMainView];
}


- (void)_setUpMainNavView{
    self.navigationItem.title = @"测试";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.muteModelLabel];
}

- (void)_setUpMainView{
    
    self.tableView.tableFooterView = [UIView new];
    
    NSArray * dataSource = @[@"查看手机是否静音",
                             @"测试中文分词功能",
                             @"类型转换",
                             @"播放声音和震动",
                             @"是否可发短信",
                             @"Runtime",
                             @"摇一摇",
                             @"Toast",
                             @"发邮件和只能输入规定字符",
                             @"拼音"
                             ];
    
    self.dataSource = [NSMutableArray arrayWithArray:dataSource];
    
    [MonitorMuteManager sharedInstance].delegate = self;
}

#pragma mark - tableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * testCellId = @"";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:testCellId];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:testCellId];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@", self.dataSource[indexPath.row]];
    cell.textLabel.font = [UIFont systemFontOfSize:15.0f];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    UIViewController * pushVc = nil;
    if (indexPath.row == 0) { // 查看手机是否静音
        [[MonitorMuteManager sharedInstance] detectMuteSwitch];
    }else if (indexPath.row == 1){
        SegmentationViewController * seg = [[SegmentationViewController alloc] init];
        pushVc = seg;
    }else if (indexPath.row == 2){
        
        ConvertTypeViewController * convert = [[ConvertTypeViewController alloc] init];
        pushVc = convert;
    }else if (indexPath.row == 3){
        PlaySoundAndShockViewController * convert = [[PlaySoundAndShockViewController alloc] init];
        pushVc = convert;
    }else if (indexPath.row == 4){
        [self sendMessage];
    }else if (indexPath.row == 5){
        RuntimeViewController * runtime = [[RuntimeViewController alloc] init];
        pushVc = runtime;
    }else if (indexPath.row == 6){
        YaoYiYaoViewController * yaoyiyao = [[YaoYiYaoViewController alloc] init];
        pushVc = yaoyiyao;
    }else if (indexPath.row == 7){
        ShowToastViewController * showToastVc = [[ShowToastViewController alloc] init];
        pushVc = showToastVc;
    }else if (indexPath.row == 8){
        SendEmailViewController * showToastVc = [[SendEmailViewController alloc] init];
        pushVc = showToastVc;
    }else if (indexPath.row == 9){
        PinYinViewController * showToastVc = [[PinYinViewController alloc] init];
        pushVc = showToastVc;
    }
    if (pushVc) {
        [self.navigationController pushViewController:pushVc animated:YES];
    }
}

#pragma mark - 发送短信
- (void)sendMessage{
    // 1.是否可发短信
    BOOL canSendSMS = [MFMessageComposeViewController canSendText];
    
    if (canSendSMS) {
        ABAddressBookRef addressBook = NULL;
        __block BOOL accessGranted = NO;
        
        if (ABAddressBookGetAuthorizationStatus() == kABAuthorizationStatusDenied) {
            // 添加提示开启授权
        }
//        if (&ABAddressBookRequestAccessWithCompletion != NULL) { // iOS 6
//            addressBook = ABAddressBookCreateWithOptions(NULL, NULL);
//            dispatch_semaphore_t sema = dispatch_semaphore_create(0);
//            ABAddressBookRequestAccessWithCompletion(addressBook, ^(bool granted, CFErrorRef error) {
//                accessGranted = granted;
//                dispatch_semaphore_signal(sema);
//            });
//            dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
//            //            dispatch_release(sema);YJ.4.23
//            
//            if (accessGranted) {
//                MFMessageComposeViewController *picker = [[MFMessageComposeViewController alloc] init];
//                picker.messageComposeDelegate = self;
//                if ([picker.navigationBar respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)])
//                {
//                    [picker.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
//                    picker.navigationBar.tintColor = nil;
//                    
//                }
//                picker.body = @"短信内容";
//                [self presentViewController:picker animated:YES completion:nil];
//            }
//        }else
        {
            MFMessageComposeViewController *picker = [[MFMessageComposeViewController alloc] init];
            picker.messageComposeDelegate = self;
            if ([picker.navigationBar respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)])
            {
                [picker.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
                picker.navigationBar.tintColor = [UIColor redColor];
                
            }
            picker.body = @"短信内容";
            [self presentViewController:picker animated:YES completion:nil];
        }
    }else{
        // 给出不支持短信的提示
    }
}

#pragma mark - 发送短信api的回调函数
- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result {
    
    [self  dismissViewControllerAnimated:YES completion:nil];
    
    switch (result) {
        case MessageComposeResultCancelled:{
            
            break;
        }
        case MessageComposeResultSent:{
            break;
        }
        case MessageComposeResultFailed:{
            break;
        }
        default:
            break;
    }
}

#pragma mark - MonitorMuteManagerDelegate
- (void)volumeModeMuted:(BOOL)muted{
    NSString * mutedMessage = muted?@"静音":@"响亮";
    self.muteModelLabel.text = mutedMessage;
}

#pragma mark - Lazy
- (NSMutableArray *)dataSource{
    if (_dataSource == nil) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

- (UILabel *)muteModelLabel{
    if (_muteModelLabel == nil) {
        _muteModelLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
        _muteModelLabel.font = [UIFont systemFontOfSize:14.0f];
        _muteModelLabel.textColor = [UIColor redColor];
    }
    return _muteModelLabel;
}


@end
