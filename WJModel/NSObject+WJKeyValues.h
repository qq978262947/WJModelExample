//
//  NSObject+WJKeyValues.h
//  WJModelExample
//
//  Created by 汪俊 on 16/3/21.
//  Copyright © 2016年 汪俊. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (WJKeyValues)

// 静态类只能拥有静态成员变量。字典，作用，并无卵用，只为了让系统不报错，能够调用到字类的方法
+ (NSDictionary *) WJModelClassInArray;
+ (NSDictionary *) WJReplacedKeyFromPropertyName;

+ (instancetype)wj_modelWithKeyValues:(id)keyValues;


@end