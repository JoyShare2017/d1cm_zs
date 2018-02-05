//
//  DataModel.h
//  tableView
//
//  Created by gaoyang on 2017/5/19.
//  Copyright © 2017年 gaoyang. All rights reserved.
//
/**************************************************************
 @header DQCellModel
 @version 1
 创建时间:2017/5/19
 @author 高杨
 @abstract cell模型
 @discussion 
 变更历史:
 
 **************************************************************/
#import <Foundation/Foundation.h>

@interface DQCellModel : NSObject
/**  */
@property (nonatomic, strong)NSArray *items;//选项类
@property (nonatomic, copy)NSString *title;//小标题
@property (nonatomic, copy)NSString *type;//那种cell
@property (nonatomic, copy)NSString *TopTitle;//大标题
@property (nonatomic, copy)NSArray *units;//有单位cell (可能是一个，可能是两个)
@property (nonatomic, copy)NSArray *hiddens;//可以隐藏输入框的cell  标记哪个选项可以隐藏
@end
