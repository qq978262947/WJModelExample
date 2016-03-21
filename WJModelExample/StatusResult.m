//
//  StatusResult.m
//  字典与模型的互转
//
//  Created by 汪俊 on 14-5-21.
//  Copyright (c) 2014年 汪俊. All rights reserved.
//

#import "StatusResult.h"

@implementation StatusResult
+ (NSDictionary *)WJModelClassInArray
{
    return @{
             @"statuses" : @"Status",
             @"ads" : @"Ad"
             };
}
@end
