//
//  YJBlockButton.m
//  YJBlockButton
//
//  Created by YJHou on 16/5/4.
//  Copyright © 2016年 YJHou. All rights reserved.
//

#import "YJBlockButton.h"

@interface YJBlockButton ()

@property (nonatomic, strong) void(^clickBlock)();

@end

@implementation YJBlockButton

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self _setupButtonBasic];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self _setupButtonBasic];
}

- (void)_setupButtonBasic{
    [self addTarget:self action:@selector(supperBtnTouchUpInsideClickAction) forControlEvents:UIControlEventTouchUpInside];
}

+ (__kindof UIButton *)buttonWithFrame:(CGRect)frame addToSuperview:(UIView *)superview clickBlock:(void(^)())clickBlock{
    
    YJBlockButton *btn = [YJBlockButton new];
    btn.clickBlock = clickBlock;
    
    if (!CGRectIsNull(frame)) {
        btn.frame = frame;
    }
    
    if (superview) {
        [superview addSubview:btn];
    }
    return btn;
}


+ (__kindof UIButton *)buttonWithFrame:(CGRect)frame norImgName:(NSString *)norImgName hImgName:(NSString *)hImgName addToSuperview:(UIView *)superview clickBlock:(void(^)())clickBlock{
    
    YJBlockButton *btn = [YJBlockButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:[UIImage imageNamed:norImgName] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:hImgName] forState:UIControlStateHighlighted];
    btn.clickBlock = clickBlock;
    
    if (!CGRectIsNull(frame)) {
        btn.frame = frame;
    }
    
    if (superview) {
        [superview addSubview:btn];
    }
    return btn;
}

+ (__kindof UIButton *)buttonWithFrame:(CGRect)frame clickBlock:(void(^)())clickBlock{
    return [self buttonWithFrame:frame addToSuperview:nil clickBlock:clickBlock];
}

+ (__kindof UIButton *)buttonWithClickBlock:(void(^)())clickBlock{
    return [self buttonWithFrame:CGRectNull addToSuperview:nil clickBlock:clickBlock];
}

- (void)supperBtnTouchUpInsideClickAction{
    if (_clickBlock) {
        _clickBlock();
    }
}


@end
