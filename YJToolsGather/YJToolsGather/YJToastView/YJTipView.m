//
//  YJTipView.m
//  YJToolsGather
//
//  Created by YJHou on 2016/11/24.
//  Copyright © 2016年 YJHou. All rights reserved.
//

#import "YJTipView.h"

static CGFloat const showWidth = 160.0f;

@interface YJTipView ()

@property (nonatomic, strong) UIView  * fatherView;
@property (nonatomic, strong) UILabel * titleLabel;
@property (nonatomic, strong) UILabel * messageLabel;
@property (nonatomic, strong) NSTimer *dlgTimer;

@property (nonatomic, assign) CGFloat posY;

@property (nonatomic, copy) NSString * titleString;
@property (nonatomic, copy) NSString * messageString;

@end

@implementation YJTipView

- (instancetype)initWithView:(UIView *)view title:(NSString *)title message:(NSString *)message posY:(CGFloat)posY{
    self = [super initWithFrame:view.bounds];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.fatherView = view;
        self.titleString = title;
        self.messageString = message;
        self.posY = posY;
        self.dimBackground = NO;
        // 每个字0.3s
        self.showTime = ([message length] + [title length]) * 0.3;
        self.showTime = _showTime > 3?_showTime:3;
    }
    return self;
}

- (void)showWithAnimation:(BOOL)animation{
    [self.fatherView addSubview:self];
    if (animation) {
        self.alpha = 0;
        [UIView animateWithDuration:0.3 animations:^{
            self.alpha = 1;
        }];
    }
    self.dlgTimer = [NSTimer scheduledTimerWithTimeInterval:_showTime target:self selector:@selector(dismissView) userInfo:nil repeats:NO];
}

- (void)dismissView{
    [self dismiss:YES];
}

- (void)dismiss:(BOOL)animation{
    if (animation) {
        [UIView animateWithDuration:0.2f animations:^{
                             self.alpha = 0;
                         }completion:^(BOOL finished){
                             [self.dlgTimer invalidate];
                             self.dlgTimer = nil;
                             [self removeFromSuperview];
                         }];
    }else{
        [self.dlgTimer invalidate];
        self.dlgTimer = nil;
        [self removeFromSuperview];
    }
}

