//
//  NSObject+WJClassType.m
//  WJModelExample
//
//  Created by 汪俊 on 16/3/21.
//  Copyright © 2016年 汪俊. All rights reserved.
//

#import "NSObject+WJClassType.h"
#import <objc/runtime.h>
#import "WJProperty.h"
#import "WJPropertyType.h"

typedef struct property_t {
    const char *name;
    const char *attributes;
} *propertyStruct;

@implementation NSObject (WJClassType)
static NSSet *foundationClasses_;

+ (NSSet *)foundationClasses
{
    if (foundationClasses_ == nil) {
        foundationClasses_ = [NSSet setWithObjects:
                              [NSURL class],
                              [NSDate class],
                              [NSValue class],
                              [NSData class],
                              [NSArray class],
                              [NSDictionary class],
                              [NSString class],
                              [NSAttributedString class], nil];
    }
    return foundationClasses_;
}

+ (BOOL)isClassFromFoundation:(Class)clazz {
    if (clazz == [NSObject class]) return YES;
    __block BOOL result = NO;
    [[self foundationClasses] enumerateObjectsUsingBlock:^(Class foundationClass, BOOL *stop) {
        if ([clazz isSubclassOfClass:foundationClass]) {
            result = YES;
            *stop = YES;
        }
    }];
    return result;
}

+ (NSArray *)properties{
    NSMutableArray *propertiesArray = [NSMutableArray array];
    // 1.获得所有的属性
    unsigned int outCount = 0;
    objc_property_t *properties = class_copyPropertyList(self, &outCount);
    
    for (int i = 0; i < outCount; i++) {
        objc_property_t property = properties[i];
        
        WJProperty *propertyObj = [WJProperty propertyWithProperty:property];
        
        [propertiesArray addObject:propertyObj];
    }
    
    return propertiesArray;
}

@end
