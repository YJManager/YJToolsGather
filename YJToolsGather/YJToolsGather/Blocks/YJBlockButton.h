//
//  YJBlockButton.h
//  YJBlockButton
//
//  Created by YJHou on 16/5/4.
//  Copyright © 2016年 YJHou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YJBlockButton : UIButton

/** 创建btn并添加到父视图 并带有block回调 */
+ (__kindof UIButton *)buttonWithFrame:(CGRect)frame addToSuperview:(UIView *)superview clickBlock:(void(^)())clickBlock;

+ (__kindof UIButton *)buttonWithFrame:(CGRect)frame norImgName:(NSString *)norImgName hImgName:(NSString *)hImgName addToSuperview:(UIView *)superview clickBlock:(void(^)())clickBlock;

+ (__kindof UIButton *)buttonWithFrame:(CGRect)frame clickBlock:(void(^)())clickBlock;

+ (__kindof UIButton *)buttonWithClickBlock:(void(^)())clickBlock;

@end
