//
//  ViewController.m
//  MVVMModel
//
//  Created by Virtue on 2018/3/28.
//  Copyright © 2018年 none. All rights reserved.
//

#import "ViewController.h"
#import "LHTableViewCell.h"
#import "LHViewModel.h"


/**
 写这个MVVM其实也是一种思想，主要在使用的过程中可以任意的变通，其实MVC也是挺好用的。
 */
@interface ViewController ()<LHBaseViewModelDelegate>
@property (nonatomic, strong) LHViewModel *viewModel;
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpTableView];
}

- (void)setUpTableView {
    
    if (!self.tableView) {
        self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    }
    [self.view addSubview:self.tableView];

    [self.viewModel viewModelSetViewWithView:self.tableView];
    
    __weak  ViewController  *weakSelf = self;
    [self.viewModel getDataFromNetCompletionHandler:^(NSError *error) {
        if (!error) {
            [weakSelf.tableView reloadData];
        }
    }];
}

- (LHViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[LHViewModel alloc] initWithViewModelDeleegate:self];
    }
    return _viewModel;
}

#pragma mark LHBaseViewModelDelegate
- (void)didTransferActionWithViewModel:(LHBaseViewModel *)viewModel view:(UIView *)view object:(id)object {
    if (viewModel == self.viewModel) {
        NSLog(@"%@", object);
    }
}
@end
