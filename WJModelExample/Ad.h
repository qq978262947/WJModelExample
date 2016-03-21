//
//  Ad.h
//  MJExtensionExample
//
//  Created by 汪俊 on 15/1/5.
//  Copyright (c) 2015年 汪俊. All rights reserved.
//  广告模型

#import <Foundation/Foundation.h>

@interface Ad : NSObject
/** 广告图片 */
@property (copy, nonatomic) NSString *image;
/** 广告url */
@property (strong, nonatomic) NSURL *url;
@end
