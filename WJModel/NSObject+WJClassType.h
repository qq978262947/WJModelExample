//
//  NSObject+WJClassType.h
//  WJModelExample
//
//  Created by 汪俊 on 16/3/21.
//  Copyright © 2016年 汪俊. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (WJClassType)

+ (BOOL)isClassFromFoundation:(Class)clazz;

+ (NSArray *)properties;

@end
