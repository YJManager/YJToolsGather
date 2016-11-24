//
//  YJTipView.h
//  YJToolsGather
//
//  Created by YJHou on 2016/11/24.
//  Copyright © 2016年 YJHou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YJTipView : UIView

/*!
 @property      showTime
 @abstract      展示的时间，可设置
 */
@property (nonatomic, assign) CGFloat showTime;

/*!
 @property      dimBackground
 @abstract      是否显示背景渐变色
 */
@property (nonatomic, assign) BOOL dimBackground;

/*!
 @method        initWithView:message:posY:
 @abstract      初始化方法
 @param         view  所在的view
 @param         message  展示内容
 @param         posY  离superView顶部的距离
 @result        YJTipView的对象
 */

- (instancetype)initWithView:(UIView *)view title:(NSString *)title message:(NSString *)message posY:(CGFloat)posY;

/*!
 @method        show
 @abstract      弹出
 */
- (void)showWithAnimation:(BOOL)animation;

/*!
 @method        dismiss:
 @abstract      消失
 @param         animation 消失时是否使用动画
 */
- (void)dismiss:(BOOL)animation;

@end
