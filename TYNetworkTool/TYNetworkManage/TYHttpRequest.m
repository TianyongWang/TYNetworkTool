//
//  TYHttpRequest.m
//  TYNetworkTool
//
//  Created by 王天永 on 2017/7/19.
//  Copyright © 2017年 王天永. All rights reserved.
//

#import "TYHttpRequest.h"
#import "TYRequestURL.h"
#import "TYNetworkTool.h"

@implementation TYHttpRequest
+ (NSURLSessionTask *)getDataWithParameters:(id)parameters success:(TYRequestSuccess)success failure:(TYRequestFailure)failure {
    
    NSString *url = [NSString stringWithFormat:@"%@%@",BaseUrl,tyLogin];
    return [self requestWithURL:url parameters:parameters success:success failure:failure];
    
}


+ (NSURLSessionTask *)requestWithURL:(NSString *)URL parameters:(NSDictionary *)parameter success:(TYRequestSuccess)success failure:(TYRequestFailure)failure
{
    
//    return [TYNetworkTool GET:URL parameters:parameter success:^(id responseObject) {
//        success(responseObject);
//    } failure:^(NSError *error) {
//        failure(error);
//    }];
    
//    return [TYNetworkTool GET:URL parameters:parameter responseCache:^(id responseCache) {
//        NSLog(@"cache");
//         NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseCache options:NSJSONReadingAllowFragments error:nil];
//        NSLog(@"%@",dict);
//        
//    } success:^(id responseObject) {
//                NSLog(@"success");
//        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
//        
//    } failure:^(NSError *error) {
//        
//    }];
    
    return [TYNetworkTool GET:URL parameters:parameter userfulLifeUnit:TYMinute userfullLife:0.1 responseCache:^(id responseCache) {
         NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseCache options:NSJSONReadingAllowFragments error:nil];
        NSLog(@"cache-%@",dict);
    } success:^(id responseObject) {
        
    } failure:^(NSError *error) {
        
    }];
}


@end
