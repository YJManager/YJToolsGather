//
//  NSString+YJTools.h
//  YJToolsGather
//
//  Created by YJHou on 2016/10/18.
//  Copyright © 2016年 YJHou. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_OPTIONS(NSInteger, YJSegmentationOptions) {
    YJSegmentationOptionsNone              = 0,
    YJSegmentationOptionsDeduplication     = 1 << 0,
    YJSegmentationOptionsKeepEnglish       = 1 << 1,
    YJSegmentationOptionsKeepSymbols       = 1 << 2,
};


@interface NSString (YJTools)

- (NSArray<NSString *> *)segment:(YJSegmentationOptions)options;

@end
