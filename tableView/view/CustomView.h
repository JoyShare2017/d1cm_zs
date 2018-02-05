//
//  CustomView.h
//  tableView
//
//  Created by gaoyang on 2017/5/19.
//  Copyright © 2017年 gaoyang. All rights reserved.
//
/**************************************************************
 @header CustomView
 @version 1.0
 创建时间:2017/5/19
 @author 高杨
 @abstract 自定义view
 @discussion 初始化view 传入数据，自动生成界面
 变更历史:
 
 **************************************************************/
#import <UIKit/UIKit.h>

@interface CustomView : UIView

//初始化view
//dic cell模型
//dataDic  cell数据模型
- (instancetype)initWithFrame:(CGRect)frame dic:(NSDictionary*)dic dataDic:(NSDictionary*)dataDic;
@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)NSMutableDictionary *cell3Dic;//标记点击的哪个含有输入框cell  key：indexPath.row  value：高度 (适用于第三种cell，可以隐藏输入框)
@end
