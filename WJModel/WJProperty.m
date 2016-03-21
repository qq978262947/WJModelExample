//
//  WJProperty.m
//  WJModelExample
//
//  Created by 汪俊 on 16/3/21.
//  Copyright © 2016年 汪俊. All rights reserved.
//

#import "WJProperty.h"
#import "WJPropertyType.h"

@implementation WJProperty

+ (instancetype)propertyWithProperty:(objc_property_t)property{
    return  [[WJProperty alloc] initWithProperty:property];
}


- (instancetype)initWithProperty:(objc_property_t)property{
    if (self = [super init]) {
        // 获取属性名
        _name = @(property_getName(property));
        // 获取属性类型
        _type = [WJPropertyType propertyTypeWithAttributeString:@(property_getAttributes(property))];;
    }
    return self;
}



@end
