//
//  PlaySoundAndShocking.h
//  YJToolsGather
//
//  Created by YJHou on 16/11/7.
//  Copyright © 2016年 YJHou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PlaySoundAndShocking : NSObject

+ (void)playSoundFileName:(NSString *)fileName;
+ (void)disposeSoundFileName:(NSString *)fileName;
+ (void)playShacking;


+ (void)playSuccessSound;
+ (void)playKongFuSound;


@end
