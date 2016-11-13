//
//  YJSwitch.m
//  YJToolsGather
//
//  Created by YJHou on 2016/11/13.
//  Copyright © 2016年 YJHou. All rights reserved.
//

#import "YJSwitch.h"
#import "UIImage+YJTools.h"

@interface YJSwitch()

@property (nonatomic, strong) UIView *contentView;

@end

@implementation YJSwitch

- (id)init{
    self = [super init];
    if (self) {
        self.clipsToBounds = YES;
        self.frame = CGRectMake(0, 0, 50, 20);
        [self addObserver:self forKeyPath:@"isShowWords" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:NULL];
        
        UIImageView *bgImageView = [[UIImageView alloc] init];
        bgImageView.image = [UIImage streImageNamed:@"login_toggle_bg"];
        bgImageView.frame = self.bounds;
        [self addSubview:bgImageView];
        
        [self addTarget:self action:@selector(touched:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:self.contentView];
        
        [self layoutToggleAnimated:NO];
    }
    return self;
}

- (UIView *)contentView{
    if (!_contentView) {
        _contentView = [[UIView alloc] init];
        _contentView.userInteractionEnabled = NO;
        _contentView.backgroundColor  = [UIColor clearColor];
        _contentView.frame = CGRectMake(-30, 0, 80, 20);
        _contentView.clipsToBounds = YES;
        
        UIImageView *dian = [[UIImageView alloc] init];
        dian.frame = CGRectMake(0, 0, 30, 20);
        dian.contentMode = UIViewContentModeCenter;
        dian.image = [UIImage imageNamed:@"login_toggle_dian.png"];
        [_contentView addSubview:dian];
        
        UIImageView *cycle = [[UIImageView alloc] init];
        cycle.frame = CGRectMake(30.5, 0, 20, 20);
        cycle.image = [UIImage imageNamed:@"login_toggle_cycle.png"];
        [_contentView addSubview:cycle];
        
        UIImageView *abc = [[UIImageView alloc] init];
        abc.frame = CGRectMake(50, 0, 30, 20);
        abc.contentMode = UIViewContentModeCenter;
        abc.image = [UIImage imageNamed:@"login_toggle_abc.png"];
        [_contentView addSubview:abc];
    }
    return _contentView;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    if ([keyPath isEqualToString:@"isShowWords"]){
        BOOL _oldValue = [[change objectForKey:NSKeyValueChangeOldKey] boolValue];
        BOOL _newValue = [[change objectForKey:NSKeyValueChangeNewKey] boolValue];
        
        if (_newValue != _oldValue){
            [self sendActionsForControlEvents:UIControlEventValueChanged];
        }
    }
}

- (void)touched:(id)sender{
    self.isShowWords = !self.isShowWords;
    [self layoutToggleAnimated:YES];
}

- (void)layoutToggleAnimated:(BOOL)animated{
    void(^layout_M)(void) = ^{
        
        if (self.isShowWords){
            
            CGRect contentViewFrame = self.contentView.frame;
            contentViewFrame.origin.x = -30.0f;
            self.contentView.frame = contentViewFrame;
        }else{
            CGRect contentViewFrame = self.contentView.frame;
            contentViewFrame.origin.x = 0.0f;
            self.contentView.frame = contentViewFrame;
        }
    };
    
    if (animated){
        [UIView animateWithDuration:0.2 delay:0. options:UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             layout_M();
                         } completion:NULL];
    } else{
        layout_M();
    }
}

- (void)dealloc{
    [self removeObserver:self forKeyPath:@"isShowWords"];
}


@end