- (void)drawRect:(CGRect)rect{
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    // 1.无title
    if (self.titleString.length == 0){
        
        CGSize messagSize = [self sizeAutoToFitWithString:self.messageString width:showWidth font:self.messageLabel.font];
        CGSize maskSize = CGSizeMake(messagSize.width + 40, messagSize.height + 20);
        
        //计算框的center
        CGFloat centerY = 0;
        if (_posY){
            centerY = _posY + maskSize.height;
        }else{
            centerY = 0.382 * self.frame.size.height;
        }
        
        CGRect messagFrame = CGRectMake(self.frame.size.width * 0.5 - messagSize.width * 0.5, centerY - messagSize.height * 0.5, messagSize.width, messagSize.height);
        CGRect maskFrame = CGRectMake(self.frame.size.width * 0.5 - maskSize.width * 0.5, centerY - maskSize.height * 0.5, maskSize.width, maskSize.height);
        
        if (self.dimBackground) {
            
            size_t gradLocationsNum = 2;
            CGFloat gradLocations[2] = {0.0f, 1.0f};
            CGFloat gradColors[8] = {0.0f,0.0f,0.0f,0.0f,0.0f,0.0f,0.0f,0.6f};
            
            CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
            CGGradientRef gradient = CGGradientCreateWithColorComponents(colorSpace, gradColors, gradLocations, gradLocationsNum);
            CGColorSpaceRelease(colorSpace);
            
            CGPoint gradCenter = CGPointMake(self.frame.size.width * 0.5,  centerY);
            //Gradient radius
            //float gradRadius =  (self.bounds.size.height-_posY)*2;
            float gradRadius = 350;
            CGContextDrawRadialGradient (context, gradient, gradCenter, 0, gradCenter, gradRadius, kCGGradientDrawsAfterEndLocation);
            CGGradientRelease(gradient);
        }
        
        addRoundedRectToPath(context, maskFrame, 3.0f, 3.0f);
        
        CGFloat black[4] = {0.0, 0.0, 0.0, 0.7f};
        CGContextSetFillColor(context, black);
        CGContextFillPath(context);
        
        self.messageLabel.frame = messagFrame;
        self.messageLabel.text = self.messageString;
        [self addSubview:self.messageLabel];
    } else{
        //title的size
        CGSize titleSize = CGSizeMake(showWidth, 20);
        self.messageLabel.font = [UIFont systemFontOfSize:16.0f];
        //计算文字的size
        CGSize messagSize = [self sizeAutoToFitWithString:self.messageString width:showWidth font:self.messageLabel.font];
        
        CGSize maskSize = CGSizeMake(showWidth + 40, titleSize.height + messagSize.height + 30);
        
        //计算框的center
        CGFloat centerY = 0;
        if (_posY){
            centerY = _posY + maskSize.height;
        }else{
            centerY = 0.382 * self.frame.size.height;
        }
        
        CGRect maskFrame = CGRectMake(self.frame.size.width * 0.5 - maskSize.width/2, centerY - maskSize.height/2, maskSize.width, maskSize.height);
        CGRect titleFrame = CGRectMake(self.frame.size.width * 0.5 - titleSize.width/2, maskFrame.origin.y+13, titleSize.width, titleSize.height);
        CGRect labelFrame = CGRectMake(self.frame.size.width * 0.5 - messagSize.width/2, CGRectGetMaxY(titleFrame)+5, messagSize.width, messagSize.height);
        
        if (_dimBackground) {
            
            size_t gradLocationsNum = 2;
            CGFloat gradLocations[2] = {0.0f, 1.0f};
            CGFloat gradColors[8] = {0.0f,0.0f,0.0f,0.0f,0.0f,0.0f,0.0f,0.6f};
            CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
            CGGradientRef gradient = CGGradientCreateWithColorComponents(colorSpace, gradColors, gradLocations, gradLocationsNum);
            CGColorSpaceRelease(colorSpace);
            
            //Gradient center
            CGPoint gradCenter = CGPointMake(self.frame.size.width * 0.5,  centerY);
            //Gradient radius
            //float gradRadius =  (self.bounds.size.height-_posY)*2;
            float gradRadius = 350;
            //Gradient draw
            CGContextDrawRadialGradient (context, gradient, gradCenter,
                                         0, gradCenter, gradRadius,
                                         kCGGradientDrawsAfterEndLocation);
            CGGradientRelease(gradient);
        }
        
        addRoundedRectToPath(context, maskFrame, 3.0f, 3.0f);
        
        CGFloat black[4] = {0.0, 0.0, 0.0, 0.7f};
        CGContextSetFillColor(context, black);
        CGContextFillPath(context);
        
        self.titleLabel.text = self.titleString;
        self.titleLabel.frame = titleFrame;
        [self addSubview:self.titleLabel];
        
        self.messageLabel.frame = labelFrame;
        self.messageLabel.text = self.messageString;
        [self addSubview:self.messageLabel];
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self dismiss:YES];
}



#pragma mark - Lazy -
- (UILabel *)titleLabel{
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.adjustsFontSizeToFitWidth = YES;
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = [UIFont systemFontOfSize:20.0f];
    }
    return _titleLabel;
}

- (UILabel *)messageLabel{
    if (_messageLabel == nil) {
        _messageLabel = [[UILabel alloc] init];
        _messageLabel.backgroundColor = [UIColor clearColor];
        _messageLabel.numberOfLines = 0;
        _messageLabel.lineBreakMode = NSLineBreakByCharWrapping;
        _messageLabel.font = [UIFont systemFontOfSize:17.0f];
        _messageLabel.textAlignment = NSTextAlignmentCenter;
        _messageLabel.textColor = [UIColor whiteColor];
    }
    return _messageLabel;
}

- (CGSize)sizeAutoToFitWithString:(NSString *)string width:(CGFloat)width font:(UIFont *)font{
    if (string == nil) {return CGSizeMake(0, 0);}
    return [string boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil].size;
}

static void addRoundedRectToPath(CGContextRef context, CGRect rect, float ovalWidth,float ovalHeight){
    float fw, fh;
    if (ovalWidth == 0 || ovalHeight == 0) { // 1
        CGContextAddRect(context, rect);
        return;
    }
    CGContextSaveGState(context); // 2
    CGContextTranslateCTM (context, CGRectGetMinX(rect), // 3
                           CGRectGetMinY(rect));
    CGContextScaleCTM (context, ovalWidth, ovalHeight); // 4
    fw = CGRectGetWidth (rect) / ovalWidth; // 5
    fh = CGRectGetHeight (rect) / ovalHeight; // 6
    CGContextMoveToPoint(context, fw, fh/2); // 7
    CGContextAddArcToPoint(context, fw, fh, fw/2, fh, 1); // 8
    CGContextAddArcToPoint(context, 0, fh, 0, fh/2, 1); // 9
    CGContextAddArcToPoint(context, 0, 0, fw/2, 0, 1); // 10
    CGContextAddArcToPoint(context, fw, 0, fw, fh/2, 1); // 11
    CGContextClosePath(context); // 12
    CGContextRestoreGState(context); // 13
}




@end
