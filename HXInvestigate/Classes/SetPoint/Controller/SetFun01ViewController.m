//
//  SetFun01ViewController.m
//  HXInvestigate
//
//  Created by 董富强 on 16/7/18.
//  Copyright © 2016年 董富强. All rights reserved.
//

#import "SetFun01ViewController.h"
#import "SetFunc02ViewController.h"

#import "DQCalendarView.h"
#import "XZLTakeMedicineHistoryCell.h"
@interface SetFun01ViewController ()
<DQCalendarDataSource, DQCalendarDelegate>

@property (nonatomic, strong) DQCalendarView *calendarView;
@property (nonatomic, strong) NSDate *selectedDate;


@end

@implementation SetFun01ViewController

- (IBAction)funcBtnClicked:(id)sender {
//    SetFunc02ViewController *func02Vc = [[SetFunc02ViewController alloc] initWithNibName:@"SetFunc02ViewController" bundle:nil];
//    [self.navigationController pushViewController:func02Vc animated:YES];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW,
                                 (int64_t)(0.5 * NSEC_PER_SEC)),
                   dispatch_get_main_queue(), ^{
        self.tabBarController.selectedIndex = 0;
    });
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 获取当前日期
    NSDate *today = [NSDate today_DQCalendar];
    
    //    NSDate *today = [NSDate date];
    // 获取6个月后的最后一天
    NSCalendar *calendar = [NSDate gregorianCalendar];
    NSDateComponents *components = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:today];
    
    NSDate *firstDate = [calendar dateFromComponents:components];
    
    components.month = components.month + 1 + 12;
    components.day = 0;
    NSDate *lastDate = [calendar dateFromComponents:components];
    
    self.calendarView.firstDate = firstDate;
    self.calendarView.lastDate = lastDate;
    
    [self.view addSubview:self.calendarView];
    
    self.selectedDate = firstDate;
}


#pragma mark - DQCalendarDataSource

- (void)calendarView:(DQCalendarView *)calendarView configureWeekDayLabel:(UILabel *)dayLabel atWeekDay:(NSInteger)weekDay {
    
    dayLabel.font = [UIFont systemFontOfSize:11];
    dayLabel.textColor = [UIColor lightGrayColor];
    dayLabel.text = [NSString stringWithFormat:@"周%@",dayLabel.text];
}

- (void)calendarView:(DQCalendarView *)calendarView
       configureCell:(XZLTakeMedicineHistoryCell *)cell
             forDate:(NSDate *)date {
    
    if (date) {
        
        //传入和设置 该cell对应的Date日期
        cell.date = date;
        
        XZLTakeMedicineHistoryCellStateConfig stateConfig = cell.stateConfig;
        if ([date isEqualToDate:self.selectedDate]) {
            
            stateConfig.cellState = XZLTakeMedicineHistoryCellStateSelected;
        } else {
            
            stateConfig.cellState = XZLTakeMedicineHistoryCellStateNormal;
        }
        
        if (date.dateIndexPath.item % 3 == 0) {
            
            stateConfig.cellBusinessState = XZLTakeMedicineHistoryCellBusinessStateAllTake;
        }
        if (date.dateIndexPath.item % 5 == 0) {
            
            stateConfig.cellBusinessState = XZLTakeMedicineHistoryCellBusinessStatePartTake;
        }
        if (date.dateIndexPath.item % 7 == 0) {
            
            stateConfig.cellBusinessState = XZLTakeMedicineHistoryCellBusinessStateAllMiss;
        }
        
        //确定cell 对应的月份
        if ([date isSameMonthWithDate_DQCalendar:calendarView.firstDate]) {
            
            stateConfig.dateState = XZLTakeMedicineHistoryDateStateCurrentMonth;
        } else {
            
            stateConfig.dateState = XZLTakeMedicineHistoryDateStatePreMonth;
        }
        
        [cell setStateConfig:stateConfig];
    }
}


#pragma mark - DQCalendarDelegate

- (void)calendarView:(DQCalendarView *)calendarView
       didSelectDate:(NSDate *)date
              ofCell:(XZLTakeMedicineHistoryCell *)cell {
    
    if (cell.stateConfig.cellBusinessState == XZLTakeMedicineHistoryCellBusinessStateNone) {
        
        [calendarView reloadItemsAtDates:[NSMutableSet setWithObjects:self.selectedDate, nil]];
        return;
    }
    
    NSDate *oldDate = [self.selectedDate copy];
    self.selectedDate = date;
    [calendarView reloadItemsAtDates:[NSMutableSet setWithObjects:oldDate, self.selectedDate, nil]];
}


#pragma mark - 懒加载

- (DQCalendarView *)calendarView {
    
    if (!_calendarView) {
        
        _calendarView = [[DQCalendarView alloc] initWithFrame:CGRectMake(0, 64+5, CGRectGetWidth(self.view.frame), 200)];
        [_calendarView registerCellClass:[XZLTakeMedicineHistoryCell class] withReuseIdentifier:@"historyCell"];
        _calendarView.dataSource = self;
        _calendarView.delegate = self;
        _calendarView.backgroundColor = [UIColor whiteColor];
        _calendarView.contentInsets = UIEdgeInsetsMake(-5, 0, 0, 0);
        _calendarView.cellScale = 1;
        _calendarView.sectionHeaderHeight = 27;
        _calendarView.weekViewHeight = 20;
        _calendarView.weekView.backgroundColor = [UIColor whiteColor];
    }
    return _calendarView;
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
