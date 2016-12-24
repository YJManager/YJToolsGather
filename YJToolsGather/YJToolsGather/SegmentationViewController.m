//
//  SegmentationViewController.m
//  YJToolsGather
//
//  Created by YJHou on 2016/10/18.
//  Copyright © 2016年 YJHou. All rights reserved.
//

#import "SegmentationViewController.h"
#import "NSString+YJTools.h"
#import <StoreKit/StoreKit.h>


@interface SegmentationViewController () <SKStoreProductViewControllerDelegate>

@end

@implementation SegmentationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSArray<NSString *> * texts = [@"测试中文分what词功能" segment:YJSegmentationOptionsNone];
    [texts enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSLog(@"--->>>>> %@", obj);
    }];

    [self CAGradientLayer];
}

- (void)CAGradientLayer{
    
    CGRect frame = CGRectMake(0, 64, kScreen_Width, 40);
    UILabel *labelInit = [[UILabel alloc] initWithFrame:frame];
    labelInit.font = [UIFont systemFontOfSize:13];
    labelInit.textAlignment = NSTextAlignmentLeft;
    labelInit.backgroundColor = [UIColor grayColor];
    labelInit.numberOfLines = 0;
    labelInit.text = @"太阳对我眨眼睛鸟儿唱歌给我听我是一个努力干活儿还不粘人的小妖精别问我从哪里来也别问我到哪里去我要摘下最美的花儿献给我的小公举大王叫我来巡山我把人间转一转打起我的鼓敲起我的锣";
    [self.view addSubview:labelInit];
    
    
    NSArray *colors = [NSArray arrayWithObjects:
                       (id)[[UIColor colorWithWhite:0 alpha:1] CGColor],
                       (id)[[UIColor colorWithWhite:0 alpha:0] CGColor],
                       nil];
    
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    [gradientLayer setColors:colors];
    [gradientLayer setStartPoint:CGPointMake(0.5f, 1.0f)]; // 单位向量
    [gradientLayer setEndPoint:CGPointMake(0.5f, 0.0f)];
    [gradientLayer setFrame:[labelInit bounds]];
    gradientLayer.type = kCAGradientLayerAxial;
    
    [[labelInit layer] setMask:gradientLayer];

    


}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    NSDictionary *appParameters = [NSDictionary dictionaryWithObject:@"1183737380"
                                                              forKey:SKStoreProductParameterITunesItemIdentifier];
    
    SKStoreProductViewController *productViewController = [[SKStoreProductViewController alloc] init];
    productViewController.delegate = self;
    [productViewController loadProductWithParameters:appParameters completionBlock:^(BOOL result, NSError *error){
        NSLog(@"-->%d --Error = %@", result, error);
        if (result) {
            [self presentViewController:productViewController animated:YES completion:^{
            }];
        }
    }];
    

}

#pragma mark - SKStoreProductViewControllerDelegate
- (void)productViewControllerDidFinish:(SKStoreProductViewController *)viewController {
    [viewController dismissViewControllerAnimated:YES completion:^{
    }];
}


@end
