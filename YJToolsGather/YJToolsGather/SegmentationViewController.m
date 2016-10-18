//
//  SegmentationViewController.m
//  YJToolsGather
//
//  Created by YJHou on 2016/10/18.
//  Copyright © 2016年 YJHou. All rights reserved.
//

#import "SegmentationViewController.h"
#import "NSString+YJTools.h"

@interface SegmentationViewController ()

@end

@implementation SegmentationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSArray<NSString *> * texts = [@"测试中文分what词功能" segment:YJSegmentationOptionsNone];
    [texts enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSLog(@"--->>>>> %@", obj);
    }];

}


@end
