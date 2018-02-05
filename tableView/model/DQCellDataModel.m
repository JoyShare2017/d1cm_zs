//
//  DQCellDataModel.m
//  tableView
//
//  Created by gaoyang on 2017/5/20.
//  Copyright © 2017年 gaoyang. All rights reserved.
//

#import "DQCellDataModel.h"

@implementation DQCellDataModel
- (instancetype)init{
    if (self = [super init]) {
        _status = @"";
        _texts = @[];
    }
    return self;
}
@end
