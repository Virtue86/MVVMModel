//
//  LHModel.h
//  MVVMModel
//
//  Created by Virtue on 2018/3/28.
//  Copyright © 2018年 none. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LHBaseModel.h"

@interface LHModel : LHBaseModel
@property (nonatomic, copy) NSString *url;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) int count;
@property (nonatomic, copy) NSString *lastTime;
@end
