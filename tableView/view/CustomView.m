//
//  CustomView.m
//  tableView
//
//  Created by gaoyang on 2017/5/19.
//  Copyright © 2017年 gaoyang. All rights reserved.
//

#import "CustomView.h"
#import "DQCheckCell.h"
#import "DQCheckTVCell.h"
#import "DQCheckTFCell.h"
#import "DQSuperCell.h"
#import "DQCellModel.h"
#import "DQCheckTVCell2.h"

@interface CustomView ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong)NSMutableArray *dataArr;//cell模型数组
@property (nonatomic, strong)NSMutableArray *dataArr2;//cell数据模型数组
@end

@implementation CustomView
#pragma mark - 初始化函数
- (instancetype)initWithFrame:(CGRect)frame dic:(NSDictionary *)dic dataDic:(NSDictionary *)dataDic{
    if (self = [super initWithFrame:frame]) {
        self.dataArr = [[NSMutableArray alloc]init];
        self.dataArr2 = [[NSMutableArray alloc]init];
        NSArray*array = dic[@"list"];
        NSArray*array2 = dataDic[@"list"];
        
        //添加cell模型
        for (int i =0; i<array.count; i++) {
            NSDictionary *dicc = array[i];
            DQCellModel *model = [[DQCellModel alloc]init];
            model.type = dicc[@"type"];
            model.title = dicc[@"title"];
            model.items = dicc[@"items"];
            model.TopTitle = dic[@"TopTitle"];
            model.units = dicc[@"unit"];
            model.hiddens = dicc[@"hide"];
            [self.dataArr addObject:model];
        }
        
        //添加cell数据模型
        for (int i =0; i<array2.count; i++) {
             DQCellDataModel *model = [[DQCellDataModel alloc]init];
            if ([array2[i] isKindOfClass:[NSArray class]]) {
                NSArray *arr = array2[i];
                model.status = arr.firstObject;
                model.texts = arr.lastObject;
            }else{
                model.status = array2[i];
            }
           
            
            [self.dataArr2 addObject:model];
        }
        self.cell3Dic = [NSMutableDictionary dictionary];
        [self tableView];
        //使用NSNotificationCenter 鍵盤出現時
        [[NSNotificationCenter defaultCenter] addObserver:self
         
                                                 selector:@selector(keyboardWasShown:)
         
                                                     name:UIKeyboardDidShowNotification object:nil];
        
        //使用NSNotificationCenter 鍵盤隐藏時
        [[NSNotificationCenter defaultCenter] addObserver:self
         
                                                 selector:@selector(keyboardWillBeHidden:)
         
                                                     name:UIKeyboardWillHideNotification object:nil];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction)];
        tap.cancelsTouchesInView = YES;
        [self addGestureRecognizer:tap];
    }
    return self;
}
#pragma mark - 添加手势结束文本输入框的编辑
- (void)tapAction{
    [self endEditing:YES];
}

#pragma mark --- UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DQCellModel*model = self.dataArr[indexPath.row];
    DQCellDataModel*dataModel = self.dataArr2[indexPath.row];
    DQSuperCell*cell;
    if ([model.type isEqualToString:@"1"]) {
        
        NSString *cellID = model.title;
        
        cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (!cell) {
            cell = [[DQCheckCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
            [cell setModel:model AndDataModel:dataModel];
        }
        
    }else if ([model.type isEqualToString:@"2"]) {
        NSString *cellID = model.title;
        
        cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (!cell) {
            cell = [[DQCheckTFCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
            [cell setModel:model AndDataModel:dataModel];
        }
        cell.textViewChange = ^(NSArray *texts) {
            NSLog(@"有单位的输入文字：%@",texts);
        };
        
    }else if ([model.type isEqualToString:@"3"]) {
        NSString *cellID = model.title;
        cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (!cell) {
            cell = [[DQCheckTVCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
            cell.customView = self;
            cell.index = [NSString stringWithFormat:@"%ld",(long)indexPath.row];
            [cell setModel:model AndDataModel:dataModel];
            
        }
        cell.textViewChange = ^(NSArray *texts) {
            NSLog(@"输入文字：%@",texts);
        };
    }else if ([model.type isEqualToString:@"4"]) {
        NSString *cellID = model.title;
        
        cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (!cell) {
            cell = [[DQCheckTVCell2 alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
            [cell setModel:model AndDataModel:dataModel];
        }
        cell.textViewChange = ^(NSArray *texts) {
            NSLog(@"有单位的输入文字：%@",texts);
        };
        
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
   
    cell.clickBlock = ^(NSString *TopTitle, NSString *smallTitle, NSString *item) {
        NSLog(@"点击选项：%@-----%@------%@",TopTitle,smallTitle,item);
    };
    return cell;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    DQCellModel *model = self.dataArr[indexPath.row];
    CGFloat beginHeight = 0;   // 用于布局所有内容的变量
    beginHeight+=ITEMNAMEHEIGHT;
    
    //创建选择项
    for (int j = 0; j<model.items.count; j++) {
        
        beginHeight+=ITEMHEIGHT;
    }
    
    if ([model.type isEqualToString:@"1"]) {
        
        return beginHeight;
        
    }else if ([model.type isEqualToString:@"2"]){
        return beginHeight+40;
    }else if ([model.type isEqualToString:@"4"]){
        return beginHeight+80;
    }
    else if ([model.type isEqualToString:@"3"]){
       
        //从self.cell3Dic里面拿cell的实时高度
        float height = [[self.cell3Dic valueForKey:[NSString stringWithFormat:@"%ld",(long)indexPath.row]] floatValue];
        if (height == 0 ) {
           
            return beginHeight;
        }
        return height;
        
    }
    return 0;
}
//实现当键盘出现的时候计算键盘的高度大小。用于输入框显示位置
- (void)keyboardWasShown:(NSNotification*)aNotification
{
    
    NSDictionary* info = [aNotification userInfo];
    //kbSize即為鍵盤尺寸 (有width, height)
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;//得到鍵盤的高度
    
    [UIView animateWithDuration:[[info objectForKey:UIKeyboardAnimationDurationUserInfoKey] intValue] animations:^{
            self.tableView.frame=CGRectMake(0, 0, SWIDTH, self.frame.size.height-kbSize.height);
            
    }];
    
}
- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    
}
//当键盘隐藏的时候
- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    //do something
    
    NSDictionary* info = [aNotification userInfo];
    //kbSize即為鍵盤尺寸 (有width, height)
    
    [UIView animateWithDuration:[[info objectForKey:UIKeyboardAnimationDurationUserInfoKey] intValue] animations:^{
        self.tableView.frame=CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    }];
    
}


- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height) style:UITableViewStylePlain];
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.showsHorizontalScrollIndicator = NO;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.bounces = NO;
        _tableView.tableFooterView = [UIView new];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self addSubview:_tableView];
    }
    return _tableView;
}
@end
