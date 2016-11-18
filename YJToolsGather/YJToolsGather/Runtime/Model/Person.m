//
//  Person.m
//  YJToolsGather
//
//  Created by YJHou on 16/11/18.
//  Copyright © 2016年 YJHou. All rights reserved.
//

#import "Person.h"
#import <objc/message.h>
#import "Dog.h"



@implementation Person
@dynamic height; // 避免自动生成getter/setter

 //重写 动态方法解析
+ (BOOL)resolveInstanceMethod:(SEL)sel{

    if (sel == @selector(setHeight:)) {
        class_addMethod([self class], sel, (IMP)setPropertyDynamic, "V@:");
        return YES;
    }
    return [super resolveInstanceMethod:sel];
}

//用来响应setWeight的c语言方法
void setPropertyDynamic(id self, SEL _cmd) {
    NSLog(@"Dynamic setWeight");
}

// 如果重写+ (BOOL)resolveInstanceMethod:(SEL)sel方法，那就会调用- (id)forwardingTargetForSelector:(SEL)aSelector方法，把这个消息让另一个对象来处理，这次叫做重定向。
- (id)forwardingTargetForSelector:(SEL)aSelector{
    if (aSelector == @selector(height)) {
        Dog *people = [[Dog alloc] init];
        return people;
    }
    return [super forwardingTargetForSelector:aSelector];
}

@end
