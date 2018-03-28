//
//  LHViewModel.m
//  MVVMModel
//
//  Created by Virtue on 2018/3/28.
//  Copyright © 2018年 none. All rights reserved.
//

#import "LHViewModel.h"
#import <UIKit/UIKit.h>
#import "LHNetRequestManager.h"
#import "LHModel.h"
#import <YYModel.h>
#import "LHTableViewCell.h"
#import <MJRefresh.h>

#define tabelCellId @"TableViewCell"

@interface LHViewModel()<UITableViewDelegate, UITableViewDataSource>
{
    int _page;
    NSString *_lastTime;
}
@end

@implementation LHViewModel
- (instancetype)initWithViewModelDeleegate:(id)delegate {
    if (self = [super init]) {
        self.viewModelDelegate = delegate;
    }
    return self;
}

#pragma mark ILHBaseViewModel

- (void)viewModelSetViewWithView:(id)view {
    UITableView *tableView = (UITableView *)view;
    tableView.delegate = self;
    tableView.dataSource = self;
    [tableView registerNib:[UINib nibWithNibName:@"LHTableViewCell" bundle:nil] forCellReuseIdentifier:tabelCellId];

    tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self refreshDataCompletionHandler:^(NSError *error) {
            if (!error) {
                [tableView reloadData];
            }
            [tableView.mj_header endRefreshing];
        }];
    }];
    
    tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [self getMoreDataCompletionHandler:^(NSError *error) {
            if (!error) {
                [tableView reloadData];
            }
            [tableView.mj_footer endRefreshing];
        }];
    }];
}

- (void)getDataFromNetCompletionHandler:(completionHandler)completionHandler {
    NSString *urlStr = [NSString stringWithFormat:@"http:%d__%@.json", _page, _lastTime];
    [[LHNetRequestManager simpleInstance] GET:urlStr parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (responseObject) {
            NSArray *array = responseObject[@"array"];
            [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                LHModel *newModel = [LHModel yy_modelWithJSON:obj];
                [self.dataArray addObject:newModel];
            }];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (completionHandler)
            completionHandler(error);
        
    }];
}

- (void)refreshDataCompletionHandler:(completionHandler)completionHandler {
    _page = 0;
    _lastTime = @"0";
    [self.dataArray removeAllObjects];

    [self getDataFromNetCompletionHandler:completionHandler];
}

- (void)getMoreDataCompletionHandler:(completionHandler)completionHandler {
    _page++;
    LHModel *lastModel = self.dataArray.lastObject;
    _lastTime = lastModel.lastTime;
    [self getDataFromNetCompletionHandler:completionHandler];
}

#pragma mark UITableViewDelegate UITableViewDataSource
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LHTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tabelCellId];
    if (self.dataArray.count > 0 && self.dataArray.count > indexPath.row) {
        LHModel *model = self.dataArray[indexPath.row];
        cell.model = model;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.viewModelDelegate && [self.viewModelDelegate respondsToSelector:@selector(didTransferActionWithViewModel:view:object:)]) {
        [self.viewModelDelegate didTransferActionWithViewModel:self view:nil object:@"viewMode来的事件"];
    }
}



@end
