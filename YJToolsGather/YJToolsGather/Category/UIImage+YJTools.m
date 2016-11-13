//
//  UIImage+YJTools.m
//  YJToolsGather
//
//  Created by YJHou on 2016/11/13.
//  Copyright © 2016年 YJHou. All rights reserved.
//

#import "UIImage+YJTools.h"

@implementation UIImage (YJTools)


+ (UIImage *)streImageNamed:(NSString *)imageName{
    if (imageName == nil) {
        return nil;
    }
    UIImage *image = [UIImage imageNamed:imageName];
    UIImage *streImage = [image stretchableImageWithLeftCapWidth:image.size.width/2 topCapHeight:image.size.height/2];
    return streImage;
}


@end
