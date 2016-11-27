//
//  YaoYiYaoViewController.m
//  YJToolsGather
//
//  Created by YJHou on 2016/11/19.
//  Copyright © 2016年 YJHou. All rights reserved.
//

#import "YaoYiYaoViewController.h"
#import "PlaySoundAndShocking.h"

@interface YaoYiYaoViewController ()

@end

@implementation YaoYiYaoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

}

- (void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event{
    NSLog(@"开始摇一摇");
}

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event{
    NSLog(@"开始摇一摇END");
}

- (void)motionCancelled:(UIEventSubtype)motion withEvent:(UIEvent *)event{
    NSLog(@"开始摇一摇取消");
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
