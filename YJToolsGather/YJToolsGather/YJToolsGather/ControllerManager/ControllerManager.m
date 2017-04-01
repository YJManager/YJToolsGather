//
//  ControllerManager.m
//  YJToolsGather
//
//  Created by YJHou on 2017/4/1.
//  Copyright © 2017年 Houmanager. All rights reserved.
//

#import "ControllerManager.h"

static CGFloat _currentBrightness;
static CGFloat _setValueBrightness;
static BOOL _isChangedBrightness; /**< 已经改变了亮度 默认是NO */
static NSOperationQueue *_queue;

@interface ControllerManager ()

@end

@implementation ControllerManager

+ (void)initialize{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(saveDefaultBrightness) name:UIScreenBrightnessDidChangeNotification object:nil];
    [self saveDefaultBrightness];
}

+ (void)saveDefaultBrightness{
    _currentBrightness = [UIScreen mainScreen].brightness;
}


+ (void)graduallySetBrightness:(CGFloat)value{
    _setValueBrightness = value;
    [self _graduallySetBrightness:_setValueBrightness changedBrightness:YES];
}

+ (void)graduallyResumeBrightness{
    [self _graduallySetBrightness:_currentBrightness changedBrightness:YES];
}

+ (void)applicationDidBecomeActiveHandleBrightness{
    
    if (_isChangedBrightness) {
        [self _graduallySetBrightness:_setValueBrightness changedBrightness:YES];
    }else{
        [self graduallyResumeBrightness];
    }
}

+ (void)_graduallySetBrightness:(CGFloat)value changedBrightness:(BOOL)changedBrightness{
    
    if (!_queue) {
        _queue = [[NSOperationQueue alloc] init];
        _queue.maxConcurrentOperationCount = 1;
    }
    [_queue cancelAllOperations];
    
    CGFloat brightness = [UIScreen mainScreen].brightness;
    
    _isChangedBrightness = changedBrightness;
    
    CGFloat step = 0.005 * ((value > brightness) ? 1 : -1);
    int times = fabs((value - brightness) / 0.005);
    for (CGFloat i = 1; i < times + 1; i++) {
        [_queue addOperationWithBlock:^{
            [NSThread sleepForTimeInterval:1 / 180.0];
            //            [UIScreen mainScreen].brightness = brightness + i * step;
            [UIScreen mainScreen].brightness = (i == times) ? ((value > brightness) ? value : _currentBrightness) :(brightness + i * step);
        }];
    }
}

@end
