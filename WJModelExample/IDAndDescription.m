//
//  IDAndDescription.m
//  字典转模型(一)
//
//  Created by 汪俊 on 15/9/13.
//  Copyright (c) 2015年 wangjun. All rights reserved.
//

#import "IDAndDescription.h"

@implementation IDAndDescription

+ (NSDictionary *)WJReplacedKeyToNewKey {
    return @{
             @"ID" : @"id",
             @"Description" : @"description"
             };
}

@end
