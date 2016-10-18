//
//  NSString+YJTools.h
//  YJToolsGather
//
//  Created by YJHou on 2016/10/18.
//  Copyright © 2016年 YJHou. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_OPTIONS(NSInteger, PINSegmentationOptions) {
    PINSegmentationOptionsNone              = 0,
    PINSegmentationOptionsDeduplication     = 1 << 0,
    PINSegmentationOptionsKeepEnglish       = 1 << 1,
    PINSegmentationOptionsKeepSymbols       = 1 << 2,
};


@interface NSString (YJTools)

- (NSArray<NSString *> *)segmentation:(PINSegmentationOptions)options;

@end
