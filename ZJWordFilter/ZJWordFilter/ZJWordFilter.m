//
//  ZJWordFilter.m
//  ZJWordFilter
//
//  Created by Choi on 2017/9/16.
//  Copyright © 2017年 CZJ. All rights reserved.
//

#import "ZJWordFilter.h"

#define EXIST @"isExists"

@interface ZJWordFilter ()

/** 根结点 */
@property (strong, nonatomic) NSMutableDictionary *root;

/** 模糊搜索字符串数组 */
@property (strong, nonatomic) NSMutableArray *fuzzySearchArray;

@end

@implementation ZJWordFilter

static dispatch_once_t onceToken;
+ (ZJWordFilter *)sharedInstance
{
    static ZJWordFilter *sharedManager = nil;
    dispatch_once(&onceToken, ^{
        sharedManager = [[ZJWordFilter alloc] init];
    });
    
    return sharedManager;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.root = [NSMutableDictionary dictionary];
        self.fuzzySearchArray = [NSMutableArray array];
    }
    return self;
}

#pragma mark - 敏感词过滤
#pragma mark 插入需要过滤掉的单词
- (void)insertWord:(NSString *)word
{
    NSMutableDictionary *node = self.root;   
    for (int i = 0; i < word.length; i ++) {
        NSString *tempWord = [word substringWithRange:NSMakeRange(i, 1)];
        
        if (node[tempWord] == nil) {
            node[tempWord] = [NSMutableDictionary dictionary];
        }
        
        node = node[tempWord];
    }
    
    //敏感词最后一个字符标识
    node[EXIST] = [NSNumber numberWithInt:1];
}
#pragma mark 对某字符串进行过滤
- (NSString *)filter:(NSString *)str
{
    
    if(!self.root.count) {
        return str;
    }
    
    NSMutableString *result = result = [str mutableCopy];
    
    for (int i = 0; i < str.length; i ++) {
        NSString *subString = [str substringFromIndex:i];
        NSMutableDictionary *node = [self.root mutableCopy] ;
        int num = 0;
        
        for (int j = 0; j < subString.length; j ++) {
            NSString *word = [subString substringWithRange:NSMakeRange(j, 1)];
            
            if (node[word] == nil) {
                break;
            }else{
                num ++;
                node = node[word];
            }
            
            //敏感词匹配成功
            if ([node[EXIST]integerValue] == 1) {
                
                NSMutableString *symbolStr = [NSMutableString string];
                for (int k = 0; k < num; k ++) {
                    [symbolStr appendString:@"*"];
                }
                
                [result replaceCharactersInRange:NSMakeRange(i, num) withString:symbolStr];
                
                i += j;
                break;
            }
        }
    }
    
    return result;
}

#pragma mark - 模糊搜索过滤
#pragma mark 初始化需要被模糊搜索的字符串数组
- (void)initFuzzySearchArray:(NSArray *)array
{
    [_fuzzySearchArray removeAllObjects];
    // 防止传入的不是字符串类型
    for (id obj in array) {
        NSString *string = [NSString stringWithFormat:@"%@",obj];
        [_fuzzySearchArray addObject:string];
    }
}
#pragma mark 对某字符串进行模糊搜索
- (NSArray *)fuzzySearchString:(NSString *)string
{
    if (!_fuzzySearchArray.count) {
        return nil;
    }
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF CONTAINS %@",string];
    return [_fuzzySearchArray filteredArrayUsingPredicate:pred];
}


#pragma mark - 释放过滤器 - 销毁共享实例子
- (void)freeWordFilter
{
    self.root = nil;
    onceToken = 0;
}

@end
