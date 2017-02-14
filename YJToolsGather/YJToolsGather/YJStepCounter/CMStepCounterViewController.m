//
//  CMStepCounterViewController.m
//  YJToolsGather
//
//  Created by YJHou on 2017/2/14.
//  Copyright © 2017年 YJHou. All rights reserved.
//

#import "CMStepCounterViewController.h"
#import <CoreMotion/CoreMotion.h>

@interface CMStepCounterViewController ()

@property (nonatomic, strong) UILabel *showOneLabel; /**< 显示label */
@property (nonatomic, strong) UILabel *showTwoLabel; /**< 显示 */

@property (nonatomic, strong) CMPedometer *stepCounter;
@property (nonatomic, strong) CMMotionActivityManager *activityManager;
@property (nonatomic, strong) NSOperationQueue *operationQueue;

@end

@implementation CMStepCounterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    if (!([CMPedometer isStepCountingAvailable] || [CMMotionActivityManager isActivityAvailable])) {
        
        NSString *msg = @"仅仅支持M7处理器";
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"不能使用"
                                                        message:msg
                                                       delegate:nil
                                              cancelButtonTitle:@"好"
                                              otherButtonTitles:nil];
        [alert show];
        
        return;
    }
    
    __weak typeof(self) weakSelf = self;
    
    self.operationQueue = [[NSOperationQueue alloc] init];
    
    //更新label
    if ([CMPedometer isStepCountingAvailable]) {
        
        self.stepCounter = [[CMPedometer alloc] init];
        
        [self.stepCounter startPedometerUpdatesFromDate:[NSDate date] withHandler:^(CMPedometerData * _Nullable pedometerData, NSError * _Nullable error) {
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^ { // 全局队列异步
                if (error) {
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"不能使用"
                                                                    message:@"有错误"
                                                                   delegate:nil
                                                          cancelButtonTitle:@"好"
                                                          otherButtonTitles:nil];
                    [alert show];
                }else{
                    NSString *showString = [NSString stringWithFormat:@"startDate=%@, endDate=%@, numberOfSteps=%@, floorsAscended=%@, floorsDescended=%@", pedometerData.startDate, pedometerData.endDate, pedometerData.numberOfSteps, pedometerData.floorsAscended, pedometerData.floorsDescended];
                    if (showString.length == 0) {
                        showString = @"--";
                    }
                    weakSelf.showOneLabel.text = showString;
                }
            });
        }];
    }
    
    // 状态
    if ([CMMotionActivityManager isActivityAvailable]) {
        
        self.activityManager = [[CMMotionActivityManager alloc] init];
        
        [self.activityManager startActivityUpdatesToQueue:self.operationQueue
                                              withHandler:
         ^(CMMotionActivity *activity) {
             
             dispatch_async(dispatch_get_main_queue(), ^{
                 
                 
                 NSString *status = [weakSelf statusForActivity:activity];
                 NSString *confidence = [weakSelf stringFromConfidence:activity.confidence];
                 
                 NSString *showString = [NSString stringWithFormat:@"状态:%@ 速度:%@", status, confidence];
                 self.showTwoLabel.text = showString;

             });
         }];
    }
    
}

- (NSString *)statusForActivity:(CMMotionActivity *)activity {
    
    NSMutableString *status = @"".mutableCopy;
    
    if (activity.stationary) {
        
        [status appendString:@"没动"];
    }
    
    if (activity.walking) {
        
        if (status.length) [status appendString:@", "];
        
        [status appendString:@"正在步行"];
    }
    
    if (activity.running) {
        
        if (status.length) [status appendString:@", "];
        
        [status appendString:@"正在跑"];
    }
    
    if (activity.automotive) {
        
        if (status.length) [status appendString:@", "];
        
        [status appendString:@"在一个交通工具上"];
    }
    
    if (activity.unknown || !status.length) {
        
        [status appendString:@"未知"];
    }
    
    return status;
}
- (NSString *)stringFromConfidence:(CMMotionActivityConfidence)confidence {
    
    switch (confidence) {
            
        case CMMotionActivityConfidenceLow:
            
            return @"低";
            
        case CMMotionActivityConfidenceMedium:
            
            return @"中等";
            
        case CMMotionActivityConfidenceHigh:
            
            return @"高";
            
        default:
            
            return nil;
    }
}


#pragma mark - Lazy
- (UILabel *)showOneLabel{
    if (!_showOneLabel) {
        _showOneLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 120, 160, 44)];
        [self.view addSubview:_showOneLabel];
    }
    return _showOneLabel;
}

- (UILabel *)showTwoLabel{
    if (!_showTwoLabel) {
        _showTwoLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 180, 160, 44)];
        [self.view addSubview:_showTwoLabel];
    }
    return _showTwoLabel;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
