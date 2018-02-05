//
//  EIRadioButton.m
//  EInsure
//
//  Created by ivan on 13-7-9.
//  Copyright (c) 2013年 ivan. All rights reserved.
//

#import "QRadioButton.h"

#define Q_RADIO_ICON_WH                     (25.0)
#define Q_ICON_TITLE_MARGIN                 (5.0)


static NSMutableDictionary *_groupRadioDic = nil;

@implementation QRadioButton

@synthesize delegate = _delegate;
@synthesize checked  = _checked;

@synthesize radioButtonBlock = _radioButtonBlock;
@synthesize itemid = _itemid;

- (id)initWithDelegate:(id)delegate groupId:(NSString*)groupId {
    self = [super init];
    if (self) {
        _delegate = delegate;
        _groupId = [groupId copy];
        
        self.titleLabel.lineBreakMode = 0;
        
        [self addToGroup];
        
        self.exclusiveTouch = YES;

        [self addTarget:self action:@selector(radioBtnChecked) forControlEvents:UIControlEventTouchUpInside];
       
        self.lineLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, self.frame.size.height-1, [UIScreen mainScreen].bounds.size.width-70, 1)];
        self.lineLabel.backgroundColor=LINEGRAY;
        [self addSubview:self.lineLabel];
        
        [self setImage:[UIImage imageNamed:@"duigou_m_50x50.png"] forState:UIControlStateNormal];
        [self setImage:[UIImage imageNamed:@"duigou_lvse_m_50x50"] forState:UIControlStateSelected];
       
    }
    return self;
}
- (void)changeImages{
    
    
}
- (void)changeLine{
    if (self.longLine==1) {
        self.lineLabel.frame=CGRectMake(-50, self.frame.size.height-1, self.frame.size.width+50, 1);
    }else{
        self.lineLabel.frame=CGRectMake(0, self.frame.size.height-1, self.frame.size.width, 1);
    }
}
- (void)addToGroup {
    if(!_groupRadioDic){
        _groupRadioDic = [NSMutableDictionary dictionary];
    }
    
    NSMutableArray *_gRadios = [_groupRadioDic objectForKey:_groupId];
    if (!_gRadios) {
        _gRadios = [NSMutableArray array];
    }
    [_gRadios addObject:self];
    [_groupRadioDic setObject:_gRadios forKey:_groupId];
}

- (void)removeFromGroup {
    if (_groupRadioDic) {
        NSMutableArray *_gRadios = [_groupRadioDic objectForKey:_groupId];
        if (_gRadios) {
            [_gRadios removeObject:self];
            if (_gRadios.count == 0) {
                [_groupRadioDic removeObjectForKey:_groupId];
            }
        }
    }
}

- (void)uncheckOtherRadios {
    NSMutableArray *_gRadios = [_groupRadioDic objectForKey:_groupId];
    if (_gRadios.count > 0) {
        for (QRadioButton *_radio in _gRadios) {
            if (_radio.checked && ![_radio isEqual:self]) {
                _radio.checked = NO;
            }
        }
    }
}

- (void)setChecked:(BOOL)checked {
    
    
      if (_checked == checked) {
            return;
        }
        _checked = checked;
        self.selected = checked;
        if (self.selected) {
            [self uncheckOtherRadios];
        }
        
        if(self.selected && _radioButtonBlock)
        {
            _radioButtonBlock(self,_groupId);
        }
        
    
    
    if (self.selected && _delegate && [_delegate respondsToSelector:@selector(didSelectedRadioButton:groupId:)]) {
        // [_delegate didSelectedRadioButton:self groupId:_groupId];
    }
    
    
}


- (void)radioBtnChecked {
    
  
        if (_checked) {
            return;
        }
        self.selected = !self.selected;
        _checked = self.selected;
        if (self.selected) {
            [self uncheckOtherRadios];
        }
    
    
        if (self.selected && _delegate && [_delegate respondsToSelector:@selector(didSelectedRadioButton:groupId:)]) {
            [_delegate didSelectedRadioButton:self groupId:_groupId];
            
        }
        if(self.selected && _radioButtonBlock)
        {
            _radioButtonBlock(self,_groupId);
        }
    
    
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect {
    
    CGRect rect =CGRectMake(0, (CGRectGetHeight(contentRect) - Q_RADIO_ICON_WH)/2.0, Q_RADIO_ICON_WH, Q_RADIO_ICON_WH);
    return rect;
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect {
    
    
    CGRect recc=CGRectMake(Q_RADIO_ICON_WH + Q_ICON_TITLE_MARGIN, 0,
                      CGRectGetWidth(contentRect) - Q_RADIO_ICON_WH - Q_ICON_TITLE_MARGIN,
                      CGRectGetHeight(contentRect));
    return  recc;
}



- (void)dealloc {
    [self removeFromGroup];
    
    _delegate = nil;
   
    _groupId = nil;
   
}


@end
