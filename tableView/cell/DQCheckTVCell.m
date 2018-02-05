//
//  CustomCell3.m
//  tableView
//
//  Created by gaoyang on 2017/5/19.
//  Copyright © 2017年 gaoyang. All rights reserved.
//

#import "DQCheckTVCell.h"
#import "Tools.h"
#import "QRadioButton.h"
#import "DQCellModel.h"
@interface DQCheckTVCell ()<QRadioButtonDelegate>
@property (nonatomic, strong)UBBTextView *textView; //输入框
@property (nonatomic, strong)UILabel *line;//长线，会随着textView的出现，变化而上下移动
/** 存储radios的数组，在点击方法里判断是哪个radio，从而是否显示textView */
@property (nonatomic, strong)NSMutableArray *radioButtons;
@end

@implementation DQCheckTVCell
{
    CGFloat beginHeight;// 用于布局所有内容的变量
    DQCellModel*cellModel;
}

- (void)setModel:(DQCellModel*)model AndDataModel:(DQCellDataModel*)dataModel{
    cellModel = model;
    NSString* groupID = [NSString stringWithFormat:@"%@-%@",model.TopTitle,model.title];
    
    beginHeight = 0;
    //创建小标题
    UILabel *lb = [Tools makeLabeWithBlueBlocklWithFrame:CGRectMake(0, beginHeight, SWIDTH, ITEMNAMEHEIGHT) andText:[NSString stringWithFormat:@"      %@",model.title] andfont:[UIFont systemFontOfSize:15] andColor:[UIColor blackColor]];
    [self addSubview:lb];
    
    beginHeight+=ITEMNAMEHEIGHT;
    
    //创建选择项
    self.radioButtons = [NSMutableArray array];
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
        [self.radioButtons addObject:status];
        [self addSubview:status];
        beginHeight+=ITEMHEIGHT;
    }
    
    //输入内容
    _textView = [[UBBTextView alloc]initWithFrame:CGRectMake(50, beginHeight+5, SWIDTH-50, 100) withPlaceholder:@"我是占位符" andLimiteWords:100];
    _textView.text = dataModel.texts.firstObject;
    
    _textView.layer.borderWidth = 0.6;
    _textView.layer.cornerRadius = 5.0;
    _textView.layer.borderColor = [UIColor colorWithRed:0.88 green:0.88 blue:0.88 alpha:1].CGColor;
    _textView.font = [UIFont systemFontOfSize:16];
    //监听textView内容改变
    //监听textView内容改变
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:nil]; //通知:监听文字的改变
    [self addSubview:_textView];
    
    //长线
    self.line = [[UILabel alloc]initWithFrame:CGRectMake(0, beginHeight-1, SWIDTH, 1)];
    self.line.backgroundColor = LINEGRAY;
    [self addSubview:self.line];

    //根据数据库取值是否显示textView
    //获取当前cell的indexPath
    NSIndexPath *indexPath = [self.customView.tableView indexPathForCell:self];
    if ([model.hiddens containsObject:dataModel.status]) {
        self.textView.hidden = YES;
        self.line.frame = CGRectMake(0, beginHeight-1, SWIDTH, 1);
        [self.customView.cell3Dic setValue:@(0) forKey:self.index];
    }else{
        self.textView.hidden = NO;
        self.line.frame = CGRectMake(0, beginHeight+109, SWIDTH, 1);
        [self.customView.cell3Dic setValue:@(beginHeight+10+100) forKey:self.index];
    }
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
    
    //获取当前cell的indexPath
    NSIndexPath *indexPath = [self.customView.tableView indexPathForCell:self];
    //获取点击的选项
    NSInteger index = [self.radioButtons indexOfObject:radio];
    
    //如果点击的选项 不在要隐藏的选项里面  显示textView ，长线下移  cell3Dic这个设置当前cell的最新的高度
    if (![cellModel.hiddens containsObject:radio.titleLabel.text]) {
        self.textView.hidden = NO;
        self.line.frame = CGRectMake(0, beginHeight+109, SWIDTH, 1);
        [self.customView.cell3Dic setValue:@(beginHeight+10+100) forKey:self.index];
    }
    //其他选项 隐藏textView ，长线上移  cell3Dic这个设置当前cell的最新的高度
    else{
        self.textView.hidden = YES;
        self.line.frame = CGRectMake(0, beginHeight-1, SWIDTH, 1);
        [self.customView.cell3Dic setValue:@(0) forKey:self.index];
    }
    
    
    //刷新cell高度
    [self.customView.tableView beginUpdates];
    [self.customView.tableView endUpdates];
}


@end
