//
//  LHNetRequestManager.m
//  MVVMModel
//
//  Created by Virtue on 2018/3/28.
//  Copyright © 2018年 none. All rights reserved.
//

#import "LHNetRequestManager.h"

@implementation LHNetRequestManager
static AFHTTPSessionManager *client = nil;

+ (AFHTTPSessionManager *)simpleInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        client = [AFHTTPSessionManager manager];
        client.requestSerializer.cachePolicy = NSURLRequestReloadIgnoringLocalCacheData;
        
        client.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", @"text/plain", @"text/json", @"text/javascript",@"application/json",@"multipart/form",nil];//JSONhtml
    });
    return client;
}
@end
