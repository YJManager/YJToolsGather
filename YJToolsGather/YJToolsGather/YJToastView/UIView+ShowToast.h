//
//  UIView+ShowToast.h
//  YJToolsGather
//
//  Created by YJHou on 2016/11/24.
//  Copyright © 2016年 YJHou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (ShowToast)

/**< 在中间显示 */
- (void)showTipViewAtCenter:(NSString *)indiTitle;

/**< 布局v方向 */
- (void)showTipViewAtCenter:(NSString*)indiTitle posY:(CGFloat)y;

/**< 规定时间 */
- (void)showTipViewAtCenter:(NSString *)indiTitle timer:(int)aTimer;

/**< V布局 */
- (void)showTipViewAtCenter:(NSString *)indiTitle message:(NSString *)message posY:(CGFloat)y;
@end
