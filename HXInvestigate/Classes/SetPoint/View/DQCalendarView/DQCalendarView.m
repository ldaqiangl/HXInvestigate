//
//  DQCalendarView.m
//  HXInvestigate
//
//  Created by 董富强 on 2017/6/2.
//  Copyright © 2017年 董富强. All rights reserved.
//

#import "DQCalendarView.h"

@interface DQCalendarView ()
<UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, weak) UICollectionView *collectionView;

@property (nonatomic, strong) NSString *sectionHeaderIdentifier;
@property (nonatomic, strong) NSString *sectionFooterIdentifier;
@property (nonatomic, strong) NSString *cellIdentifier;

@end
@implementation DQCalendarView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
        self.configure = DefualtCalendarViewConfig();
        [self createView];
    }
    return self;
}

- (void)createView {
    
    DQCalendarWeekView *weekView =
    [[DQCalendarWeekView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 0)];
    self.weekView = weekView;
    [self addSubview:self.weekView];
    
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    collectionView.backgroundColor = [UIColor clearColor];
    collectionView.dataSource = self;
    collectionView.delegate = self;
    self.collectionView = collectionView;
    [self addSubview:collectionView];
}


#pragma mark - public method

- (void)registerCellClass:(id)clazz withReuseIdentifier:(NSString *)identifier {
    
    self.cellIdentifier = identifier;
    [self.collectionView registerClass:clazz
            forCellWithReuseIdentifier:identifier];
}

- (void)registerSectionHeader:(id)clazz withReuseIdentifier:(NSString *)identifier {
    
    self.sectionHeaderIdentifier = identifier;
    [self.collectionView registerClass:clazz
            forSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                   withReuseIdentifier:identifier];
}

- (void)registerSectionFooter:(id)clazz withReuseIdentifier:(NSString *)identifier {
    
    self.sectionFooterIdentifier = identifier;
    [self.collectionView registerClass:clazz
            forSupplementaryViewOfKind:UICollectionElementKindSectionFooter
                   withReuseIdentifier:identifier];
}

- (void)setWeekViewHeight:(CGFloat)weekViewHeight {
    
    _weekViewHeight = weekViewHeight;
    self.weekView.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), _weekViewHeight);
}

- (void)setMinimumLineSpacing:(CGFloat)minimumLineSpacing {
    
    _minimumLineSpacing = minimumLineSpacing;
    
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *)self.collectionView.collectionViewLayout;
    if (_minimumLineSpacing > 0) {
        
        layout.minimumLineSpacing = _minimumLineSpacing;
    } else {
        
        layout.minimumLineSpacing = 0;
    }
    self.collectionView.collectionViewLayout = layout;
}

- (void)setBackgroundColor:(UIColor *)backgroundColor {
    
    self.collectionView.backgroundColor = backgroundColor;
    self.weekView.backgroundColor = backgroundColor;
}

- (void)setAllowsSelection:(BOOL)allowsSelection {
    
    _allowsSelection = allowsSelection;
    self.collectionView.allowsSelection = _allowsSelection;
}

- (void)setDataSource:(id<DQCalendarDataSource>)dataSource {
    
    _dataSource = dataSource;
    self.weekView.delegate = self;
}

- (void)reloadData {
    
    [self.collectionView reloadData];
}

- (id)cellAtDate:(NSDate *)date {
    
    NSIndexPath *indexPath = [NSDate indexPathAtDate:date firstDate:self.firstDate];
    return [self.collectionView cellForItemAtIndexPath:indexPath];
}

- (void)reloadItemsAtDates:(NSSet<NSDate *> *)dates {
    
    NSMutableArray *indexPaths = [NSMutableArray new];
    for (NSDate *date in dates) {
        
        //NSIndexPath *indexPath = [NSDate wholeIndexPathAtDate:date firstDate:self.firstDate];
        [indexPaths addObject:date.dateIndexPath];
    }
    [self.collectionView reloadItemsAtIndexPaths:indexPaths];
}

