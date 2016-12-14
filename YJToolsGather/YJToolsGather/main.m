//
//  main.m
//  YJToolsGather
//
//  Created by YJHou on 16/10/12.
//  Copyright © 2016年 YJHou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

CFAbsoluteTime mainStartTime;
int main(int argc, char * argv[]) {
    
    mainStartTime = CFAbsoluteTimeGetCurrent();
    @autoreleasepool {
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
