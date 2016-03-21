//
//  NSObject+WJKeyValues.h
//  WJModelExample
//
//  Created by 汪俊 on 16/3/21.
//  Copyright © 2016年 汪俊. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol WJKeyValue <NSObject>
@optional
// 协议能很好解决问题
+ (NSDictionary *) WJModelClassInArray;

+ (NSDictionary *) WJReplacedKeyToNewKey;

@end


@interface NSObject (WJKeyValues) <WJKeyValue>

// 静态类只能拥有静态成员变量。字典，作用，并无卵用，只为了让系统不报错，能够调用到字类的方法
//+ (NSDictionary *) WJModelClassInArray;
//+ (NSDictionary *) WJReplacedKeyToNewKey;

// 根为字典
+ (instancetype)wj_modelWithKeyValues:(id)keyValues;
// 根为数组
+ (NSMutableArray *)WJModelArrayWithKeyValuesArray:(id)keyValuesArray;


@end
