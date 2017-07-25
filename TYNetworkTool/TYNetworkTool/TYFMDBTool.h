//
//  TYFMDBTool.h
//  TYNetworkTool
//
//  Created by 王天永 on 2017/7/20.
//  Copyright © 2017年 王天永. All rights reserved.
//

#import <Foundation/Foundation.h>
@class TYCacheTool;


@interface TYFMDBTool : NSObject


/**
 创建tool实例，包含一个dmdb实例对象

 @param name 对应账号的唯一标识符
 @return 返回fmdbtool实例
 */
+ (instancetype)fmdbWithName:(NSString *)name;

/**
 创建表单

 @param tableName 表单名
 @return FMDB实例
 */
- (instancetype)createTableWithName:(NSString *)tableName;


/**
 储存缓存请求来的回调数据(无时效）
 
 @param httpData 回调数据
 @param cacheKey 存储的关键字
 */
- (void)setHttpCache:(id)httpData forCacheKey:(NSString *)cacheKey;

/**
 带时效的缓存
 
 @param httpData 缓存数据
 @param cacheKey 存储的关键字
 @param life 时效数值，具体单位与timeUnit有关
 */
- (void)setHttpCache:(id)httpData userfulLife:(double)life forCacheKey:(NSString *)cacheKey;


/**
 获取本地缓存

 @param cacheKey 存储的关键字
 @return 缓存本地的网络请求
 */
- (id)httpCacheForCacheKey:(NSString *)cacheKey;
@end
