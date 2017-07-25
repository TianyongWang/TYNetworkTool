//
//  TYCacheTool.m
//  TYNetworkTool
//
//  Created by 王天永 on 2017/7/19.
//  Copyright © 2017年 王天永. All rights reserved.
//

#import "TYCacheTool.h"
#import "FMDB.h"
#import "TYFMDBTool.h"


@interface TYCacheTool ()

@end

static NSString *const TYNetworkResponseCache = @"t_httpCacheTable";

@implementation TYCacheTool
#pragma mark - 无失效日期缓存
+ (void)setHttpCache:(id)httpData URL:(NSString *)url parameters:(NSDictionary *)parameters {
    NSString *cacheKey = [self cacheWithRUL:url parameters:parameters];
    [[self fmdbCraete] setHttpCache:httpData forCacheKey:cacheKey];
}
#pragma mark - 带时效的缓存
+ (void)setHttpCache:(id)httpData URL:(NSString *)url parameters:(NSDictionary *)parameters userfulLifeUnit:(TYTimeUnit)timeUnit life:(double)life {
    NSInteger k = 1;
    switch (timeUnit) {
        case TYNone:
            k = 0;
            break;
        case TYSecond:
            k = 1;
            break;
        case TYMinute:
            k = 60;
            break;
        case TYHour:
            k = 3600;
            break;
        case TYDay:
            k = 3600*24;
            break;
        default:
            break;
    }
    long long fullSec = life * k;
    NSString *cacheKey = [self cacheWithRUL:url parameters:parameters];
    [[self fmdbCraete] setHttpCache:httpData userfulLife:fullSec forCacheKey:cacheKey];
}

#pragma mark - 创建FMDBTool实例
+ (TYFMDBTool *)fmdbCraete{
    return [[TYFMDBTool fmdbWithName:TYNetworkResponseCache] createTableWithName:TYNetworkResponseCache];
}
#pragma mark - 获取缓存数据
+ (id)httpCacheWithURL:(NSString *)url parameters:(NSDictionary *)parameter {
    NSString *cacheKey = [self cacheWithRUL:url parameters:parameter];
    id data = [[self fmdbCraete] httpCacheForCacheKey:cacheKey];
    return data;
}

#pragma mark - 拼接cacheKey
+ (NSString *)cacheWithRUL:(NSString *)url parameters:(NSDictionary *)parameters {
    if (!parameters) {
        return url;
    }
    NSData *stringData = [NSJSONSerialization dataWithJSONObject:parameters options:0 error:nil];
    NSString *paraString = [[NSString alloc] initWithData:stringData encoding:NSUTF8StringEncoding];
    NSString *cacheKey = [NSString stringWithFormat:@"%@%@",url,paraString];
    
    return cacheKey;
}
@end
