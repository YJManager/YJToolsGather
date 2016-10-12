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

- (void)isMuted:(BOOL)muted{

    if (muted) {
        NSLog(@"静音");
    }else{
        NSLog(@"响亮");
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
