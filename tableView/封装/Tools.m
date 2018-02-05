//
//  Tools.m
//  KuaiGu_A
//
//  Created by zhaoshuai on 16/7/7.
//  Copyright © 2016年 tycmc. All rights reserved.
//

#import "Tools.h"

@implementation Tools
+(UILabel*)makeLabeWithBlueBlocklWithFrame:(CGRect)frame andText:(NSString*)text  andfont:(UIFont*)font andColor:(UIColor*)color{

    UILabel*lb=[[UILabel alloc]initWithFrame:frame];
    lb.text=text;
    lb.textColor=color;
    lb.font=font;
    lb.textAlignment = NSTextAlignmentLeft;
    UIView*blueview=[[UIView alloc]initWithFrame:CGRectMake(10, 5, 5, frame.size.height-10)];
    blueview.backgroundColor=[UIColor blueColor];
    [lb addSubview:blueview];
    [lb bringSubviewToFront:blueview];
    
    UIView*line=[[UIView alloc]initWithFrame:CGRectMake(0, frame.size.height-1, frame.size.width, 1)];
    line.backgroundColor=LINEGRAY;
    [lb addSubview:line];
    return lb;

}




@end
