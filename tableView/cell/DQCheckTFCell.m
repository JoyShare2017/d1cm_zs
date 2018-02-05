//
//  CustomCell2.m
//  tableView
//
//  Created by gaoyang on 2017/5/19.
//  Copyright © 2017年 gaoyang. All rights reserved.
//

#import "DQCheckTFCell.h"
#import "Tools.h"
#import "QRadioButton.h"
#import "UBTextView.h"
@interface DQCheckTFCell ()<QRadioButtonDelegate>
/** 输入框 */
@property (nonatomic, strong)UBTextView *textView;
@end

@implementation DQCheckTFCell


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
        [status changeLine];
        if ([dataModel.status  isEqualToString:model.items[j]]) {
            status.checked = YES;
        }
        [status setTitle:model.items[j] forState:UIControlStateNormal];
        [status setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        status.titleLabel.font = [UIFont systemFontOfSize:15];
        [self addSubview:status];
        beginHeight+=ITEMHEIGHT;
    }
    
    //输入内容
    _textView = [[UBTextView alloc]initWithFrame:CGRectMake(50, beginHeight+5, SWIDTH-50-80, 30)];
    _textView.text = dataModel.texts.firstObject;
    _textView.layer.borderWidth = 0.6;
    _textView.layer.cornerRadius = 5.0;
    _textView.font = [UIFont systemFontOfSize:16];
    _textView.layer.borderColor = [UIColor colorWithRed:0.88 green:0.88 blue:0.88 alpha:1].CGColor;
    //监听textView内容改变
    //监听textView内容改变
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:nil]; //通知:监听文字的改变
    
    [self addSubview:_textView];
    
    //单位
    UILabel *unit = [[UILabel alloc]initWithFrame:CGRectMake(SWIDTH-80+3, beginHeight+5, 77, 30)];
    unit.text = model.units.firstObject;
    [self addSubview:unit];
    beginHeight+=30+5+5;
    //长线
    UILabel *line = [[UILabel alloc]initWithFrame:CGRectMake(0, beginHeight-1, SWIDTH, 1)];
    line.backgroundColor = LINEGRAY;
    [self addSubview:line];

}
- (void)textDidChange{
    if (self.textViewChange) {
        self.textViewChange(@[_textView.text]);
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
