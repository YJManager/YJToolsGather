//
//  AppDelegate.m
//  YJToolsGather
//
//  Created by YJHou on 16/10/12.
//  Copyright © 2016年 YJHou. All rights reserved.
//

#import "AppDelegate.h"
#import "YJNavigationController.h"
#import "YJMainViewController.h"

static CGFloat const launchTimeValue = 3.0f;
extern CFAbsoluteTime mainStartTime;
CFAbsoluteTime StartTime;
@interface AppDelegate (){
    dispatch_queue_t  _queue;
}

@end

@implementation AppDelegate

+ (void)load{
    [super load];
    StartTime = CFAbsoluteTimeGetCurrent();
    NSLog(@"load时间-%f", (CFAbsoluteTimeGetCurrent()));
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    NSLog(@"%f ============ %f", CFAbsoluteTimeGetCurrent(), [[NSDate date] timeIntervalSinceReferenceDate]);
    
    CFTimeInterval launchTimeInterval = fabs((CFAbsoluteTimeGetCurrent()-StartTime));
    CFTimeInterval mainlaunchTimeInterval = fabs((CFAbsoluteTimeGetCurrent()-mainStartTime));
    NSLog(@"启动时间 === %f --- %f", launchTimeInterval, mainlaunchTimeInterval);
    if (launchTimeInterval > launchTimeValue) { // 如果启动时间大于设置
        // Do nothing 你手机配置太低了，买新的吧
    }else{ // 如果启动时间小于设置
//        CFTimeInterval distance = launchTimeValue - launchTimeInterval;
//        [NSThread sleepForTimeInterval:distance];
    }
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    
    YJMainViewController * mianVc = [[YJMainViewController alloc] initWithNibName:@"YJMainViewController" bundle:nil];
    YJNavigationController * mainNav = [[YJNavigationController alloc] initWithRootViewController:mianVc];
    self.window.rootViewController = mainNav;
    
    [self.window makeKeyAndVisible];
    
    _queue = dispatch_queue_create([[NSString stringWithFormat:@"houmanager.%@", self] UTF8String], NULL);
    
//    NSLog(@"_queue = %@", _queue);


    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
 
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the us
}


- (void)applicationWillEnterForeground:(UIApplication *)application {

}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.

}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
