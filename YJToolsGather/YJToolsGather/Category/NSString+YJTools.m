//
//  NSString+YJTools.m
//  YJToolsGather
//
//  Created by YJHou on 2016/10/18.
//  Copyright © 2016年 YJHou. All rights reserved.
//

#import "NSString+YJTools.h"

@implementation NSString (YJTools)

- (NSArray<NSString *> *)segmentation:(PINSegmentationOptions)options {
    
    BOOL deduplication = options & PINSegmentationOptionsDeduplication;
    BOOL keepSymbols = options & PINSegmentationOptionsKeepSymbols;
    CFOptionFlags flags = keepSymbols ? kCFStringTokenizerUnitWordBoundary : kCFStringTokenizerUnitWord;
    
    NSMutableArray<NSString *> *results = [NSMutableArray array];
    CFRange textRange = CFRangeMake(0, self.length);
    CFLocaleRef currentRef = CFLocaleCopyCurrent();
    CFStringTokenizerRef tokenizerRef = CFStringTokenizerCreate(NULL, (CFStringRef)self, textRange, flags, currentRef);
    CFStringTokenizerAdvanceToNextToken(tokenizerRef);
    NSMutableSet *resultSet = [NSMutableSet set];
    
    while (YES) {
        
        CFRange tokenRange = CFStringTokenizerGetCurrentTokenRange(tokenizerRef);
        
        if (tokenRange.location == kCFNotFound && tokenRange.length == 0) {
            break;
        }
        
        NSString *token = [self substringWithRange:NSMakeRange(tokenRange.location, tokenRange.length)];
        NSString *item = [token stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        
        if (item.length > 0) {
            if (deduplication) {
                if (![resultSet containsObject:item]) {
                    [results addObject:item];
                }
                [resultSet addObject:item];
            } else {
                [results addObject:item];
            }
        }
        
        CFStringTokenizerAdvanceToNextToken(tokenizerRef);
    }
    
    CFRelease(tokenizerRef);
    CFRelease(currentRef);
    
    return results;
}


@end
