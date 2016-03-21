//
//  WJProperty.h
//  WJModelExample
//
//  Created by 汪俊 on 16/3/21.
//  Copyright © 2016年 汪俊. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

@class WJPropertyType;

@interface WJProperty : NSObject

/** 成员属性的名字 */
@property (nonatomic, readonly) NSString *name;
/** 成员属性的类型 */
@property (nonatomic, readonly) WJPropertyType *type;

/** 存放所以属性名和类型的类 */
+ (instancetype)propertyWithProperty:(objc_property_t)property;

@end
