//
//  YJConfigure.h
//  YJToolsGather
//
//  Created by YJHou on 2017/2/20.
//  Copyright © 2017年 Houmanager. All rights reserved.
//

#ifndef YJConfigure_h
#define YJConfigure_h

/** 1.自定义打印log */
#ifdef DEBUG
    #define YJLog(...) NSLog(@"%3d %@", __LINE__, [NSString stringWithFormat:__VA_ARGS__])
#else
    #define YJLog(...)
#endif

/** 2. 屏幕宽高及frame KEY_WINDOW */
#define SCREEN_FRAME [UIScreen mainScreen].bounds
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define KEY_WINDOW [UIApplication sharedApplication].keyWindow

#endif /* YJConfigure_h */
