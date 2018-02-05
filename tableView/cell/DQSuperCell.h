//
//  SuperViewCell.h
//  tableView
//
//  Created by gaoyang on 2017/5/19.
//  Copyright © 2017年 gaoyang. All rights reserved.
//
/**************************************************************
 @header DQSuperCell
 @version 1
 创建时间:2017/5/19
 @author 高杨
 @abstract cell父类
 @discussion 所有不同种cell继承它
 变更历史:
 
 **************************************************************/
#import <UIKit/UIKit.h>
#import "DQCellModel.h"
#import "CustomView.h"
#import "DQCellDataModel.h"
@interface DQSuperCell : UITableViewCell

@property (nonatomic, strong)CustomView *customView;//生成cell的视图view
@property (nonatomic, copy)void(^clickBlock)(NSString*TopTitle,NSString*smallTitle,NSString*item);//点击每个选项的block
@property (nonatomic, copy)void(^textViewChange)(NSArray*texts);//输入文字的block
@property (copy, nonatomic) NSString *index;// cell所在index  Row
- (void)setModel:(DQCellModel*)model AndDataModel:(DQCellDataModel*)dataModel;//根据模型数据，生成相应控件和界面
@end
