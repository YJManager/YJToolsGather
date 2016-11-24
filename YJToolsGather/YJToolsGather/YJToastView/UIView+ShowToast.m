//
//  UIView+ShowToast.m
//  YJToolsGather
//
//  Created by YJHou on 2016/11/24.
//  Copyright © 2016年 YJHou. All rights reserved.
//

#import "UIView+ShowToast.h"
#import "YJTipView.h"

#define toolViewTag                    0x98751255

@implementation UIView (ShowToast)

- (void)showTipViewAtCenter:(NSString *)indiTitle{
    
    YJTipView *activityView = [self getTipView];
    
    if (activityView) {
        [activityView dismiss:NO];
    }
    
    //默认posY为0,即黄金分割处
    activityView = [[YJTipView alloc] initWithView:self title:nil message:indiTitle posY:0];
    activityView.layer.zPosition = 11;
    activityView.tag = toolViewTag;
    [activityView showWithAnimation:YES];
}

- (void)showTipViewAtCenter:(NSString*)indiTitle posY:(CGFloat)y{
    
    YJTipView *activityView = [self getTipView];
    
    if (activityView) {
        [activityView dismiss:NO];
    }
    activityView = [[YJTipView alloc] initWithView:self title:nil message:indiTitle posY:y];
    activityView.layer.zPosition = 11;
    activityView.tag = toolViewTag;
    
    [activityView showWithAnimation:YES];
}

- (void)showTipViewAtCenter:(NSString *)indiTitle timer:(int)aTimer{//规定时间
    YJTipView *activityView = [self getTipView];
    
    if (activityView) {
        [activityView dismiss:NO];
    }
    //默认posY为0,即黄金分割处
    activityView = [[YJTipView alloc] initWithView:self title:nil message:indiTitle posY:0];
    activityView.layer.zPosition = 11;
    activityView.tag = toolViewTag;
    activityView.showTime = aTimer;
    [activityView showWithAnimation:YES];
}

- (void)showTipViewAtCenter:(NSString *)indiTitle message:(NSString *)message posY:(CGFloat)y{
    YJTipView *activityView = [self getTipView];
    
    if (activityView) {
        [activityView dismiss:NO];
    }
    
    //默认posY为0,即黄金分割处
    activityView = [[YJTipView alloc] initWithView:self title:indiTitle message:message posY:y];
    activityView.layer.zPosition = 11;
    activityView.tag = toolViewTag;
    
    [activityView showWithAnimation:YES];
}


#pragma mark - SettingSupport
- (YJTipView *)getTipView{
    UIView* view = [self viewWithTagNotDeepCounting:toolViewTag];
    if (view != nil && [view isKindOfClass:[YJTipView class]]){
        return (YJTipView *)view;
    }else {
        return nil;
    }
}


- (UIView *)viewWithTagNotDeepCounting:(NSInteger)tag{
    for (UIView *view in self.subviews){
        if (view.tag == tag) {
            return view;
            break;
        }
    }
    return nil;
}

@end
