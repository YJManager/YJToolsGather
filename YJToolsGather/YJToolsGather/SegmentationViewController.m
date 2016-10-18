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
    
    NSArray<NSString *> *texts = [@"测试中文分词功能" segmentation:PINSegmentationOptionsNone];
    [texts enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSLog(@"%@", obj);
    }];
}


@end