- (void)reloadItemsAtMonths:(NSSet<NSDate *> *)months {
    
    NSMutableIndexSet *indexSet = [NSMutableIndexSet indexSet];
    for (NSDate *date in months) {
        
        NSIndexPath *indexPath = [NSDate indexPathAtDate:date firstDate:self.firstDate];
        [indexSet addIndex:indexPath.section];
    }
    [self.collectionView reloadSections:indexSet];
}

- (void)setContentOffset:(CGPoint)contentOffset {
    
    _contentOffset = contentOffset;
    CGPoint origin = CGPointMake(_contentOffset.x - self.contentInsets.left, _contentOffset.y - self.contentInsets.top);
    [self.collectionView setContentOffset:origin];
}

- (void)setContentOffset:(CGPoint)contentOffset animated:(BOOL)animated {
    
    _contentOffset = contentOffset;
    CGPoint origin = CGPointMake(_contentOffset.x - self.contentInsets.left, _contentOffset.y - self.contentInsets.top);
    [self.collectionView setContentOffset:origin animated:YES];
}

- (CGSize)contentSize {
    
    return self.collectionView.contentSize;
}

- (id)cellForIndexPath:(NSIndexPath *)indexPath {
    
    return [self.collectionView cellForItemAtIndexPath:indexPath];
}


#pragma mark UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    NSInteger months = [NSDate numberOfMonthsFromDate:self.firstDate toDate:self.lastDate];
    return months;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView
           viewForSupplementaryElementOfKind:(NSString *)kind
                                 atIndexPath:(NSIndexPath *)indexPath {
    
    NSDate *firstDateOfMonth = [NSDate dateForFirstDayInSection:indexPath.section firstDate:self.firstDate];
    
    if (self.sectionHeaderIdentifier && [kind isEqualToString:UICollectionElementKindSectionHeader]) {
        
        id headerView =
        [collectionView dequeueReusableSupplementaryViewOfKind:kind
                                           withReuseIdentifier:self.sectionHeaderIdentifier
                                                  forIndexPath:indexPath];
        
        if (self.dataSource &&
            [self.dataSource respondsToSelector:@selector(calendarView:configureSectionHeaderView:firstDateOfMonth:)]) {
            
            [self.dataSource calendarView:self
               configureSectionHeaderView:headerView
                         firstDateOfMonth:firstDateOfMonth];
        }
        return headerView;
    } else if (self.sectionFooterIdentifier && [kind isEqualToString:UICollectionElementKindSectionFooter]) {
        
        id footerView =
        [collectionView dequeueReusableSupplementaryViewOfKind:kind
                                           withReuseIdentifier:self.sectionFooterIdentifier
                                                  forIndexPath:indexPath];
        
        if (self.dataSource &&
            [self.dataSource respondsToSelector:@selector(calendarView:configureSectionFooterView:lastDateOfMonth:)]) {
            
            [self.dataSource calendarView:self
               configureSectionFooterView:footerView
                          lastDateOfMonth:[firstDateOfMonth lastDateOfMonth_DQCalendar]];
        }
        return footerView;
    }
    
    return NULL;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    if (section == -1) {
        
        NSInteger weekDay = [self.firstDate weekday_DQCalendar];
        NSDate *lastDateOfMonth = [self.firstDate lastDateOfMonth_DQCalendar];
        NSInteger lastDateOfMonthWeekDay = [lastDateOfMonth weekday_DQCalendar];
        NSInteger items =
        weekDay + [NSDate numberOfNightsFromDate:self.firstDate toDate:lastDateOfMonth] + 7 - lastDateOfMonthWeekDay;
        return items;
    }
    
    NSDate *firstDay = [NSDate dateForFirstDayInSection:section firstDate:self.firstDate];
    NSInteger weekDay = [firstDay weekday_DQCalendar] - 1;
    
    NSDate *lastDateOfMonth = [firstDay lastDateOfMonth_DQCalendar];
    NSInteger lastWeekDay = [lastDateOfMonth weekday_DQCalendar];
    
    NSInteger items = weekDay + [NSDate numberOfDaysInMonth:firstDay] + 7 - lastWeekDay;
    return items;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    id cell = [collectionView dequeueReusableCellWithReuseIdentifier:self.cellIdentifier forIndexPath:indexPath];
    
    NSDate *date = [self dateForCollectionView:collectionView atIndexPath:indexPath];
    date.dateIndexPath = indexPath;
    
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(calendarView:configureCell:forDate:)]) {
        
        [self.dataSource calendarView:self configureCell:cell forDate:date];
    }
    
    return cell;
}


