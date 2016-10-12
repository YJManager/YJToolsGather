//
//  MonitorMuteManager.h
//  YJToolsGather
//
//  Created by YJHou on 16/10/12.
//  Copyright © 2016年 YJHou. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MonitorMuteManagerDelegate <NSObject>

@optional
- (void)volumeModeMuted:(BOOL)muted;

@end

@interface MonitorMuteManager : NSObject

+ (MonitorMuteManager *)sharedInstance;

@property (nonatomic, weak) id<MonitorMuteManagerDelegate> delegate;

- (void)detectMuteSwitch;

@end
