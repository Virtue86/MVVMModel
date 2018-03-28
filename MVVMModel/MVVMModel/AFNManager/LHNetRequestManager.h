//
//  LHNetRequestManager.h
//  MVVMModel
//
//  Created by Virtue on 2018/3/28.
//  Copyright © 2018年 none. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFHTTPSessionManager.h"
@interface LHNetRequestManager : AFHTTPSessionManager
+ (AFHTTPSessionManager *)simpleInstance;

@end
