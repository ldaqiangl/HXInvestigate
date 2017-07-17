//
//  DQCalendarView.h
//  HXInvestigate
//
//  Created by 董富强 on 2017/6/2.
//  Copyright © 2017年 董富强. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DQCalendarWeekView.h"

@protocol DQCalendarDataSource;
@protocol DQCalendarDelegate;
@interface DQCalendarView : UIView
<DQCalendarWeekViewDelegate>

@property (nonatomic, weak) id<DQCalendarDataSource> dataSource;
@property (nonatomic, weak) id<DQCalendarDelegate> delegate;

@property (nonatomic, weak) DQCalendarWeekView *weekView;

@property (nonatomic, strong) NSMutableArray *currentDisplayDates;
@property (nonatomic, strong) NSDate *firstDate;
@property (nonatomic, strong) NSDate *lastDate;

@property (nonatomic, assign) DQCalendarViewConfig configure;
@property (nonatomic, assign) BOOL allowsSelection;
@property (nonatomic, assign) UIEdgeInsets contentInsets;
@property (nonatomic, assign) CGFloat minimumLineSpacing;
@property (nonatomic, assign) CGFloat weekViewHeight;
@property (nonatomic, assign) CGFloat sectionHeaderHeight;
@property (nonatomic, assign) CGFloat sectionFooterHeight;

@property (nonatomic, assign) CGPoint contentOffset;
@property (nonatomic, assign) CGFloat cellScale;// cellH/cellW
@property (nonatomic, assign, readonly) CGSize contentSize;


- (void)registerSectionHeader:(id)clazz
          withReuseIdentifier:(NSString *)identifier;
- (void)registerSectionFooter:(id)clazz
          withReuseIdentifier:(NSString *)identifier;
- (void)registerCellClass:(id)clazz
      withReuseIdentifier:(NSString *)identifier;

- (void)reloadData;
- (id)cellAtDate:(NSDate *)date;
- (void)reloadItemsAtDates:(NSSet<NSDate *> *)dates;
- (void)reloadItemsAtMonths:(NSSet<NSDate *> *)months;
- (void)setContentOffset:(CGPoint)contentOffset
                animated:(BOOL)animated;

- (id)cellForIndexPath:(NSIndexPath *)indexPath;
@end


/**
 日历视图代理
 */
@protocol DQCalendarDataSource <NSObject>

@required

- (void)calendarView:(DQCalendarView *)calendarView
       configureCell:(id)cell
             forDate:(NSDate *)date;

@optional

- (void)calendarView:(DQCalendarView *)calendarView
    configureSectionHeaderView:(id)headerView
    firstDateOfMonth:(NSDate *)firstDateOfMonth;

- (void)calendarView:(DQCalendarView *)calendarView
    configureSectionFooterView:(id)headerView
     lastDateOfMonth:(NSDate *)lastDateOfMonth;

- (void)calendarView:(DQCalendarView *)calendarView
    configureWeekDayLabel:(UILabel *)dayLabel
           atWeekDay:(NSInteger)weekDay;
@end

@protocol DQCalendarDelegate <NSObject>

@optional

- (BOOL)calendarView:(DQCalendarView *)calendarView
    shouldSelectDate:(NSDate *)date;

- (void)calendarView:(DQCalendarView *)calendarView
       didSelectDate:(NSDate *)date ofCell:(id)cell;

/**
 *  ScrollView delegate methods
 */
- (void)scrollViewDidScroll:(UIScrollView *)scrollView;
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView;
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate;
- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView;
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView;

@end













