//
//  NSObject+WJKeyValues.m
//  WJModelExample
//
//  Created by 汪俊 on 16/3/21.
//  Copyright © 2016年 汪俊. All rights reserved.
//

#import "NSObject+WJKeyValues.h"
#import <objc/runtime.h>
#import "WJProperty.h"
#import "WJPropertyType.h"
#import "NSObject+WJClassType.h"

@implementation NSObject (WJKeyValues)


+ (instancetype)wj_modelWithKeyValues:(id)keyValues {
    if (!keyValues) return nil;
    return [[[self alloc] init] setKeyValues:keyValues];
}

- (instancetype)setKeyValues:(id)keyValues{
    // 对json格式进行处理
    keyValues = [keyValues JSONObject];
    NSArray *propertiesArray = [self.class properties];
    for (WJProperty *property in propertiesArray) {
        WJPropertyType *type = property.type;
        Class typeClass = type.typeClass;
        
        id value = [keyValues valueForKey:property.name];
        if (!value) continue;
        // foundation类型
        if (!type.isFromFoundation && typeClass) {
            value = [typeClass wj_modelWithKeyValues:value];
        } else if ([self.class respondsToSelector:@selector(WJModelClassInArray)]){ //数组里存放了模型的特殊处理，即实现了这个方法
            id objectClass;
            // WJModelClassInArray实际上是一个字典
            objectClass = [self.class WJModelClassInArray][property.name];
            
            // 如果是NSString类型
            if ([objectClass isKindOfClass:[NSString class]]) {
                objectClass = NSClassFromString(objectClass);
            }
            
            if (objectClass) {
                // 返回一个装了模型的数组
                value = [objectClass WJModelArrayWithKeyValuesArray:value];
            }
            
        } else if (type.isNumberType){ // 如果是基本数据类型
            NSString *oldValue = value;
            // 字符串->数字
            if ([value isKindOfClass:[NSString class]]){// 如果是字符串
                value = [[[NSNumberFormatter alloc] init] numberFromString:value];
                if (type.isBoolType) {// 如果是bool类型
                    NSString *lower = [oldValue lowercaseString];
                    if ([lower isEqualToString:@"yes"] || [lower isEqualToString:@"true"] ) {
                        value = @YES;
                    } else if ([lower isEqualToString:@"no"] || [lower isEqualToString:@"false"]) {
                        value = @NO;
                    }
                }
            }
        }
        else{
            if (typeClass == [NSString class]) {
                if ([value isKindOfClass:[NSNumber class]]) {
                    if (type.isNumberType)
                        // NSNumber -> NSString
                        value = [value description];
                }else if ([value isKindOfClass:[NSURL class]]){
                    // NSURL -> NSString
                    value = [value absoluteString];
                }
            }
        }
        [self setValue:value forKey:property.name];
    }
    
    return self;
}


/**
 *  根据字典/JSON返回模型数组
 *
 *  @param keyValuesArray 字典/JSON数组
 *
 *  @return 模型数组
 */
+ (NSMutableArray *)WJModelArrayWithKeyValuesArray:(id)keyValuesArray{
    
    if ([self isClassFromFoundation:self])
        return keyValuesArray;
    
    keyValuesArray = [keyValuesArray JSONObject];
    
    NSMutableArray *modelArray = [NSMutableArray array];
    
    // 遍历
    for (NSDictionary *keyValues in keyValuesArray) {
        id model;
        model = [self wj_modelWithKeyValues:keyValues];
        if (model) {
            [modelArray addObject:model];
        }
    }
    
    return modelArray;
    
}



- (id)JSONObject{
    id foundationObj;
    if ([self isKindOfClass:[NSString class]]) {
        foundationObj = [NSJSONSerialization JSONObjectWithData:[(NSString *)self dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:nil];
    }else if ([self isKindOfClass:[NSData class]]){
        foundationObj = [NSJSONSerialization JSONObjectWithData:(NSData *)self options:kNilOptions error:nil];
    }
    return foundationObj?:self;
}


@end
