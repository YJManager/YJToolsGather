//
//  Person.h
//  YJToolsGather
//
//  Created by YJHou on 16/11/18.
//  Copyright © 2016年 YJHou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject

@property (nonatomic, copy) NSString * name; /**< 姓名 */
@property (nonatomic, copy) NSString * age; /**< 年龄 */
@property (nonatomic, assign) NSInteger height; /**< 身高 */

@end
