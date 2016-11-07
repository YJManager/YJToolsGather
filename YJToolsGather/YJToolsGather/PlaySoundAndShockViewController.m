//
//  PlaySoundAndShockViewController.m
//  YJToolsGather
//
//  Created by YJHou on 16/11/7.
//  Copyright © 2016年 YJHou. All rights reserved.
//

#import "PlaySoundAndShockViewController.h"
#import "PlaySoundAndShocking.h"

@interface PlaySoundAndShockViewController ()

@end

@implementation PlaySoundAndShockViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

    // Do any additional setup after loading the view.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    [PlaySoundAndShocking playSoundAndShacking:NO];
}

@end
