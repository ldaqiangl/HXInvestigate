//
//  XZLTakeMedicineHistoryCell.m
//  HXInvestigate
//
//  Created by 董富强 on 2017/6/3.
//  Copyright © 2017年 董富强. All rights reserved.
//

#import "XZLTakeMedicineHistoryCell.h"
#import "NSDate+DQCalendar.h"

@interface XZLTakeMedicineHistoryCell ()

@property (nonatomic, strong) NSCalendar *calendar;
@property (nonatomic, weak) UILabel *dateLabel;
@property (nonatomic, weak) UIView *bottomLine;

@end
@implementation XZLTakeMedicineHistoryCell

#pragma mark - -> 初始化
- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        [self createView];
        [self setDefaultNoneState];
    }
    return self;
}

- (void)setDefaultNoneState {
    
    self.backgroundColor = [UIColor whiteColor];
    self.contentView.backgroundColor = [UIColor whiteColor];
    
    XZLTakeMedicineHistoryCellStateConfig stateConfig;
    stateConfig.cellState = XZLTakeMedicineHistoryCellStateNormal;
    stateConfig.cellBusinessState = XZLTakeMedicineHistoryCellBusinessStateNone;
    stateConfig.dateState = XZLTakeMedicineHistoryDateStateCurrentMonth;
    _stateConfig = stateConfig;
    
}

- (void)createView {
    
    CGFloat dateLabelW = 30;
    UILabel *dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, dateLabelW, dateLabelW)];
    dateLabel.textAlignment = NSTextAlignmentCenter;
    dateLabel.font = [UIFont systemFontOfSize:15];
    dateLabel.layer.cornerRadius = dateLabelW * 0.5;
    dateLabel.layer.masksToBounds = YES;
    dateLabel.clipsToBounds = YES;
    self.dateLabel = dateLabel;
    [self.contentView addSubview:self.dateLabel];
    
    UIView *bottomLine = [UIView new];
    bottomLine.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), 0.5);
    bottomLine.backgroundColor = [UIColor clearColor];
    self.bottomLine = bottomLine;
    [self.contentView addSubview:self.bottomLine];
    
    self.calendar = [NSDate gregorianCalendar];
}


#pragma mark - -> 数据更新显示

- (void)setDate:(NSDate *)date {
    
    _date = date;
    
    if (_date) {
        
        self.dateLabel.text =
        [NSString stringWithFormat:@"%ld", [self.calendar component:NSCalendarUnitDay fromDate:_date]];
    } else {
        
        self.dateLabel.text = nil;
    }
}

- (void)setStateConfig:(XZLTakeMedicineHistoryCellStateConfig)stateConfig {
    
    _stateConfig = stateConfig;
    XZLTakeMedicineHistoryCellBusinessState busState = stateConfig.cellBusinessState;
    XZLTakeMedicineHistoryCellState cellState = stateConfig.cellState;
    XZLTakeMedicineHistoryDateState dateState = stateConfig.dateState;
    
    if (busState == XZLTakeMedicineHistoryCellBusinessStateNone) {
        
        _stateConfig.cellState = XZLTakeMedicineHistoryCellStateNormal;
        cellState = XZLTakeMedicineHistoryCellStateNormal;
    }
    
    self.
    setDateStateDisplay(dateState).
    setCellBusinessStateDisplay(busState).
    setCellStateDisplay(cellState);
    [self layoutSubviews];
}

- (void)updateCellWithDataModel:(NSObject *)dataModel {
    
    XZLTakeMedicineHistoryCellModel *cellModel = (XZLTakeMedicineHistoryCellModel *)dataModel;
    [self setStateConfig:cellModel.stateConfig];
}


#pragma mark - -> 工具辅助方法

- (XZLTakeMedicineHistoryCell* (^)(NSInteger state))setCellStateDisplay {
    
    return ^XZLTakeMedicineHistoryCell* (NSInteger state){
        
        if (state == XZLTakeMedicineHistoryCellStateSelected) {
            
            XZLTakeMedicineHistoryCellBusinessState busState = _stateConfig.cellBusinessState;
            
            UIColor *themColor = [self getCurrentCellThemeColor:busState];
            
            _dateLabel.backgroundColor = themColor;
            _dateLabel.textColor = [UIColor whiteColor];
            _bottomLine.backgroundColor = [UIColor clearColor];
        } else {
            
            self.
            setDateStateDisplay(_stateConfig.dateState).
            setCellBusinessStateDisplay(_stateConfig.cellBusinessState);
        }

        return self;
    };
}

- (XZLTakeMedicineHistoryCell* (^)(NSInteger state))setCellBusinessStateDisplay {
    
    return ^XZLTakeMedicineHistoryCell* (NSInteger state){
        
        _dateLabel.backgroundColor = [UIColor whiteColor];
        _bottomLine.backgroundColor = [self getCurrentCellThemeColor:state];
        return self;
    };
}

- (XZLTakeMedicineHistoryCell* (^)(NSInteger state))setDateStateDisplay {
    
    return ^XZLTakeMedicineHistoryCell* (NSInteger state){
        
        _dateLabel.backgroundColor = [UIColor whiteColor];
        if (state == XZLTakeMedicineHistoryDateStateCurrentMonth) {
            
            _dateLabel.textColor = [UIColor darkTextColor];
        } else {
            
            _dateLabel.textColor = [UIColor lightGrayColor];
        }
        return self;
    };
}

- (UIColor *)getCurrentCellThemeColor:(NSInteger)state {
    
    UIColor *themColor = [UIColor clearColor];
    if (state == XZLTakeMedicineHistoryCellBusinessStateNone) {
        
        themColor = [UIColor clearColor];
    } else if (state == XZLTakeMedicineHistoryCellBusinessStateAllTake) {
        
        themColor = [UIColor greenColor];
    } else if (state == XZLTakeMedicineHistoryCellBusinessStatePartTake) {
        
        themColor = [UIColor yellowColor];
    } else if (state == XZLTakeMedicineHistoryCellBusinessStateAllMiss) {
        
        themColor = [UIColor redColor];
    }
    
    return themColor;
}


#pragma mark - -> 布局计算

- (void)layoutSubviews {
    
    [super layoutSubviews];
    self.dateLabel.center = CGPointMake(CGRectGetWidth(self.frame)*0.5, CGRectGetHeight(self.frame)*0.5);
    
    CGFloat lineW = CGRectGetWidth(self.dateLabel.frame) * 0.5;
    self.bottomLine.frame =
    CGRectMake((CGRectGetWidth(self.frame)-lineW)*0.5,CGRectGetMaxY(self.dateLabel.frame),lineW,2);
}


@end






@interface XZLTakeMedicineHistoryCellModel ()

@end
@implementation XZLTakeMedicineHistoryCellModel

- (void)setCellDisplayStateConfig:(XZLTakeMedicineHistoryCellStateConfig)stateConfig {
    
    _stateConfig = stateConfig;
}




@end








