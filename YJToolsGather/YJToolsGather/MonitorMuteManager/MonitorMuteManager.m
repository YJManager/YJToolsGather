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

- (void)playbackComplete {
    if ([(id)self.delegate respondsToSelector:@selector(isMuted:)]) {
        //        NSLog(@"playbackComplete >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>\nsoundDuration    %f",soundDuration);
        // If playback is far less than 100ms then we know the device is muted
        if (_soundDuration < 0.001) {
            [self.delegate isMuted:YES];
        }
        else {
            [self.delegate isMuted:NO];
        }
    }
    [self.playbackTimer invalidate];
    self.playbackTimer = nil;
    
    
}

static void soundCompletionCallback (SystemSoundID mySSID, void* myself) {
    AudioServicesRemoveSystemSoundCompletion (mySSID);
    [[MonitorMuteManager sharedInstance] playbackComplete];
}

- (void)incrementTimer {
    self.soundDuration = self.soundDuration + 0.001;
    //    NSLog(@"incrementTimer>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>\nsoundDuration    %f",soundDuration);
}

- (void)detectMuteSwitch {
#if TARGET_IPHONE_SIMULATOR
    // The simulator doesn't support detection and can cause a crash so always return muted
    if ([(id)self.delegate respondsToSelector:@selector(isMuted:)]) {
        [self.delegate isMuted:YES];
    }
    return;
#endif
#if !TARGET_IPHONE_SIMULATOR
    // iOS 5+ doesn't allow mute switch detection using state length detection
    // So we need to play a blank 100ms file and detect the playback length
    _soundDuration = 0.0;
    CFURLRef		soundFileURLRef;
    SystemSoundID	soundFileObject;
    
    // Get the main bundle for the app
    CFBundleRef mainBundle;
    mainBundle = CFBundleGetMainBundle();
    
    // Get the URL to the sound file to play
    soundFileURLRef  =	CFBundleCopyResourceURL(
                                                mainBundle,
                                                CFSTR ("detection"),
                                                CFSTR ("aiff"),
                                                NULL
                                                );
    
    // Create a system sound object representing the sound file
    AudioServicesCreateSystemSoundID (
                                      soundFileURLRef,
                                      &soundFileObject
                                      );
    
    AudioServicesAddSystemSoundCompletion (soundFileObject,NULL,NULL,
                                           soundCompletionCallback,
                                           (void*) CFBridgingRetain(self));
    
    // Start the playback timer
    self.playbackTimer = [NSTimer scheduledTimerWithTimeInterval:0.010 target:self selector:@selector(incrementTimer) userInfo:nil repeats:YES];
    //    NSLog(@"playbackTimer>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>\nsoundDuration    %f",soundDuration);
    // Play the sound
    AudioServicesPlaySystemSound(soundFileObject);
    return;
#endif
    
}

@end
