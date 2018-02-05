//
//  SuperViewCell.m
//  tableView
//
//  Created by gaoyang on 2017/5/19.
//  Copyright © 2017年 gaoyang. All rights reserved.
//

#import "DQSuperCell.h"
#import "Tools.h"
#import "QRadioButton.h"

@implementation DQSuperCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {

    }
    return self;
}
- (void)setModel:(DQCellModel *)model AndDataModel:(DQCellDataModel *)dataModel{
    
}
@end
