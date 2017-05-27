//
//  ControllerManager.h
//  YJToolsGather
//
//  Created by YJHou on 2017/4/1.
//  Copyright © 2017年 Houmanager. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ControllerManager : NSObject

+ (void)graduallySetBrightness:(CGFloat)value;
+ (void)graduallyResumeBrightness;
+ (void)applicationDidBecomeActiveHandleBrightness;

@end
