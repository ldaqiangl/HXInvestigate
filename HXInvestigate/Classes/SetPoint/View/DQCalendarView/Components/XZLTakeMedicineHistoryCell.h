//
//  XZLTakeMedicineHistoryCell.h
//  HXInvestigate
//
//  Created by 董富强 on 2017/6/3.
//  Copyright © 2017年 董富强. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_OPTIONS(NSInteger, XZLTakeMedicineHistoryCellBusinessState) {
    
    XZLTakeMedicineHistoryCellBusinessStateNone = 1,//无任何状态
    XZLTakeMedicineHistoryCellBusinessStateAllTake = 2,//全部吃过
    XZLTakeMedicineHistoryCellBusinessStatePartTake = 3,//部分已吃
    XZLTakeMedicineHistoryCellBusinessStateAllMiss = 4,//全部错过
};

typedef NS_OPTIONS(NSInteger, XZLTakeMedicineHistoryCellState) {
    
    XZLTakeMedicineHistoryCellStateNormal = 1,
    XZLTakeMedicineHistoryCellStateSelected = 2,//选中cell
    XZLTakeMedicineHistoryCellStateDisable = 3
};

typedef NS_OPTIONS(NSInteger, XZLTakeMedicineHistoryDateState) {
    
    XZLTakeMedicineHistoryDateStatePreMonth = 1,
    XZLTakeMedicineHistoryDateStateCurrentMonth = 2,
    XZLTakeMedicineHistoryDateStateNextMonth = 3
};

struct XZLTakeMedicineHistoryCellStateConfig {
    
    XZLTakeMedicineHistoryDateState dateState;
    XZLTakeMedicineHistoryCellState cellState;
    XZLTakeMedicineHistoryCellBusinessState cellBusinessState;
};
typedef struct XZLTakeMedicineHistoryCellStateConfig XZLTakeMedicineHistoryCellStateConfig;

@interface XZLTakeMedicineHistoryCell : UICollectionViewCell

@property (nonatomic, strong) NSDate *date;
@property (nonatomic, assign) XZLTakeMedicineHistoryCellStateConfig stateConfig;

- (void)updateCellWithDataModel:(NSObject *)dataModel;

- (XZLTakeMedicineHistoryCell* (^)(NSInteger state))setCellStateDisplay;
- (XZLTakeMedicineHistoryCell* (^)(NSInteger state))setCellBusinessStateDisplay;
- (XZLTakeMedicineHistoryCell* (^)(NSInteger state))setDateStateDisplay;
@end


@interface XZLTakeMedicineHistoryCellModel : NSObject

@property (nonatomic, strong) NSDate *date;
@property (nonatomic, assign, readonly) XZLTakeMedicineHistoryCellStateConfig stateConfig;

//- (void)updateCellWithDataModel:(NSObject *)dataModel;

@end