#pragma mark - UICollectionViewDelegate

- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSDate *date = [self dateForCollectionView:collectionView atIndexPath:indexPath];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(calendarView:shouldSelectDate:)]) {
        
        return [self.delegate calendarView:self shouldSelectDate:date];
    }
    
    return YES;
}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    return YES;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSDate *date = [self dateForCollectionView:collectionView atIndexPath:indexPath];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(calendarView:didSelectDate:ofCell:)]) {
        
        id cell = [collectionView cellForItemAtIndexPath:indexPath];
        [self.delegate calendarView:self didSelectDate:date ofCell:cell];
    }
}


#pragma mark UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
    referenceSizeForHeaderInSection:(NSInteger)section {
    
    if (self.sectionHeaderIdentifier) {
        
        if (self.sectionHeaderHeight > 0) {
            
            return CGSizeMake(CGRectGetWidth(collectionView.frame), self.sectionHeaderHeight);
        } else {
            
            return CGSizeMake(CGRectGetWidth(collectionView.frame), 52);
        }
    }
    return CGSizeZero;
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout*)collectionViewLayout
    referenceSizeForFooterInSection:(NSInteger)section {
    
    if (self.sectionFooterIdentifier) {
        
        if (self.sectionFooterIdentifier > 0) {
            
            return CGSizeMake(CGRectGetWidth(collectionView.frame), self.sectionFooterHeight);
        } else {
            
            return CGSizeMake(CGRectGetWidth(collectionView.frame), 13);
        }
    }
    return CGSizeZero;
}


#pragma mark - private methods

- (NSDate *)dateForCollectionView:(UICollectionView *)collection atIndexPath:(NSIndexPath *)indexPath {
    
    NSDate *date = nil;
    
    if (indexPath.section == -1) {
        
        NSDate *firstDay = [self.firstDate firstDateOfWeek_DQCalendar];
        NSDate *lastDateOfMonth = [self.firstDate lastDateOfMonth_DQCalendar];
        
        NSInteger items = [NSDate numberOfNightsFromDate:firstDay toDate:lastDateOfMonth];
        if (indexPath.row > items) {
            
        } else {
            
            NSCalendar *calendar = [NSDate gregorianCalendar];
            NSDateComponents *components = [calendar components:NSCalendarUnitMonth | NSCalendarUnitDay fromDate:firstDay];
            [components setDay:indexPath.row];
            [components setMonth:indexPath.section];
            date = [calendar dateByAddingComponents:components toDate:firstDay options:0];
            
            if (![self.firstDate isSameMonthWithDate_DQCalendar:date]) {
                date = nil;
            }
        }
    } else {
        
        date = [NSDate wholeDateAtIndexPath:indexPath firstDate:self.firstDate];
    }
    
    return date;
}


