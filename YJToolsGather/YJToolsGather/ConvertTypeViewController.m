//
//  ConvertTypeViewController.m
//  YJToolsGather
//
//  Created by YJHou on 16/10/20.
//  Copyright © 2016年 YJHou. All rights reserved.
//

#import "ConvertTypeViewController.h"

@interface ConvertTypeViewController ()

@end

@implementation ConvertTypeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"类型转换";
    [self _setUpConvertTypeMain];
}

- (void)_setUpConvertTypeMain{
    
    // 类型转换
    // NSString; NSData; NSArray; NSDictionary;
    
    NSString * string = @"YJManager email is houmanager@hotmail.com";
    NSData * data = [string dataUsingEncoding:NSUTF8StringEncoding];
    NSArray * array = [NSArray arrayWithObjects:@"1", @"2", @"3", @"3", nil];
    NSDictionary * dic = @{@"a":@"YJ", @"b":@"Manager", @"c":@"China", @"d":@"BeiJing"};
    
    // 1. 字符串 -> NSData
    NSData * stringConvertData = [string dataUsingEncoding:NSUTF8StringEncoding];
    // 2.NSData -> NSString
    NSString * dataConvertString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"stringConvertData = %@, dataConvertString = %@", stringConvertData, dataConvertString);
    
    // 3.NSArray -> NSData
    NSData * arrayConvertData = [NSKeyedArchiver archivedDataWithRootObject:array];
    // 4.NSData -> NSArray
    NSArray * dataConvertArray = [NSKeyedUnarchiver unarchiveObjectWithData:arrayConvertData];
    NSLog(@"arrayConvertData = %@, dataConvertArray = %@", arrayConvertData, dataConvertArray);
    
    // 5.NSDictionary -> NSData
    NSMutableData * mutableData = [[NSMutableData alloc] init];
    NSKeyedArchiver * archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:mutableData];
    [archiver encodeObject:dic forKey:@"savaDic"];
    [archiver finishEncoding];
    NSLog(@"mutableData = %@", mutableData);
    
    // 6.NSData -> NSDictionary
    NSKeyedUnarchiver * unArchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:mutableData];
    NSDictionary * resDic = [unArchiver decodeObjectForKey:@"savaDic"];
    [unArchiver finishDecoding];
    NSLog(@"resDic = %@", resDic);
    
    
    
    
    
    
    
    
    

}

@end
