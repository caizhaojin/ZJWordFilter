//
//  ZJWordFilter.h
//  ZJWordFilter
//
//  Created by Choi on 2017/9/16.
//  Copyright © 2017年 CZJ. All rights reserved.
//

#import <Foundation/Foundation.h>

#define ZJ_WordFilter [ZJWordFilter sharedInstance]

/** 关键词过滤器 - 敏感词过滤、模糊搜索过滤 */
@interface ZJWordFilter : NSObject

/** 关键词过滤器 - 单例 - 共享实例 */
+ (ZJWordFilter *)sharedInstance;

#pragma mark - 敏感词过滤
/**
 * 插入需要过滤掉的敏感词
 *
 * @param word - 敏感词
 */
- (void)insertWord:(NSString *)word;

/**
 * 对某字符串进行过滤
 *
 * @param string - 需要过滤的字符串
 * 
 * @return stirng - 返回过滤后的字符串
 */
- (NSString *)filter:(NSString *)string;


#pragma mark - 模糊搜索过滤
/**
 * 初始化需要被模糊搜索的字符串数组
 *
 * @param array - 需要被搜索的数组,字符串类型
 */
- (void)initFuzzySearchArray:(NSArray *)array;

/**
 * 对某字符串进行模糊搜索
 *
 * @param string - 需要搜索的字符串
 *
 * @return array - 返回被模糊搜索出的数组结果
 */
- (NSArray *)fuzzySearchString:(NSString *)string;




/** 释放过滤器 - 销毁共享实例子 */
- (void)freeWordFilter;



@end
