//
//  ViewController.m
//  tableView
//
//  Created by gaoyang on 2017/5/19.
//  Copyright © 2017年 gaoyang. All rights reserved.
//

#import "ViewController.h"
#import "CustomView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    CustomView *cust = [[CustomView alloc]initWithFrame:CGRectMake(0, 0, SWIDTH, SHEIGHT-64) dic:@{@"TopTitle":@"液体容器检查",@"list":@[@{@"type":@"1",@"title":@"发动机油底壳、喷油泵和调速器1",@"items":@[@"良好",@"不良",@"不知道"]},@{@"type":@"3",@"hide":@[@"不正常"],@"title":@"散热器3",@"items":@[@"不正常",@"已修正"]}, @{@"type":@"4",@"unit":@[@"单",@"位"],@"title":@"热器4",@"items":@[@"不正常",@"已修正"]},@{@"type":@"2",@"unit":@[@"位"],@"title":@"热2",@"items":@[@"不正常",@"已修正"]}]} dataDic:@{@"list":@[@"不良",@[@"已修正",@[@"类型三"]],@[@"不正常",@[@"类型二"]],@[@"已修正",@[@"类型二1"]]]}];
    [self.view addSubview:cust];
}
@end
