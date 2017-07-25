//
//  TYHttpRequest.h
//  TYNetworkTool
//
//  Created by 王天永 on 2017/7/19.
//  Copyright © 2017年 王天永. All rights reserved.
//

#import <Foundation/Foundation.h>
@class TYNetworkTool;

/**
 请求成功的回调

 @param response 响应块数据
 */
typedef void(^TYRequestSuccess)(id response);

/**
 请求失败的回调

 @param error 错误信息
 */
typedef void(^TYRequestFailure)(NSError *error);



@interface TYHttpRequest : NSObject
//**  */
+ (NSURLSessionTask *)getDataWithParameters:(id)parameters success:(TYRequestSuccess)success failure:(TYRequestFailure)failure;
@end
