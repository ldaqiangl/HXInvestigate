//
//  XZLTableViewCell.m
//  HXInvestigate
//
//  Created by 董富强 on 2017/7/3.
//  Copyright © 2017年 董富强. All rights reserved.
//

#import "XZLTableViewCell.h"

@interface XZLTableViewCell ()

@end

@implementation XZLTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        XZLHorizontalLineView *horizontalLineView = [[XZLHorizontalLineView alloc] init];
        horizontalLineView.isAnimateDisplay = YES;
        self.horizontalLineView = horizontalLineView;
        [self.contentView addSubview:self.horizontalLineView];
        
        UILabel *titleLabel = [[UILabel alloc] init];
        self.titleLabel = titleLabel;
        [self.contentView addSubview:self.titleLabel];
    }
    return self;
}

- (void)updateCellData:(XZLTableViewCellModel *)cellModel {
    
    self.titleLabel.frame = cellModel.nameF;
    self.horizontalLineView.frame = cellModel.timeLineViewF;
    
    self.titleLabel.text = cellModel.medicineName;
    [self.horizontalLineView updateHorizontalLineWithDataModel:cellModel.nodeRangesArr];
}

- (void)awakeFromNib {
    
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end


@implementation XZLTableViewCellModel

- (instancetype)initWithDomain:(XZLHorizontalLineViewDomain *)timeLineDomain {
    
    if (self = [super init]) {
        
        _timeLineDomain = timeLineDomain;
    }
    return self;
}

- (void)processOriginalDataMdoel:(NSObject *)dataModel {
    
    //process data
    NSDictionary *dataSrouceDic = (NSDictionary *)dataModel;
    
    _medicineName = dataSrouceDic[@"name"];
    NSArray *resultRangesArr = dataSrouceDic[@"ranges"];
    
    if (_timeLineDomain.lineDomainStyle == XZLHorizontalLineViewDomainTwoWeeksStyle) {
        
        _timeLineDomain.businessOriginValue =
        _timeLineDomain.businessLastValue - _timeLineDomain.TwoWeeksSecs;
    } else {
        
        _timeLineDomain.businessOriginValue =
        _timeLineDomain.businessLastValue - _timeLineDomain.OneMonthSecs;
    }
    
    NSMutableArray *nodeRanges = [NSMutableArray array];
    
    long long currentTime = _timeLineDomain.businessOriginValue;
    for (NSInteger i = 0; i < resultRangesArr.count; i++) {
        
        NSDictionary *timeInfoDic = resultRangesArr[i];
        NSString *ymdKey = [timeInfoDic.allKeys lastObject];
        
        NSString *startYMD = [[ymdKey componentsSeparatedByString:@"~"] firstObject];
        NSString *endYMD = [[ymdKey componentsSeparatedByString:@"~"] lastObject];
        NSString *type = [timeInfoDic objectForKey:ymdKey];
        
        long long nodeRangeStartTime =
        [[[self class] getSomeDateTimeStamp:[NSString stringWithFormat:@"%@ 0:0",startYMD]
                                andItStyle:@"YYYY-M-d H:m"] longLongValue]/1000;
        long long nodeRangeEndTime =
        [[[self class] getSomeDateTimeStamp:[NSString stringWithFormat:@"%@ 0:0",endYMD]
                                andItStyle:@"YYYY-M-d H:m"] longLongValue]/1000;
        
        XZLHorizontalLineNodeRange *nodeRange = [[XZLHorizontalLineNodeRange alloc] init];
        nodeRange.startX =
        [self.timeLineDomain convertToActualValueFromBusinessValue:nodeRangeStartTime];
        nodeRange.endX =
        [self.timeLineDomain convertToActualValueFromBusinessValue:nodeRangeEndTime];
        
        NSString *color;
        if (type.integerValue == 1) {
            
            color = @"#2BBA60";
        } else if (type.integerValue == 2) {
            
            color = @"#FF862E";
        } else {
            
            color = @"#E14434";
        }
        nodeRange.colorValue = color;
        nodeRange.rangeLineStyle = XZLHorizontalLineNodeRangeButtCapLineStyle;
        nodeRange.lineWidth = 11.0;
        
        if (nodeRangeStartTime - currentTime >= _timeLineDomain.allDaySecs) {
            
            CGFloat startX = [self.timeLineDomain convertToActualValueFromBusinessValue:currentTime];
            CGFloat endX = [self.timeLineDomain convertToActualValueFromBusinessValue:nodeRangeStartTime];
            XZLHorizontalLineNodeRange *blankNodeRange = [self getABlankNodeRangeWithStartX:startX andEndX:endX];
            [nodeRanges addObject:blankNodeRange];
            currentTime = nodeRangeEndTime;
        }
        
        [nodeRanges addObject:nodeRange];
        
        if (i == resultRangesArr.count-1) {
            
            if (_timeLineDomain.businessLastValue - nodeRangeEndTime >= _timeLineDomain.allDaySecs) {
                
                CGFloat startX =
                [self.timeLineDomain convertToActualValueFromBusinessValue:nodeRangeEndTime];
                CGFloat endX =
                [self.timeLineDomain convertToActualValueFromBusinessValue:_timeLineDomain.businessLastValue];
                XZLHorizontalLineNodeRange *blankNodeRange = [self getABlankNodeRangeWithStartX:startX andEndX:endX];
                [nodeRanges addObject:blankNodeRange];
                currentTime = nodeRangeEndTime;
            }
        }
    }
    
    _nodeRangesArr = nodeRanges;
    
    
    _nameF = CGRectMake(10, 10, 100, 30);
    _timeLineViewF =
    CGRectMake(_timeLineDomain.actualOriginValue, 50,
               _timeLineDomain.actualLastValue-_timeLineDomain.actualOriginValue, 30);
}

- (XZLHorizontalLineNodeRange *)getABlankNodeRangeWithStartX:(CGFloat)startX
                                                     andEndX:(CGFloat)endX {
    
    XZLHorizontalLineNodeRange *blankNodeRange = [[XZLHorizontalLineNodeRange alloc] init];
    
    blankNodeRange.startX = startX;
    blankNodeRange.endX = endX;
    blankNodeRange.colorValue = @"#333333";
    blankNodeRange.rangeLineStyle = XZLHorizontalLineNodeRangeDashStyle;
    blankNodeRange.lineWidth = 2.0;
    
    return blankNodeRange;
}


+ (NSString *)getSomeDateTimeStamp:(NSString *)dateTimeStr
                        andItStyle:(NSString *)styleStr {
    
    NSString *targetTimeStamp = nil;
    
    // 1.将服务器返回的时间格式化为NSDate
    NSDateFormatter *DateF = [[NSDateFormatter alloc] init];
    DateF.locale = [NSLocale currentLocale];
    DateF.dateFormat = styleStr;
    NSDate *createdTime = [DateF dateFromString:dateTimeStr];
    
    targetTimeStamp =
    [NSString stringWithFormat:@"%lld",(long long)[createdTime timeIntervalSince1970]*1000];
    
    return targetTimeStamp;
}

@end

















