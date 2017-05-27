//
//  ViewController.m
//  YJToolsGather
//
//  Created by YJHou on 2017/2/20.
//  Copyright © 2017年 Houmanager. All rights reserved.
//

#import "ViewController.h"
#import "ControllerManager.h"

@interface ViewController ()

@property (nonatomic, assign) BOOL isEnable; /**< keyong */

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    self.isEnable = !self.isEnable;
    
    if (self.isEnable) {
        [ControllerManager graduallySetBrightness:0.7];
    }else{
        [ControllerManager graduallyResumeBrightness];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
