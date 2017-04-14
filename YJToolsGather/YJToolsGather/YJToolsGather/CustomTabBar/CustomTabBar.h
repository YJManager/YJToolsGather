//
//  CustomTabBar.h
//  3ikidsParents
//
//  Created by lilei on 14/12/22.
//  Copyright (c) 2014年 Lilei. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CustomTabBar;
@protocol CustomTabBarDelegate <NSObject>
@optional
- (void)customTabBar:(CustomTabBar *)tabBar didClickButtonFrom:(NSInteger)from to:(NSInteger)to;
@end
@interface CustomTabBar : UIView

/** 代理 */
@property (nonatomic, weak) id<CustomTabBarDelegate> delegate;

/**
 *  添加tabBar按钮
 */
- (void)addTabBarButton:(UITabBarItem *)item;
- (void)setSelectedIndex:(NSInteger)selectedIndex;
@end
