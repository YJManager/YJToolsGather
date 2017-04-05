//
//  YJConfigure.h
//  YJToolsGather
//
//  Created by YJHou on 2017/2/20.
//  Copyright © 2017年 Houmanager. All rights reserved.
//  工程的基本配置：包括日志打印、屏幕尺寸等配置

#ifndef YJConfigure_h
#define YJConfigure_h

/** 1.自定义打印log 行数+信息*/
#ifdef DEBUG
    #define YJLog(...) NSLog(@"%3d %@", __LINE__, [NSString stringWithFormat:__VA_ARGS__])
#else
    #define YJLog(...)
#endif

/** 2. 屏幕宽高及frame KEY_WINDOW */
#define kSCREEN_FRAME [UIScreen mainScreen].bounds
#define kSCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define kSCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define kKEY_WINDOW [UIApplication sharedApplication].keyWindow

/** 3. 版本号 */
#define kAPP_CURRENT_VERSION [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"] // APP 版本
#define kAPP_BUILD_VERSION [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"]              // APP 编译版本

/** 4.  */
/** 不是空nil 或者 null */
#define NotNilAndNull(_ref)  (((_ref) != nil) && (![(_ref) isEqual:[NSNull null]]))
//字符串是否为空
#define IsStrEmpty(_ref)    (((_ref) == nil) || ([(_ref) isEqual:[NSNull null]]) ||([(_ref)isEqualToString:@""]))
//数组是否为空
#define IsArrEmpty(_ref)    (((_ref) == nil) || ([(_ref) isEqual:[NSNull null]]) ||([(_ref) count] == 0))


#endif /* YJConfigure_h */
