//
//  YJSingleton.h
//  YJToolsGather
//
//  Created by YJHou on 2017/2/20.
//  Copyright © 2017年 Houmanager. All rights reserved.
//

#ifndef YJSingleton_h
#define YJSingleton_h

// .h
#define singleton_interface(class) + (instancetype)shared##class;

/*
 // @interface
 #define singleton_interface(className) \
 + (className *)shared##className;
 */

// .m
#define singleton_implementation(class) \
static class *_instance; \
\
+ (id)allocWithZone:(struct _NSZone *)zone \
{ \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
_instance = [super allocWithZone:zone]; \
}); \
\
return _instance; \
} \
\
+ (instancetype)shared##class \
{ \
if (_instance == nil) { \
_instance = [[class alloc] init]; \
} \
\
return _instance; \
}

/*
 // @implementation
 #define singleton_implementation(className) \
 static className *_instance; \
 + (id)allocWithZone:(NSZone *)zone \
 { \
 static dispatch_once_t onceToken; \
 dispatch_once(&onceToken, ^{ \
 _instance = [super allocWithZone:zone]; \
 }); \
 return _instance; \
 } \
 + (className *)shared##className \
 { \
 static dispatch_once_t onceToken; \
 dispatch_once(&onceToken, ^{ \
 _instance = [[self alloc] init]; \
 }); \
 return _instance; \
 }
 */


#endif /* YJSingleton_h */
