//
//  DQCheckTVCell2.m
//  tableView
//
//  Created by gaoyang on 2017/5/22.
//  Copyright © 2017年 gaoyang. All rights reserved.
//

#import "DQCheckTVCell2.h"
#import "Tools.h"
#import "QRadioButton.h"
#import "UBTextView.h"
@interface DQCheckTVCell2 () <QRadioButtonDelegate>
/** 输入框1 */
@property (nonatomic, strong)UBTextView *textView1;
/** 输入框2 */
@property (nonatomic, strong)UBTextView *textView2;
@end

@implementation DQCheckTVCell2

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
    
    //前
    UILabel *unitt = [[UILabel alloc]initWithFrame:CGRectMake(50, beginHeight+5, 35, 30)];
    unitt.text = @"前：";
    [self addSubview:unitt];
    //输入内容1
    _textView1 = [[UBTextView alloc]initWithFrame:CGRectMake(85, beginHeight+5, SWIDTH-85-80, 30)];
    _textView1.text = dataModel.texts.firstObject;
    _textView1.layer.borderWidth = 0.6;
    _textView1.layer.cornerRadius = 5.0;
    _textView1.font = [UIFont systemFontOfSize:16];
    _textView1.layer.borderColor = [UIColor colorWithRed:0.88 green:0.88 blue:0.88 alpha:1].CGColor;
    //监听textView内容改变
    //监听textView内容改变
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:nil]; //通知:监听文字的改变
    
    [self addSubview:_textView1];
    
    
    //单位1
    UILabel *unit1 = [[UILabel alloc]initWithFrame:CGRectMake(SWIDTH-80+3, beginHeight+5, 77, 30)];
    unit1.text = model.units.firstObject;
    [self addSubview:unit1];
    
    beginHeight+=30+5+5;
    
    //短线
    UILabel *line1 = [[UILabel alloc]initWithFrame:CGRectMake(50, beginHeight-1, SWIDTH-50, 1)];
    line1.backgroundColor = LINEGRAY;
    [self addSubview:line1];
    
    
    //前
    UILabel *unitt2 = [[UILabel alloc]initWithFrame:CGRectMake(50, beginHeight+5, 35, 30)];
    unitt2.text = @"后：";
    [self addSubview:unitt2];
    //输入内容2
    _textView2 = [[UBTextView alloc]initWithFrame:CGRectMake(85, beginHeight+5, SWIDTH-85-80, 30)];
    _textView2.text = dataModel.texts.lastObject;
    _textView2.layer.borderWidth = 0.6;
    _textView2.layer.cornerRadius = 5.0;
    _textView2.font = [UIFont systemFontOfSize:16];
    _textView2.layer.borderColor = [UIColor colorWithRed:0.88 green:0.88 blue:0.88 alpha:1].CGColor;
    //监听textView内容改变
    //监听textView内容改变
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:nil]; //通知:监听文字的改变
    
    [self addSubview:_textView2];
    
    //单位2
    UILabel *unit2 = [[UILabel alloc]initWithFrame:CGRectMake(SWIDTH-80+3, beginHeight+5, 77, 30)];
    unit2.text = model.units.lastObject;
    [self addSubview:unit2];

    beginHeight+=30+5+5;
    
    
    //长线
    UILabel *line = [[UILabel alloc]initWithFrame:CGRectMake(0, beginHeight-1, SWIDTH, 1)];
    line.backgroundColor = LINEGRAY;
    [self addSubview:line];
    
}
- (void)textDidChange{
    if (self.textViewChange) {
        self.textViewChange(@[_textView1.text,_textView2.text]);
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
