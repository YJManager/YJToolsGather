//
//  CustomTabBar.m
//  3ikidsParents
//
//  Created by lilei on 14/12/22.
//  Copyright (c) 2014年 Lilei. All rights reserved.
//

#import "CustomTabBar.h"
#import "TabBarButton.h"

#define TabBarBackgroundColor [UIColor whiteColor]

@interface CustomTabBar()
/** 普通按钮 */
@property (nonatomic, strong) TabBarButton *currentSelectedButton;
/** 图片按钮 */
@property (nonatomic, strong) UIImageView *currentSelectedImage;
@end
@implementation CustomTabBar

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        
        [self setupBackgroudColor];
    }
    
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self setupBackgroudColor];
    }
    return self;
}

- (void)setupBackgroudColor
{
    [self setBackgroundColor:TabBarBackgroundColor];
}

#pragma mark - 添加选项卡按钮
- (void)setSelectedIndex:(NSInteger)selectedIndex {
    
    TabBarButton *btn = [self.subviews objectAtIndex:selectedIndex];
    
    self.currentSelectedButton.selected = NO;
    btn.selected = YES;
    self.currentSelectedButton = btn;
}

- (void)addTabBarButton:(UITabBarItem *)item
{
    // 创建按钮
    TabBarButton *tabBarBtn = [[TabBarButton alloc] init];
    tabBarBtn.item = item;
    tabBarBtn.tag = self.subviews.count;

    // 添加监听事件
    [tabBarBtn addTarget:self action:@selector(tabBarButtonClick:) forControlEvents:UIControlEventTouchDown];
    
    [self addSubview:tabBarBtn];
    
    // 默认选中第一个按钮
    if (self.subviews.count == 1) {
        [self tabBarButtonClick:tabBarBtn];
    }
 
#if 0
    UIImageView *imgView = [[UIImageView alloc] initWithImage:item.image];
    imgView.userInteractionEnabled = YES;
    imgView.highlightedImage = item.selectedImage;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageButtonClick:)];
    [imgView addGestureRecognizer:tap];
    imgView.tag = self.subviews.count;
    [self addSubview:imgView];
    
    // 默认选中第一个按钮
    if (self.subviews.count == 1) {
       [self imageButtonClick:tap];
    }
#endif
}

/** 普通按钮点击事件 */
- (void)tabBarButtonClick:(TabBarButton *)selectedButton
{
    if ([self.delegate respondsToSelector:@selector(customTabBar:didClickButtonFrom:to:)]) {
        
        [self.delegate customTabBar:self
                 didClickButtonFrom:self.currentSelectedButton.tag
                                 to:selectedButton.tag];
    }
    
    self.currentSelectedButton.selected = NO;
    selectedButton.selected = YES;
    self.currentSelectedButton = selectedButton;
}

#if 0
/** 图片按钮点击事件 */
- (void)imageButtonClick:(UITapGestureRecognizer *)tap
{
    UIImageView *imgView = (UIImageView *)tap.view;
    if ([self.delegate respondsToSelector:@selector(customTabBar:didClickButtonFrom:to:)]) {
        [self.delegate customTabBar:self didClickButtonFrom:self.currentSelectedImage.tag to:imgView.tag];
    }
    
    self.currentSelectedImage.highlighted = NO;
    imgView.highlighted = YES;
    self.currentSelectedImage = imgView;
}
#endif

#pragma mark - 设置选项卡按钮的布局
- (void)layoutSubviews
{
    [super layoutSubviews];

#if 0
    CGFloat width = ScreenWidth / self.subviews.count;
    CGFloat height = self.frame.size.height;
    CGFloat y = 0;
    [self.subviews enumerateObjectsUsingBlock:^(UIImageView *obj, NSUInteger idx, BOOL *stop) {
        if ([obj isKindOfClass:[UIImageView class]]) {
            CGFloat x = idx * width;
            obj.frame = CGRectMake(x, y, width, height);
        }
    }];
#endif
    
    CGFloat width = kSCREEN_WIDTH / self.subviews.count;
    CGFloat height = self.frame.size.height;
    CGFloat y = 0;
    [self.subviews enumerateObjectsUsingBlock:^(TabBarButton *obj, NSUInteger idx, BOOL *stop) {
        if ([obj isKindOfClass:[TabBarButton class]]) {
            CGFloat x = idx * width;
            obj.frame = CGRectMake(x, y, width, height);
        }
    }];
}
@end
