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

static NSMutableDictionary const * _soundIdDic_;

@interface PlaySoundAndShocking ()

@end

@implementation PlaySoundAndShocking

+ (void)initialize{
    _soundIdDic_ = [NSMutableDictionary dictionary];
}

+ (void)playSoundFileName:(NSString *)fileName{
    
    if (!fileName) return;
    
    SystemSoundID soundId = [[_soundIdDic_ objectForKey:fileName] unsignedIntValue];
    if (!soundId) {
        NSString *soundFile = [[NSBundle mainBundle] pathForResource:fileName ofType:nil];
        if (!soundFile) return;
        AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath:soundFile], &soundId);
        if (soundId) {
            AudioServicesPlaySystemSound(soundId);
            //    AudioServicesPlayAlertSound(soundId); // 会震动
            // 保存
            [_soundIdDic_ setObject:@(soundId) forKey:fileName];
        }
    }else{
//        AudioServicesPlaySystemSound(soundId);
        AudioServicesPlayAlertSound(soundId); // 会震动
    }
}

+ (void)disposeSoundFileName:(NSString *)fileName{
    
    if (!fileName) return;
    
    SystemSoundID soundId = [[_soundIdDic_ objectForKey:fileName] unsignedIntValue];

    if (!soundId) {
        AudioServicesDisposeSystemSoundID(soundId);
        [_soundIdDic_ removeObjectForKey:fileName];
    }
}

+ (void)playShacking{
    AudioServicesPlaySystemSound (kSystemSoundID_Vibrate);
}

+ (void)playSuccessSound{
    [self playSoundFileName:@"Taito_Carousel.wav"];
}

+ (void)playKongFuSound{
    [self playSoundFileName:@"shake_sound_kongfu.mp3"];
}



@end
