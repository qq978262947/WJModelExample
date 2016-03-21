//
//  ViewController.m
//  WJModelExample
//
//  Created by 汪俊 on 16/3/21.
//  Copyright © 2016年 汪俊. All rights reserved.
//

#import "ViewController.h"
#import "User.h"
#import "Status.h"
#import "StatusResult.h"
#import "Ad.h"
#import "WJModel.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self WJModelDemoJson];
    
    [self WJModelDemoArrayInDict];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/**
 *  JSON字符串 -> 模型
 */
- (void)WJModelDemoJson
{
    // 1.定义一个JSON字符串
    NSString *jsonString = @"{\"name\":\"wangjun\", \"icon\":\"wangjun.png\", \"age\":23}";
    
    // 2.将JSON字符串转为User模型
    User *user = [User wj_modelWithKeyValues:jsonString];
    
    // 3.打印User模型的属性
    NSLog(@"user=%@, name=%@, icon=%@, age=%d",user, user.name, user.icon, user.age);
}

/**
 *  复杂的字典 -> 模型 (模型里面包含了模型)
 */
- (void)WJModelDemoDict
{
    // 1.定义一个字典
    NSDictionary *dict = @{
                           @"text" : @"是啊，今天天气确实不错！",
                           
                           @"user" : @{
                                   @"name" : @"wangjun",
                                   @"icon" : @"wangjun.png"
                                   },
                           
                           @"retweetedStatus" : @{
                                   @"text" : @"今天天气真不错！",
                                   
                                   @"user" : @{
                                           @"name" : @"wuzhengyu",
                                           @"icon" : @"wuzhengyu.png"
                                           }
                                   }
                           };
    
    // 2.将字典转为Status模型
    Status *status = [Status wj_modelWithKeyValues:dict];
    
    // 3.打印status的属性
    NSString *text = status.text;
    NSString *name = status.user.name;
    NSString *icon = status.user.icon;
    NSLog(@"text=%@, name=%@, icon=%@", text, name, icon);
    
    // 4.打印status.retweetedStatus的属性
    NSString *text2 = status.retweetedStatus.text;
    NSString *name2 = status.retweetedStatus.user.name;
    NSString *icon2 = status.retweetedStatus.user.icon;
    NSLog(@"text2=%@, name2=%@, icon2=%@", text2, name2, icon2);
}

/**
 *  复杂的字典 -> 模型 (模型的数组属性里面又装着模型)
 */
- (void)WJModelDemoArrayInDict
{
    // 1.定义一个字典
    NSDictionary *dict = @{
                           @"statuses" : @[
                                   @{
                                       @"text" : @"今天天气真不错！",
                                       
                                       @"user" : @{
                                               @"name" : @"wangjun",
                                               @"icon" : @"wangjun.png"
                                               }
                                       },
                                   
                                   @{
                                       @"text" : @"明天去旅游了",
                                       
                                       @"user" : @{
                                               @"name" : @"wuzhengyu",
                                               @"icon" : @"wuzhengyu.png"
                                               }
                                       }
                                   
                                   ],
                           
                           @"ads" : @[
                                   @{
                                       @"image" : @"ad01.png",
                                       @"url" : @"http://www.wangjunad01.com"
                                       },
                                   @{
                                       @"image" : @"ad02.png",
                                       @"url" : @"http://www.wangjunad02.com"
                                       }
                                   ],
                           
                           @"totalNumber" : @"2014",
                           @"previousCursor" : @"13476589",
                           @"nextCursor" : @"13476599",
                           @"IDAndDesc" : @{
                                            @"id" : @"wj_id1111",
                                            @"description" : @"哈哈"
                                        }
                           };
    
    
    
    // 2.将字典转为StatusResult模型
    StatusResult *result = [StatusResult wj_modelWithKeyValues:dict];
    
    
    
    // 3.打印StatusResult模型的简单属性
    NSLog(@"totalNumber=%@, previousCursor=%lld, nextCursor=%lld ,IDAndDesc.ID=%@", result.totalNumber, result.previousCursor, result.nextCursor , result.IDAndDesc.ID);
    
    // 4.打印statuses数组中的模型属性
    for (Status *status in result.statuses) {
        NSString *text = status.text;
        NSString *name = status.user.name;
        NSString *icon = status.user.icon;
        NSLog(@"text=%@, name=%@, icon=%@", text, name, icon);
    }
    
    // 5.打印ads数组中的模型属性
    for (Ad *ad in result.ads) {
        NSLog(@"image=%@, url=%@", ad.image, ad.url);
    }
}

@end
