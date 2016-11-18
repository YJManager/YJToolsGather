//
//  RuntimeViewController.m
//  YJToolsGather
//
//  Created by YJHou on 16/11/18.
//  Copyright © 2016年 YJHou. All rights reserved.
//

#import "RuntimeViewController.h"
#import <objc/message.h>
#import "Person.h"

@interface RuntimeViewController ()

@end

@implementation RuntimeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"Runtime";
    [self setRunMainMoudle];
}

- (void)setRunMainMoudle{
    
    //  1.遍历属性
    Class personClass = objc_getClass("Person");
    unsigned int outCount;
    objc_property_t *properties = class_copyPropertyList(personClass, &outCount);
    for (NSInteger i = 0; i < outCount; i++) {
        objc_property_t property = properties[i];
        NSLog(@"属性名 = %s 属性 = %s", property_getName(property), property_getAttributes(property));
    }
    free(properties);
    
    Person *person = [[personClass alloc] init];
    person.height = 30;
    NSLog(@"-- %ld", person.height);
    
    

}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
