//
//  PlaySoundAndShocking.h
//  YJToolsGather
//
//  Created by YJHou on 16/11/7.
//  Copyright © 2016年 YJHou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PlaySoundAndShocking : NSObject

+ (PlaySoundAndShocking *)sharedInstance;

- (void)playSound;

- (void)playShacking;

/** 销毁音效 */
- (void)disposeSystemSoundId;

@end
