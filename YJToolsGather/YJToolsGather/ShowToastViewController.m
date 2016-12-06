//
//  ShowToastViewController.m
//  YJToolsGather
//
//  Created by YJHou on 2016/11/24.
//  Copyright © 2016年 YJHou. All rights reserved.
//

#import "ShowToastViewController.h"
#import "UIView+ShowToast.h"

@interface ShowToastViewController ()

@end

@implementation ShowToastViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    [self.navigationController.view showTipViewAtCenter:@"哎呀妈啊"];
}

- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}



@end
