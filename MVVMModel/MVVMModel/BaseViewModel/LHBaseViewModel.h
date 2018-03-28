//
//  LHBaseViewModel.h
//  MVVMModel
//
//  Created by Virtue on 2018/3/28.
//  Copyright © 2018年 none. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "ILHBaseViewModel.h"
#import <UIKit/UIKit.h>
@class LHBaseViewModel;

@protocol LHBaseViewModelDelegate <NSObject>
@optional
- (void)didTransferActionWithViewModel:(LHBaseViewModel *)viewModel view:(UIView *)view object:(id)object;
@end

@interface LHBaseViewModel : NSObject<ILHBaseViewModel>
@property (nonatomic, strong) NSMutableArray *dataArray; // 总数据源，若需要其他数据源，自行在子类中添加
@property (nonatomic, weak) id <LHBaseViewModelDelegate> viewModelDelegate;

@end
