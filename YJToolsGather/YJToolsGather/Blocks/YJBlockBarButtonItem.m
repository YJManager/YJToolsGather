//
//  YJBlockBarButtonItem.m
//  YJBlockButton
//
//  Created by YJHou on 16/5/4.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "YJBlockBarButtonItem.h"

@interface YJBlockBarButtonItem ()

@property (nonatomic, strong) void(^clickBlock)();
@property (nonatomic, strong) UITapGestureRecognizer *tapGesture;

@end

@implementation YJBlockBarButtonItem

- (instancetype)initWithTitle:(NSString *)title{
    self = [super initWithTitle:title style:UIBarButtonItemStylePlain target:nil action:nil];
    [self _setupBarButtonBasic];
    return self;
}

- (instancetype)initWithBarButtonSystemItem:(UIBarButtonSystemItem)systemItem{
    self = [super initWithBarButtonSystemItem:systemItem target:nil action:nil];
    [self _setupBarButtonBasic];
    return self;
}

- (instancetype)initWithImage:(UIImage *)image {
    self = [super initWithImage:image style:UIBarButtonItemStylePlain target:nil action:nil];
    [self _setupBarButtonBasic];
    return self;
}

- (void)_setupBarButtonBasic{
    self.target = self;
    self.action = @selector(_clickAction);
}

- (void)_clickAction{
    if (self.clickBlock) {
        self.clickBlock();
    }
}

- (instancetype)initWithCustomView:(UIView *)customView clickBlock:(void(^)())clickBlock{
    self = [super initWithCustomView:customView];
    
    if (clickBlock) {
        self.tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureRecognizer:)];
        [customView addGestureRecognizer:self.tapGesture];
    }
    self.clickBlock = clickBlock;
    return self;
}

- (void)tapGestureRecognizer:(UITapGestureRecognizer *)tapGesture{
    [self _clickAction];
}

+ (instancetype)barButtonItemWithTitle:(NSString *)title clickBlock:(void(^)())clickBlock{
    YJBlockBarButtonItem *item = [[YJBlockBarButtonItem alloc] initWithTitle:title];
    item.clickBlock = clickBlock;
    return item;
}

+ (instancetype)barButtonItemWithImage:(UIImage *)image clickBlock:(void(^)())clickBlock{
    YJBlockBarButtonItem *item = [[YJBlockBarButtonItem alloc] initWithImage:image];
    item.clickBlock = clickBlock;
    return item;
}

+ (instancetype)barButtonItemWithBarButtonSystemItem:(UIBarButtonSystemItem)systemItem clickBlock:(void(^)())clickBlock{
    YJBlockBarButtonItem *item = [[YJBlockBarButtonItem alloc] initWithBarButtonSystemItem:systemItem];
    item.clickBlock = clickBlock;
    return item;
}

+ (instancetype)barButtonItemWithCustomView:(UIView *)customView{
    return [[self class] barButtonItemWithCustomView:customView clickBlock:nil];
}

+ (instancetype)barButtonItemWithCustomView:(UIView *)customView clickBlock:(void(^)())clickBlock{
    YJBlockBarButtonItem *item = [[YJBlockBarButtonItem alloc] initWithCustomView:customView clickBlock:clickBlock];
    
    return item;
}

- (void)dealloc {
    if (self.customView && _tapGesture) {
        [self.customView removeGestureRecognizer:_tapGesture];
    }
}

@end
