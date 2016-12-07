//
//  PinYinViewController.m
//  YJToolsGather
//
//  Created by YJHou on 16/12/7.
//  Copyright © 2016年 YJHou. All rights reserved.
//

#import "PinYinViewController.h"
#import "pinyin.h"

@implementation ChineseString

@synthesize string, pinYin;

@end


@interface PinYinViewController ()

@end

@implementation PinYinViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSString *hanyu = @"侯叔叔";
    for (int i = 0; i < [hanyu length]; i++){
        NSLog(@"%c", pinyinFirstLetter([hanyu characterAtIndex:i]));
    }
    [self _sortPinFirst];
}

- (void)_sortPinFirst{
    
    //Step1:初始化
    NSArray *stringsToSort=[NSArray arrayWithObjects:@"1",@"2",@"3",@"6",@"9",@"11",@"21",@"32",@"23",@"34",@"43",@"41",@"24",@"42",nil];
    //从字符位置开始按字符大小进行排序
    NSArray *arr=[stringsToSort sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        return [obj1 localizedCompare:obj2];
    }];
    NSLog(@"--++%@",arr);
    
    
    //全局的比较大小进行排序
    NSMutableString *outputBefore = [[NSMutableString alloc] init];
    for(NSString *str in stringsToSort){
        [outputBefore appendFormat:@"%@,",str];}
    NSLog(@"排序前:%@", outputBefore);
    NSArray *array = [stringsToSort sortedArrayUsingFunction:customSort context:nil];
    NSMutableString *outputAfter = [[NSMutableString alloc] init];
    for(NSString *str in array){
        [outputAfter appendFormat:@"%@,",str];
    }
    NSLog(@"排序后:%@",outputAfter);
}

NSInteger customSort(id obj1, id obj2,void* context){
    if ([obj1 integerValue] > [obj2 integerValue]) { return (NSComparisonResult)NSOrderedDescending;
    }
    if ([obj1 integerValue] < [obj2 integerValue]) { return (NSComparisonResult)NSOrderedAscending;
    }
    return (NSComparisonResult)NSOrderedSame;
}

@end
