//
//  CustomCell1.m
//  tableView
//
//  Created by gaoyang on 2017/5/19.
//  Copyright © 2017年 gaoyang. All rights reserved.
//

#import "DQCheckCell.h"
#import "Tools.h"
#import "QRadioButton.h"

@interface DQCheckCell ()<QRadioButtonDelegate>

@end

@implementation DQCheckCell



- (void)setModel:(DQCellModel*)model AndDataModel:(DQCellDataModel*)dataModel{
    NSString* groupID = [NSString stringWithFormat:@"%@-%@",model.TopTitle,model.title];
    
    CGFloat beginHeight = 0;   // 用于布局所有内容的变量
    //创建小标题
    UILabel *lb = [Tools makeLabeWithBlueBlocklWithFrame:CGRectMake(0, beginHeight, SWIDTH, ITEMNAMEHEIGHT) andText:[NSString stringWithFormat:@"      %@",model.title] andfont:[UIFont systemFontOfSize:15] andColor:[UIColor blackColor]];
    [self addSubview:lb];
    
    beginHeight+=ITEMNAMEHEIGHT;
    
    //创建选择项
    for (int j = 0; j<model.items.count; j++) {
        QRadioButton*status=[[QRadioButton alloc]initWithDelegate:self groupId:groupID];
        status.delegate = self;
        status.frame=CGRectMake(50, beginHeight, SWIDTH-50, ITEMHEIGHT);
        //        status.problem=1;
        //        [status changeImages];
        if (model.items.count-1 == j) {
            status.longLine = 1;
        }
        if ([dataModel.status  isEqualToString:model.items[j]]) {
            status.checked = YES;
        }
        [status changeLine];
        [status setTitle:model.items[j] forState:UIControlStateNormal];
        [status setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        status.titleLabel.font = [UIFont systemFontOfSize:15];
        [self addSubview:status];
        
        beginHeight+=ITEMHEIGHT;
    }

}
#pragma mark- QRadioButtonDelegate

- (void)didSelectedRadioButton:(QRadioButton *)radio groupId:(NSString *)groupId
{
    NSArray *arr = [groupId componentsSeparatedByString:@"-"];
    if (self.clickBlock) {
        self.clickBlock(arr.firstObject, arr.lastObject, radio.titleLabel.text);
    }
}
@end
