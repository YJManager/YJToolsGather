//
//  ViewController.m
//  YJToolsGather
//
//  Created by YJHou on 16/10/12.
//  Copyright © 2016年 YJHou. All rights reserved.
//

#import "ViewController.h"
#import "MonitorMuteManager.h"

@interface ViewController () <MonitorMuteManagerDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [MonitorMuteManager sharedInstance].delegate = self;
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [[MonitorMuteManager sharedInstance] detectMuteSwitch];
}

- (void)volumeModeMuted:(BOOL)muted{

    if (muted) {
        NSLog(@"静音模式");
    }else{
        NSLog(@"响亮模式");
    }
}


@end
