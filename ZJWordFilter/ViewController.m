//
//  ViewController.m
//  ZJWordFilter
//
//  Created by Choi on 2017/9/16.
//  Copyright © 2017年 CZJ. All rights reserved.
//

#import "ViewController.h"
#import "ZJWordFilter.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    ZJWordFilter *wordFilter = ZJ_WordFilter;
    
    // 关键词过滤
    NSArray *arr = @[@"fuck",@"王八蛋",@"神经病"];
    for (NSString *str in arr) {
        [wordFilter insertWord:str];
    }
    NSLog(@"wordFilter - %@",[wordFilter filter:@"fuckaaa"]);
    NSLog(@"wordFilter - %@",[wordFilter filter:@"aaafuckaaa"]);
    NSLog(@"wordFilter - %@",[wordFilter filter:@"王八蛋 - 神经病"]);
    
    NSLog(@"---------分割线-------------");
    // 模糊搜索
    arr = @[@"大数据",@"数据分析",@"分析师",@"数据变现"];
    [wordFilter initFuzzySearchArray:arr];
    NSLog(@"搜索【数】关键词  %@",[wordFilter fuzzySearchString:@"数"]);
    NSLog(@"搜索【数据】关键词  %@",[wordFilter fuzzySearchString:@"数据"]);
    NSLog(@"搜索【分】关键词  %@",[wordFilter fuzzySearchString:@"分"]);
    NSLog(@"搜索【分析】关键词  %@",[wordFilter fuzzySearchString:@"分析"]);
    // http://tool.chinaz.com/tools/unicode.aspx
}




@end
