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
@dynamic ID;
//@dynamic height; // 避免自动生成getter/setter
//
// //重写 动态方法解析
//+ (BOOL)resolveInstanceMethod:(SEL)sel{
//
//    if (sel == @selector(setHeight:)) {
//        class_addMethod([self class], sel, (IMP)setPropertyDynamic, "V@:");
//        return YES;
//    }
//    return [super resolveInstanceMethod:sel];
//}
//
////用来响应setWeight的c语言方法
//void setPropertyDynamic(id self, SEL _cmd) {
//    NSLog(@"Dynamic setWeight");
//}
//
//// 做重定向 -- 如果重写+ (BOOL)resolveInstanceMethod:(SEL)sel方法，那就会调用- (id)forwardingTargetForSelector:(SEL)aSelector方法，把这个消息让另一个对象来处理，这次叫做重定向。
//- (id)forwardingTargetForSelector:(SEL)aSelector{
//    if (aSelector == @selector(height)) {
//        Dog *people = [[Dog alloc] init];
//        return people;
//    }
//    return [super forwardingTargetForSelector:aSelector];
//}

/**
消息转发：
那么如果上面的两个方法都没有重写，并且消息依然是当前对象没有实现的方法，runtime才会启用消息转发调用– (void)forwardInvocation:(NSInvocation *)anInvocation，需要注意的是很多文章没有提到这个方法花费代价较大，如果要实现把消息转发类似的功能建议最好使用重定向，而且再调用这个方法前runtime会先调用- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector方法。
 */
- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector{
    if (aSelector == @selector(setID:)) {
        NSMethodSignature *sig = [NSMethodSignature signatureWithObjCTypes:"v@:"];
        //"v@:"代表的意思参见Objective-C Type Encodings，这里的意思是返回值为空
        return sig;
    }
    return nil;
}
- (void)forwardInvocation:(NSInvocation *)anInvocation{
    Dog *people = [[Dog alloc] init];
    if ([people respondsToSelector:anInvocation.selector]) {
        [anInvocation invokeWithTarget:people];
    }
}




@end
