//
//  YJBlockBarButtonItem.h
//  YJBlockButton
//
//  Created by YJHou on 16/5/4.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YJBlockBarButtonItem : UIBarButtonItem

+ (instancetype)barButtonItemWithTitle:(NSString *)title clickBlock:(void(^)())clickBlock;

+ (instancetype)barButtonItemWithImage:(UIImage *)image clickBlock:(void(^)())clickBlock;

+ (instancetype)barButtonItemWithBarButtonSystemItem:(UIBarButtonSystemItem)systemItem clickBlock:(void(^)())clickBlock;

+ (instancetype)barButtonItemWithCustomView:(UIView *)customView;

+ (instancetype)barButtonItemWithCustomView:(UIView *)customView clickBlock:(void(^)())clickBlock;

@end
