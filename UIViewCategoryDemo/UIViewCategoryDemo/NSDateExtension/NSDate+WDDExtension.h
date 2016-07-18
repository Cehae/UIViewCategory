//
//  NSDate+WDDExtension.h
//  UIViewCategoryDemo
//
//  Created by Wdong on 16/7/18.
//  Copyright © 2016年 Wdong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (WDDExtension)
/**
 * 比较from和self的时间差值
 */
- (NSDateComponents *)deltaFrom:(NSDate *)from;

/**
 * 是否为今年
 */
- (BOOL)isThisYear;

/**
 * 是否为今天
 */
- (BOOL)isToday;

/**
 * 是否为昨天
 */
- (BOOL)isYesterday;
@end
