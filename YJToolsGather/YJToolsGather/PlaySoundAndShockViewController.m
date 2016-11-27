//
//  PlaySoundAndShockViewController.m
//  YJToolsGather
//
//  Created by YJHou on 16/11/7.
//  Copyright © 2016年 YJHou. All rights reserved.
//

#import "PlaySoundAndShockViewController.h"
#import "PlaySoundAndShocking.h"
#import "YJSwitch.h"

@interface PlaySoundAndShockViewController ()

@property (nonatomic, assign) BOOL isCanPlay; /** 是否可以播放声音 */


@end

@implementation PlaySoundAndShockViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"播放断音和震动";
    [self _setUpPlaySoundAndShockMainView];
}

- (void)_setUpPlaySoundAndShockMainView{
    
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(50, 200, 120, 40);
    [btn setTitle:@"播放" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnActionClick) forControlEvents:UIControlEventTouchUpInside];
    btn.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:btn];
    
    
    YJSwitch *sw = [[YJSwitch alloc] init];
    sw.frame = CGRectMake(100, 100, 50, 20);
    sw.clipsToBounds = YES;
    [sw addTarget:self action:@selector(YJSwitchChange:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:sw];
}

- (void)YJSwitchChange:(YJSwitch *)switchValue{
    
    self.isCanPlay = switchValue.isShowWords;

}

- (void)btnActionClick{
    
    if (self.isCanPlay) {
        [[PlaySoundAndShocking sharedInstance] playSound];
    }else{
        [[PlaySoundAndShocking sharedInstance] playShacking];
    }
}

@end
