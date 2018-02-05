//
//  DQCellDataModel.h
//  tableView
//
//  Created by gaoyang on 2017/5/20.
//  Copyright © 2017年 gaoyang. All rights reserved.
//
/**************************************************************
 @header DQCellDataModel
 @version 1
 创建时间:2017/5/20
 @author 高杨
 @abstract cell数据模型
 @discussion
 变更历史:
 
 **************************************************************/
#import <Foundation/Foundation.h>

@interface DQCellDataModel : NSObject
@property (copy, nonatomic) NSString *TopTitle; //大标题
@property (copy, nonatomic) NSString *title; //小标题
@property (copy, nonatomic) NSString *status; //选项文字
@property (copy, nonatomic) NSArray *texts;//内容数组
@end
