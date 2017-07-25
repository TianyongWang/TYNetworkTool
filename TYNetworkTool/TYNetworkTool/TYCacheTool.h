//
//  TYCacheTool.h
//  TYNetworkTool
//
//  Created by 王天永 on 2017/7/19.
//  Copyright © 2017年 王天永. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef NS_ENUM (NSUInteger,TYTimeUnit) {
    TYNone,
    TYSecond,
    TYMinute,
    TYHour,
    TYDay,
};

@interface TYCacheTool : NSObject

/**
 无失效日期缓存

 @param httpData 缓存数据
 @param url 请求url
 @param parameters 请求参数
 */
+ (void)setHttpCache:(id)httpData URL:(NSString *)url parameters:(NSDictionary *)parameters;

/**
 获取缓存数据

 @param url 请求url
 @param parameter 请求参数
 @return 缓存数据
 */
+ (id)httpCacheWithURL:(NSString *)url parameters:(NSDictionary *)parameter;

/**
 带时效的缓存

 @param httpData 缓存数据
 @param url 请求url
 @param parameters 请求参数
 @param timeUnit 时间单位，TYNone则无时效
 @param life 时效数值，具体单位与timeUnit有关,最小单位 秒
 */
+ (void)setHttpCache:(id)httpData URL:(NSString *)url parameters:(NSDictionary *)parameters userfulLifeUnit:(TYTimeUnit)timeUnit life:(double)life;

@end
