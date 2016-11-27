//
//  PlaySoundAndShocking.m
//  YJToolsGather
//
//  Created by YJHou on 16/11/7.
//  Copyright © 2016年 YJHou. All rights reserved.
//
/**
   支持的格式：wav-ACC-ALAC-(HE-AAC)-iLBC-IMA4-(Linea PCM)-MP3-(µ-law and a-law)-CAF 使用非压缩格式(AIFF)或(CAF)减少系统消耗,除了(HE-AAC)都可软件解码，硬件解码的格式有 ACC、ALAC、(HE-AAC)、MP3、CAF
   不支持的：ogg
 
 
  格式转换：
        1.转换为AIFF
          afconvert -f AIFF -d I8 fileName
        2.装换为CAF
         afconvert -f caff -d aac -b 32000 fileName
        3.批量转换
         find . -name'*mp3' -exec afconvert -f caff -d aac -b 32000 {}\;
 
 */

#import "PlaySoundAndShocking.h"
#import <AudioToolbox/AudioToolbox.h>

@interface PlaySoundAndShocking ()

@property (nonatomic, assign) SystemSoundID successSoundId; /** 成功的音效Id */
@property (nonatomic, assign) SystemSoundID kongfuSoundId; /** kongfu的音效Id */


@end

@implementation PlaySoundAndShocking

+ (PlaySoundAndShocking *)sharedInstance{
    static PlaySoundAndShocking * _playManager_ = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _playManager_ = [[PlaySoundAndShocking alloc] init];
    });
    return _playManager_;
}

- (void)playSound{
    AudioServicesPlaySystemSound(self.successSoundId);
//    AudioServicesPlayAlertSound(self.successSoundId); // 会震动
}

- (void)playShacking{
    AudioServicesPlaySystemSound (kSystemSoundID_Vibrate);
}

#pragma mark - Lazy -
- (SystemSoundID)successSoundId{
    if (!_successSoundId) {
        NSString *soundFile = [[NSBundle mainBundle]pathForResource:@"soundSucceed" ofType:@"wav"];
        AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath:soundFile], &_successSoundId);
    }
    return _successSoundId;
}

- (SystemSoundID)kongfuSoundId{
    if (!_kongfuSoundId) {
        NSString *soundFile = [[NSBundle mainBundle]pathForResource:@"shake_sound_kongfu" ofType:@"mp3"];
        AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath:soundFile], &_kongfuSoundId);
    }
    return _kongfuSoundId;
}

- (void)disposeSystemSoundId{
    AudioServicesDisposeSystemSoundID(self.successSoundId);
    self.successSoundId = 0;
}



@end
