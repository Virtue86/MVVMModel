//
//  LHTableViewCell.h
//  MVVMModel
//
//  Created by Virtue on 2018/3/28.
//  Copyright © 2018年 none. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LHModel;
@interface LHTableViewCell : UITableViewCell
@property (nonatomic, strong) LHModel *model;
@end
