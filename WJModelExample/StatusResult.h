//
//  StatusResult.h
//  字典与模型的互转
//
//  Created by 汪俊 on 15-5-21.
//  Copyright (c) 2014年 汪俊. All rights reserved.
//  微博结果（用来表示大批量的微博数据）

#import "BaseObject.h"
#import "IDAndDescription.h"

@interface StatusResult : BaseObject
/** 存放着某一页微博数据（里面都是Status模型） */
@property (strong, nonatomic) NSMutableArray *statuses;
/** 存放着一堆的广告数据（里面都是Ad模型） */
@property (strong, nonatomic) NSArray *ads;
/** 总数 */
@property (strong, nonatomic) NSNumber *totalNumber;
/** 上一页的游标 */
@property (assign, nonatomic) long long previousCursor;
/** 下一页的游标 */
@property (assign, nonatomic) long long nextCursor;

@property (strong, nonatomic)IDAndDescription *IDAndDesc;
@end
