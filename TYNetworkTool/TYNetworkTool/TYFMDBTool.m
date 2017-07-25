//
//  TYFMDBTool.m
//  TYNetworkTool
//
//  Created by 王天永 on 2017/7/20.
//  Copyright © 2017年 王天永. All rights reserved.
//

#import "TYFMDBTool.h"
#import "TYCacheTool.h"
#import "FMDB.h"

@interface TYFMDBTool ()
@property (nonatomic, strong) FMDatabase *db;
@end


@implementation TYFMDBTool
#pragma mark - 根据name，创建Tool实例
+ (instancetype)fmdbWithName:(NSString *)name{
    return [[TYFMDBTool alloc]initWithName:name];
}
#pragma mark - 根据name创建Tool实例
- (instancetype)initWithName:(NSString *)name{
    if (name.length == 0) {
        return nil;
    }
    NSString *folder = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
    NSString *path = [NSString stringWithFormat:@"%@%@.sqlite",folder,name];
    NSLog(@"数据库缓存地址是%@",path);
    return [self initWithPath:path];
}
#pragma mark - 根据path创建Tool实例
- (instancetype)initWithPath:(NSString *)path {
    if (path.length == 0) {
        return nil;
    }
    FMDatabase *db = [FMDatabase databaseWithPath:path];
    if ([db open]) {
        self.db = db;
        return self;
    }else{
        return  nil;
    }
}
#pragma mark - 创建表单
- (instancetype)createTableWithName:(NSString *)tableName {
    if (tableName.length == 0) {
        tableName = @"t_httpCacheTable";
    }
    NSString *sqlString = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@ (iosLocalId integer PRIMARY KEY autoincrement,httpCache bolb,cacheKey text,thatTime integer,userfullLife integer);",tableName];
    BOOL sucess =  [self.db executeUpdate:sqlString];
    if (sucess) {
        return self;
    }else{
        NSLog(@"表创建失败的原因:%@",[self.db lastError]);
        return nil;
    }
    
}
#pragma mark - 储存缓存请求来的回调数据(无时效）
- (void)setHttpCache:(id<NSCoding>)httpData forCacheKey:(NSString *)cacheKey {
    dispatch_sync(dispatch_get_global_queue(0, 0), ^{
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:httpData];
        NSString *selectString = @"select * from t_httpCacheTable where cacheKey = ?";
        FMResultSet *set = [self.db executeQuery:selectString,cacheKey];
        NSLog(@"lasterror = %@",[self.db lastError]);
        BOOL exit = NO;
        while ([set next]) {
            exit = YES;
        }
        
        if (exit) {
            //更新
            NSString *updateString = @"update t_httpCacheTable set httpCache = ? where cacheKey = ?";
            BOOL success = [self.db executeUpdate:updateString,data,cacheKey];
            if (!success) {
                NSLog(@"lasterror = %@",[self.db lastError]);
            }
        }else {
            //插入
            NSString *insertString = @"insert into t_httpCacheTable (httpCache,cacheKey) values(?,?)";
            BOOL success = [self.db executeUpdate:insertString,data,cacheKey];
            if (!success) {
                NSLog(@"lasterror = %@",[self.db lastError]);
            }
        }
        [self.db close];
    });
}
#pragma mark - 带时效的缓存
- (void)setHttpCache:(id<NSCopying>)httpData userfulLife:(double)life forCacheKey:(NSString *)cacheKey {
    dispatch_sync(dispatch_get_global_queue(0, 0), ^{
        if ([self.db open]) {
            NSData *data = [NSKeyedArchiver archivedDataWithRootObject:httpData];
            NSString *selectString = @"select * from t_httpCacheTable where cacheKey = ?";
            FMResultSet *set = [self.db executeQuery:selectString,cacheKey];
            NSLog(@"lasterror = %@",[self.db lastError]);
            BOOL exit = NO;
            while ([set next]) {
                exit = YES;
            }
            long long nowTimesp = [self getCurrentTimeSp];
            if (exit) {
                //更新
                NSString *updateString = @"update t_httpCacheTable set httpCache = ? ,thatTime = ?,userfullLife = ?  where cacheKey = ?";
                BOOL success = [self.db executeUpdate:updateString,data,@(nowTimesp),@(life),cacheKey];
                if (!success) {
                    NSLog(@"lasterror = %@",[self.db lastError]);
                }
            }else {
                //插入
                NSString *insertString = @"insert into t_httpCacheTable (cacheKey,userfullLife,thatTime,httpCache) values(?,?,?,?)";
                BOOL success = [self.db executeUpdate:insertString,cacheKey,@(life),@(nowTimesp),data];
                if (!success) {
                    NSLog(@"lasterror = %@",[self.db lastError]);
                }
            }
            [self.db close];
        }
    });
}


#pragma mark - 获取本地缓存记录
- (id)httpCacheForCacheKey:(NSString *)cacheKey {
    NSString *selectString = @"select * from t_httpCacheTable where cacheKey = ?";
    FMResultSet *set = [self.db executeQuery:selectString,cacheKey];
    NSLog(@"lasterror = %@",[self.db lastError]);
    id result ;
    while ([set next]) {
        long long thatTime = [set longLongIntForColumn:@"thatTime"];
        long long userfullLife = [set longLongIntForColumn:@"userfullLife"];
        long long currentTimeSp = [self getCurrentTimeSp];
//        long long mix = (currentTimeSp - thatTime);
        if ((currentTimeSp - thatTime) > userfullLife) {
            return nil;
        }
        NSData *data = [set dataForColumn:@"httpCache"];
        id dict = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        result = dict;
    }
    return result;
}
#pragma mark - 获取当前时间戳
- (long long)getCurrentTimeSp {
    NSDate *nowDate = [NSDate date];
    NSTimeInterval nowTimesp = [nowDate timeIntervalSince1970];
    return (long long)nowTimesp;
}
@end
