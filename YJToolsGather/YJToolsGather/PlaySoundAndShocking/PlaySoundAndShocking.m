//
//  PlaySoundAndShocking.m
//  YJToolsGather
//
//  Created by YJHou on 16/11/7.
//  Copyright © 2016年 YJHou. All rights reserved.
//

#import "PlaySoundAndShocking.h"
#import <AudioToolbox/AudioToolbox.h>

@implementation PlaySoundAndShocking


+ (void)playSoundAndShacking:(BOOL)isSucceed
{
    
    NSNumber *isSound = @1;
    
    NSNumber *isShacking = @1;
    
    if ([isSound boolValue])
    {
        if (isSucceed == 1)
        {
            SystemSoundID soundID;
            NSString *soundFile = [[NSBundle mainBundle]pathForResource:@"soundSucceed" ofType:@"wav"];
            AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath:soundFile], &soundID);
            AudioServicesPlaySystemSound(soundID);
        }
        else
        {
            SystemSoundID soundID;
            NSString *soundFile = [[NSBundle mainBundle]pathForResource:@"Taito_Carousel" ofType:@"wav"];
            AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath:soundFile], &soundID);
            AudioServicesPlaySystemSound(soundID);
        }
    }
    if ([isShacking boolValue])
    {
        AudioServicesPlaySystemSound (kSystemSoundID_Vibrate);
    }
}

+ (void)playSound
{
    SystemSoundID soundID;
    NSString *soundFile = [[NSBundle mainBundle]pathForResource:@"soundSucceed" ofType:@"wav"];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath:soundFile], &soundID);
    AudioServicesPlaySystemSound(soundID);
}

+ (void)playShacking
{
    AudioServicesPlaySystemSound (kSystemSoundID_Vibrate);
}



@end
