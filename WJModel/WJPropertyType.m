//
//  WJPropertyType.m
//  WJModelExample
//
//  Created by 汪俊 on 16/3/21.
//  Copyright © 2016年 汪俊. All rights reserved.
//

#import "WJPropertyType.h"
#import "WJModelConst.h"
#import <objc/runtime.h>
#import "NSObject+WJClassType.h"

@implementation WJPropertyType
+ (instancetype)propertyTypeWithAttributeString:(NSString *)string{
    return [[WJPropertyType alloc] initWithTypeString:string];
}

- (instancetype)initWithTypeString:(NSString *)string
{
    if (self = [super init])
    {
        // 切割字符串得到类型的字符串
        NSUInteger loc = 1;
        NSUInteger len = [string rangeOfString:@","].location - loc;
        NSString *typeCode = [string substringWithRange:NSMakeRange(loc, len)];
        [self getTypeCode:typeCode];
        //        NSLog(@"%@",typeCode);
    }
    return self;
}

- (void)getTypeCode:(NSString *)code
{
    if ([code isEqualToString:WJPropertyTypeId]) {
        _idType = YES;
    } else if (code.length > 3 && [code hasPrefix:@"@\""]) {
        // 去掉@"和"，截取中间的类型名称
        _code = [code substringWithRange:NSMakeRange(2, code.length - 3)];
        _typeClass = NSClassFromString(_code); //对象类型
        _numberType = (_typeClass == [NSNumber class] || [_typeClass isSubclassOfClass:[NSNumber class]]);
        _fromFoundation = [NSObject isClassFromFoundation:_typeClass];
    }
    
    // 是否为数字类型
    NSString *lowerCode = code.lowercaseString;
    NSArray *numberTypes = @[WJPropertyTypeInt, WJPropertyTypeShort, WJPropertyTypeFloat,WJPropertyTypeBOOL1,WJPropertyTypeBOOL2, WJPropertyTypeDouble, WJPropertyTypeLong, WJPropertyTypeChar];
    if ([numberTypes containsObject:lowerCode]) {
        _numberType = YES;
        if ([lowerCode isEqualToString:WJPropertyTypeBOOL1]
            || [lowerCode isEqualToString:WJPropertyTypeBOOL2]) {
            
            _boolType = YES;
        }
    }
}
@end
