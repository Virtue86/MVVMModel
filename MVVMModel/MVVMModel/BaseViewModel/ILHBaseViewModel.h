//
//  ILHBaseViewModel.h
//  MVVMModel
//
//  Created by Virtue on 2018/3/28.
//  Copyright © 2018年 none. All rights reserved.
//

typedef void(^completionHandler)(NSError *error);

@protocol ILHBaseViewModel <NSObject>

@optional
/** 获取数据 */
- (void)getDataFromNetCompletionHandler:(completionHandler)completionHandler;
/** 刷新 */
- (void)refreshDataCompletionHandler:(completionHandler)completionHandler;
/** 获取更多 */
- (void)getMoreDataCompletionHandler:(completionHandler)completionHandler;

/**
 设置控制器中的一个view可在此ViewModel中进行使用
 */
- (void)viewModelSetViewWithView:(id)view;

/**
 创建并且指向自己的代理

 @param delegate 主要指向VC
 @return 这个代理就是传输在viewModel中的view的事件，其实view可以放到控制器中使用，也可以放到viewModel中，事件要处理好
 */
- (instancetype)initWithViewModelDeleegate:(id)delegate;

@end

