//
//  RichTextViewController.m
//  tableView
//
//  Created by 赵帅 on 2017/8/26.
//  Copyright © 2017年 gaoyang. All rights reserved. 
//  asdfadf

#import "RichTextViewController.h"

@interface RichTextViewController ()
@property(nonatomic,strong)UITextView* textView;
@end

@implementation RichTextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor] ;
    
    
    self.textView=[[UITextView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-64)];
    
    [self.view addSubview:self.textView];
    

    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:@"8月25日晚间，乐视网发布公告称，过去十二个月内公司作为原告涉及的诉讼、仲裁合计涉案金额人民币3021万元；公司被起诉类案件33起，合计涉案金额人民币15.97亿元、美元373.28万元（约人民币2483万元）。【阿里巴巴宣布：淘宝一段时间未登录将销号[二哈]】近日，阿里巴巴对旗下淘宝、支付宝平台的服务协议进行了修改，当淘宝网账户符合①未绑定通过实名认证的支付宝账户；②连续六个月未用于登录任一阿里平台；③不存在未到期的有效业务等条件时，淘宝将收回用户账号，相应服务同时终止。#对此你想说#？ ​​​​"];
    // 设置“哈哈”为蓝色
//    [string addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:NSMakeRange(0, 2)];
//    [string addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:30] range:NSMakeRange(0, 2)];
//    [string addAttribute:NSBackgroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, 2)];
//
//    // 设置“456”为红色
//    [string addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(6, 2)];
//    [string addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:24] range:NSMakeRange(6, 40)];
//    [string addAttribute:NSUnderlineStyleAttributeName value:@(NSUnderlineStyleSingle) range:NSMakeRange(6, 2)];
    
    // 创建图片图片附件
    
    UIImageView*iv=[[UIImageView alloc]initWithFrame:CGRectMake(40, 100, 100, 100)];
    iv.image=[UIImage imageNamed:@"lby.jpg"];
    [self.textView addSubview:iv];
    
    
//    NSTextAttachment *attach = [[NSTextAttachment alloc] init];
//    attach.image = [UIImage imageNamed:@"lby.jpg"];
//    attach.bounds = CGRectMake(0, 0, 100, 100*468/312);
//    NSAttributedString *attachString = [NSAttributedString attributedStringWithAttachment:attach];
//    [string appendAttributedString:attachString];
    [string appendAttributedString:[[NSAttributedString alloc] initWithString:@"本来一个当场就能解决的小纠纷，一个用拳头，木棒和石块就能解决的小规模边境冲突，生生被印度人搞成了国战。需要投入半个国家的军力去威慑一个非重点战略方向，牵扯和浪费了好大国防资源。同时也丧失了一个强国应有的威慑性，让国际间看到印度是纸老虎一头。现代的边境和海防冲突，一线官兵必须有自主权，不能一级级请示，直到最高层。要求迅速反应，当场打回去，然后大家坐下来，谈判或商议约束武力。大国应该让人既恨又爱，应该有威严，印度这次就是丧失了威严。"]];
    
     self.textView.attributedText = string;
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:iv.frame
                                                    cornerRadius:10];
    self.textView.textContainer.exclusionPaths = @[path];

    
//    CGRect ovalFrame = [self.textView convertRect:iv.frame fromView:self.view];
//    ovalFrame.origin.x -= self.textView.textContainerInset.left+100;
//    ovalFrame.origin.y -= self.textView.textContainerInset.top+100;
//    self.textView.textContainer.exclusionPaths = @[[UIBezierPath bezierPathWithOvalInRect: ovalFrame]];
    
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
