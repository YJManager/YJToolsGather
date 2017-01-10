//
//  MonitorMuteManager.m
//  YJToolsGather
//
//  Created by YJHou on 16/10/12.
//  Copyright © 2016年 YJHou. All rights reserved.
//

#import "MonitorMuteManager.h"
#import <AudioToolbox/AudioToolbox.h>

@interface MonitorMuteManager ()

@property (nonatomic, assign) CGFloat soundDuration;
@property (nonatomic, strong) NSTimer * playbackTimer;

@end

@implementation MonitorMuteManager

+ (MonitorMuteManager *)sharedInstance{
    static MonitorMuteManager * _manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _manager = [[MonitorMuteManager alloc] init];
    });
    return _manager;
}

- (void)detectMuteSwitch {

    if (_soundDuration != 0) return;
    
    if (TARGET_IPHONE_SIMULATOR) {
        [NSException exceptionWithName:@"Simulator" reason:@"The simulator doesn't support detection" userInfo:nil];
    }else{
        
        CFBundleRef mainBundle = CFBundleGetMainBundle();

        SystemSoundID	soundFileObject;

        CFURLRef soundFileURLRef = CFBundleCopyResourceURL(mainBundle, CFSTR ("detection"), CFSTR ("aiff"), NULL);
        
        AudioServicesCreateSystemSoundID (soundFileURLRef, &soundFileObject);
        
        AudioServicesAddSystemSoundCompletion (soundFileObject, NULL, NULL, soundCompletionCallback, (void*) CFBridgingRetain(self));
        
        if (self.playbackTimer) {
            [self.playbackTimer invalidate];
            self.playbackTimer = nil;
        }
        
        self.playbackTimer = [NSTimer scheduledTimerWithTimeInterval:0.010 target:self selector:@selector(incrementTimer) userInfo:nil repeats:YES];
        AudioServicesPlaySystemSound(soundFileObject);
    }
}

- (void)incrementTimer {
    self.soundDuration = self.soundDuration + 0.001;
}

static void soundCompletionCallback (SystemSoundID mySSID, void* myself) {
    AudioServicesRemoveSystemSoundCompletion (mySSID);
    [[MonitorMuteManager sharedInstance] playbackComplete];
}

- (void)playbackComplete {
    if (self.delegate && [self.delegate respondsToSelector:@selector(volumeModeMuted:)]) {
        if (_soundDuration < 0.001) { // 100ms
            [self.delegate volumeModeMuted:YES];
        }else {
            [self.delegate volumeModeMuted:NO];
        }
    }
    [self.playbackTimer invalidate];
    self.playbackTimer = nil;
    _soundDuration = 0.0;
}

- (CGFloat)getBatteryQuantity {
    [UIDevice currentDevice].batteryMonitoringEnabled = YES;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIDevice currentDevice].batteryMonitoringEnabled = NO;
    });
    return [[UIDevice currentDevice] batteryLevel];
}


@end