#pragma mark- UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    //  `contentOffset.x` = `collectionView.contentOffset.x` + `collectionView.contentInset.left`
    //  `contentOffset.y` = `collectionView.contentOffset.y` + `collectionView.contentInset.top`
    _contentOffset =
    CGPointMake(scrollView.contentOffset.x + self.collectionView.contentInset.left,
                scrollView.contentOffset.y + self.collectionView.contentInset.top);
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(scrollViewDidScroll:)]) {
        
        [self.delegate scrollViewDidScroll:scrollView];
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(scrollViewWillBeginDragging:)]) {
        
        [self.delegate scrollViewWillBeginDragging:scrollView];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    
    if (self.delegate &&
        [self.delegate respondsToSelector:@selector(scrollViewDidEndDragging:willDecelerate:)]) {
        
        [self.delegate scrollViewDidEndDragging:scrollView willDecelerate:decelerate];
    }
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView {
    
    if (self.delegate &&
        [self.delegate respondsToSelector:@selector(scrollViewWillBeginDecelerating:)]) {
        
        [self.delegate scrollViewWillBeginDecelerating:scrollView];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (self.delegate && [self.delegate respondsToSelector:@selector(scrollViewDidEndDecelerating:)]) {
        [self.delegate scrollViewDidEndDecelerating:scrollView];
    }
}


#pragma mark - DQCalendarWeekViewDelegate

- (void)calendarWeekView:(DQCalendarWeekView *)weekView
   configureWeekDayLabel:(UILabel *)dayLabel
               atWeekDay:(NSInteger)weekDay {
    
    if (self.dataSource &&
        [self.dataSource respondsToSelector:@selector(calendarView:configureWeekDayLabel:atWeekDay:)]) {
        
        [self.dataSource calendarView:self configureWeekDayLabel:dayLabel atWeekDay:weekDay];
    }
}


- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    
    // weekViewFrame
    if (self.weekViewHeight > 0) {
        
        self.weekView.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), self.weekViewHeight);
    } else {
        
        self.weekView.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), 46);
    }
    
    
    // collecitonViewFrame
    self.collectionView.frame =
    CGRectMake(0,CGRectGetMaxY(self.weekView.frame),
               CGRectGetWidth(self.frame),
               CGRectGetHeight(self.frame) - CGRectGetMaxY(self.weekView.frame));
    
    
    // cellWidth
    NSInteger collectionContentWidth =
    CGRectGetWidth(self.collectionView.frame) - self.contentInsets.left - self.contentInsets.right;
    
    NSInteger residue = collectionContentWidth % 7;
    CGFloat cellWidth = collectionContentWidth / 7.0;
    if (residue != 0) {
        
        CGFloat newPadding;
        if (residue > 7.0 / 2) {
            
            newPadding = self.contentInsets.left - (7 - residue) / 2.0;
            cellWidth = (collectionContentWidth + 7 - residue) / 7.0;
        } else {
            
            newPadding = self.contentInsets.left + (residue / 2.0);
            cellWidth = (collectionContentWidth - residue) / 7.0;
        }
        
        UIEdgeInsets inset = UIEdgeInsetsMake(self.contentInsets.top, newPadding, self.contentInsets.bottom, newPadding);
        self.contentInsets = inset;
    }
    
    self.collectionView.contentInset = self.contentInsets;
    self.collectionView.scrollIndicatorInsets = UIEdgeInsetsMake(self.contentInsets.top, 0, self.contentInsets.bottom, 0);
    self.weekView.contentInsets = self.contentInsets;
    
    
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *)self.collectionView.collectionViewLayout;
    
    // cellHeight
    layout.itemSize = CGSizeMake(cellWidth, (int)(cellWidth * self.cellScale));
//    if (self.cellScale > 0) {
//        
//        layout.itemSize = CGSizeMake(cellWidth, (int)(cellWidth * self.cellScale));
//    } else {
//        
//        layout.itemSize = CGSizeMake(cellWidth, cellWidth);
//    }
    self.collectionView.collectionViewLayout = layout;
    
    CGPoint contentOffset =
    CGPointMake(self.contentOffset.x - self.contentInsets.left,self.contentOffset.y - self.contentInsets.top);
    if (!CGPointEqualToPoint(self.collectionView.contentOffset,contentOffset)) {
        
        self.collectionView.contentOffset =
        CGPointMake(self.contentOffset.x - self.contentInsets.left, self.contentOffset.y - self.contentInsets.top);
    }
}

@end





















