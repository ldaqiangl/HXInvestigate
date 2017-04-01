//
//  HXSelectedClassesView.m
//  HXInvestigate
//
//  Created by 董富强 on 2016/11/10.
//  Copyright © 2016年 董富强. All rights reserved.
//

#import "HXSelectedClassesView.h"

#import "HXSelectedItemCell.h"
#import "HXSelecteClassesLayout.h"

#define ITEM_CELL_ID @"itemCell"

@interface HXSelectedClassesView ()
<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, assign) CGFloat itemBtnH;
@property (nonatomic, assign) CGFloat itemBtnW;
@property (nonatomic, assign) CGFloat leftEdge;

@property (nonatomic, strong) HXSelecteClassesLayout *layout;

@property (nonatomic, weak) UIButton *allBtn;
@property (nonatomic, weak) UIView *lineView;
@property (nonatomic, weak) UICollectionView *mainView;

@end

@implementation HXSelectedClassesView


#pragma mark - 初始化 -

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self createView];
    }
    return self;
}

- (void)createView {
    
    _leftEdge = PX_TO_PT(30);
    CGFloat upEdge = PX_TO_PT(40);
    CGFloat allBtnH = PX_TO_PT(64),allBtnW = PX_TO_PT(214);
    
    UIButton *allBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    allBtn.frame = CGRectMake(_leftEdge, upEdge, allBtnW, allBtnH);
    allBtn.backgroundColor = [UIColor whiteColor];
    allBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
    allBtn.layer.borderWidth = 1.0;
    [allBtn setTitle:@"全部" forState:UIControlStateNormal];
    [allBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [allBtn setBackgroundImage:[UIImage imageWithColor_Ext:[UIColor whiteColor]]
                      forState:UIControlStateNormal];
    [allBtn setTitle:@"取消全部" forState:UIControlStateSelected];
    [allBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [allBtn setBackgroundImage:[UIImage imageWithColor_Ext:[UIColor blueColor]]
                      forState:UIControlStateSelected];
    allBtn.titleLabel.font = [UIFont appFontWith_BSExt:26.0];
    [allBtn addTarget:self
               action:@selector(itemsBtnClicked:)
     forControlEvents:UIControlEventTouchUpInside];
    self.allBtn = allBtn;
    [self addSubview:self.allBtn];
    
    UIView *lineView =
    [[UIView alloc] initWithFrame:CGRectMake(_leftEdge, CGRectGetMaxY(allBtn.frame)+upEdge,
                                             CGRectGetWidth(self.frame)-2*_leftEdge, 1.0)];
    lineView.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:lineView];
    
    CGFloat mainViewY = CGRectGetMaxY(lineView.frame);
    CGFloat mainViewH = CGRectGetHeight(self.frame)-mainViewY,
            mainViewW = CGRectGetWidth(self.frame)-2*_leftEdge;
    
    _itemBtnH = PX_TO_PT(64);
    _itemBtnW = (mainViewW-2*_leftEdge)/3;
    
    _layout = [[HXSelecteClassesLayout alloc] initWithWidth:_itemBtnW andHeight:_itemBtnH];
    
    UICollectionView *mainView =
    [[UICollectionView alloc] initWithFrame:CGRectMake(_leftEdge, mainViewY, mainViewW, mainViewH) collectionViewLayout:_layout];
    mainView.backgroundColor = [UIColor clearColor];
    mainView.pagingEnabled = NO;
    mainView.showsHorizontalScrollIndicator = YES;
    mainView.showsVerticalScrollIndicator = YES;
    mainView.dataSource = self;
    mainView.delegate = self;
    mainView.contentInset = UIEdgeInsetsMake(_leftEdge, 0, 0, 0);
    [mainView registerClass:[HXSelectedItemCell class] forCellWithReuseIdentifier:ITEM_CELL_ID];
    mainView.scrollsToTop = NO;
    mainView.backgroundColor = [UIColor clearColor];
    self.mainView = mainView;
    [self addSubview:self.mainView];
    
}

- (void)setClassesItemArr:(NSMutableArray *)classesItemArr {
    
    _classesItemArr = classesItemArr;
    [self.mainView reloadData];
}


#pragma mark - UICollectionViewDataSource -

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section {
    
    return _classesItemArr.count;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    HXSelectedItemCell *cell =
    (HXSelectedItemCell *)[collectionView dequeueReusableCellWithReuseIdentifier:ITEM_CELL_ID
                                                                    forIndexPath:indexPath];
    
    [cell setCellInfoWithClassItem:[self.classesItemArr objectAtIndex:indexPath.item]];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView
    didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.classesItemArr.count > 0) {
        
        HXClassInfoItem *dataItem = [self.classesItemArr objectAtIndex:indexPath.item];
        dataItem.isSelected = !dataItem.isSelected;
        [self.mainView reloadData];
        
        __block BOOL isAllSelected = YES;
        [self.classesItemArr enumerateObjectsUsingBlock:
         ^(HXClassInfoItem *dataItem, NSUInteger idx, BOOL * _Nonnull stop) {
             if (!dataItem.isSelected) {
                 isAllSelected = NO;
                 *stop = YES;
             }
        }];
        self.allBtn.selected = isAllSelected;
    }
}


#pragma mark - 私有方法 -

/** 全部按钮点击事件 */
- (void)itemsBtnClicked:(UIButton *)sender {
    
    sender.selected = !sender.selected;
    
    __block BOOL allSelected = sender.selected;
    [self.classesItemArr enumerateObjectsUsingBlock:
     ^(HXClassInfoItem *dataItem, NSUInteger idx, BOOL * _Nonnull stop) {
         
         dataItem.isSelected = allSelected;
     }];
    [self.mainView reloadData];
    
}

@end
