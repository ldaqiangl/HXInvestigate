//
//
//  AddZSViewController.m
//  YiJianDoctor
//
//  Created by YJHou on 15/12/28.
//  Copyright © 2015年 YJHou. All rights reserved.
//

#import "BSShowPhotosView.h"


//参数调整
#define BS_DELBTN_W PX_TO_PT(45.0)
#define BS_ROW_MAX_COUNT 4 //每行图片数量
#define BS_CELL_MARGIN BS_DELBTN_W*0.5 //删除按钮到下一个图片的距离
@interface BSShowPhotoCollectionCell : UICollectionViewCell

@property (nonatomic, weak) UIImageView *picImageView;
@property (nonatomic, weak) UIButton *delBtn;

@property (nonatomic, strong) NSIndexPath *indexPath;
@property (nonatomic, copy) void(^delClicked)(NSIndexPath *cellIndexPath);

- (void)updateOnlyShowPicCellWith:(NSIndexPath *)indexPath andPicName:(NSString *)picName;
- (void)updatePicCellWith:(NSIndexPath *)indexPath andPicName:(NSString *)picName andDelImg:(NSString *)delImg andDelBlock:(void(^)(NSIndexPath *))delCom;

@end
@implementation BSShowPhotoCollectionCell

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        CGFloat delW = BS_DELBTN_W, delH = delW;
        CGFloat picX = 0.0, picY = delH*0.5;
        CGFloat picW = frame.size.width-delW*0.5, picH = frame.size.height-delH*0.5;
        
        UIImageView *picImageView = [[UIImageView alloc] initWithFrame:CGRectMake(picX, picY, picW, picH)];
        self.picImageView = picImageView;
        [self.contentView addSubview:self.picImageView];
        
        CGFloat delX = frame.size.width-delW, delY = 0.0;
        
        UIButton *delBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [delBtn addTarget:self action:@selector(delBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        delBtn.frame = CGRectMake(delX, delY, delW, delH);
        self.delBtn = delBtn;
        [self.contentView addSubview:self.delBtn];
    }
    return self;
}

- (void)updatePicCellWith:(NSIndexPath *)indexPath andPicName:(NSString *)picName andDelImg:(NSString *)delImg andDelBlock:(void(^)(NSIndexPath *))delCom {
    
    _indexPath = indexPath;
    self.delClicked = delCom;
    
    if (delImg) {
        
        UIImage *origalImg = [[BSPicHandle sharedBSPicHandle] obtainKnownOnePicWith_BSTool:picName];
        UIImage *displayImg = [[BSPicHandle sharedBSPicHandle] clipImageCenterWith_BS:origalImg andOrigalRect:self.picImageView.bounds];
        
        self.picImageView.image = displayImg;
        [self.delBtn setImage:[UIImage imageNamed:delImg] forState:UIControlStateNormal];
        
    } else {
        self.delBtn.hidden = YES;
        self.picImageView.image = [UIImage imageNamed:picName];
    }
}

- (void)updateOnlyShowPicCellWith:(NSIndexPath *)indexPath andPicName:(NSString *)picName {
    
    UIImage *origalImg = [[BSPicHandle sharedBSPicHandle] obtainKnownOnePicWith_BSTool:picName];
    UIImage *displayImg = [[BSPicHandle sharedBSPicHandle] clipImageCenterWith_BS:origalImg andOrigalRect:self.picImageView.bounds];
    
    self.picImageView.image = displayImg;

}


//删除
- (void)delBtnClicked:(UIButton *)sender {
    
    if (self.delClicked) {
        self.delClicked(self.indexPath);
    }
}

@end







#define BSShowPhotoCellId @"BSShowPicCell"
#define BSShowPhotoAddCellId @"BSShowPicCellAdd"
@interface BSShowPhotosView ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
    BOOL isDeletePicOperation;
    CGSize bsCurrentSize;
    NSInteger maxLimitCount;
    NSInteger _currentAllPicCount;
}

/** 视图 */
@property (nonatomic, weak) UICollectionView *picsContainerCollectionView;

/** 数据 */
@property (nonatomic, copy) NSString *delImageName;
@property (nonatomic, strong) NSMutableArray *photoDataSource;


@end

@implementation BSShowPhotosView

#pragma mark - lazy load dataSource -
- (NSMutableArray *)photoDataSource {
    if (!_photoDataSource) {
        _photoDataSource = [NSMutableArray array];
    }
    return _photoDataSource;
}


#pragma mark - 初始化和预处理 -
- (instancetype)init {
    if (self = [super init]) {
        isDeletePicOperation = NO;
//        _delImageName = @"bsDelPic";
        maxLimitCount = 5;
//        [self.photoDataSource addObject:@"bsAddPic"];
        [self initCollectionView];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        isDeletePicOperation = NO;
//        _delImageName = @"bsDelPic";
//        [self.photoDataSource addObject:@"bsAddPic"];
        maxLimitCount = 5;
        [self initCollectionView];
    }
    return self;
}

- (void)preparePhotoViewWithDelPic:(NSString *)delImage andAddPic:(NSString *)addImage andMaxPicCount:(NSInteger)maxCount {
    
    _delImageName = delImage;
    maxLimitCount = maxCount;
    
    [self.photoDataSource addObject:addImage];
    [self.picsContainerCollectionView reloadData];
}


- (void)initCollectionView {
    
    if (!_picsContainerCollectionView) {
        
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        
        UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:flowLayout];
        collectionView.delegate = self;
        collectionView.dataSource = self;
        collectionView.backgroundColor = self.backgroundColor;
        [collectionView registerClass:[BSShowPhotoCollectionCell class] forCellWithReuseIdentifier:BSShowPhotoCellId];
        [collectionView registerClass:[BSShowPhotoCollectionCell class] forCellWithReuseIdentifier:BSShowPhotoAddCellId];
        self.picsContainerCollectionView = collectionView;
        self.picsContainerCollectionView.collectionViewLayout = flowLayout;
        [self addSubview:self.picsContainerCollectionView];
        
        [BSPicHandle sharedBSPicHandle].reloadShowPicsView = ^(){
            isDeletePicOperation = YES;
            [self reloadShowPhotosView];
        };
        
    }
    
    self.picsContainerCollectionView.frame = self.bounds;
    [self.picsContainerCollectionView reloadData];
}
- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    [self initCollectionView];
}


#pragma mark - UICollectionViewDelegate && dataSource -
//dataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    if (!isDeletePicOperation) {
        //1.存储外界通过数据源代理传进来单张的UIImage 并生成imgName 返回给外界
        if ([self.dataSource respondsToSelector:@selector(showPhotosView:imageForIndex:)]) {
            
            UIImage *img = [self.dataSource showPhotosView:self imageForIndex:-1];
            NSString *imgName = [[BSPicHandle sharedBSPicHandle] storeOneImageWith_BSTool:img];
            if (imgName) {
                [self.photoDataSource insertObject:imgName atIndex:self.photoDataSource.count-1];
            }
            [self.dataSource showPhotosView:self imageForIndex:self.photoDataSource.count-1];
        }
        
        //2.询问外界要添加的多张图片
        if ([self.dataSource respondsToSelector:@selector(showPhotosView:imagesForindexArr:)]) {
            
            NSArray *imgArr = [self.dataSource showPhotosView:self imagesForindexArr:nil];
            
            NSMutableArray * imgIndexsArr = [NSMutableArray array];
                int currentInsertIndex = (int)self.photoDataSource.count-1;
                
                for (int i = 0; i < imgArr.count; i++) {
                    
                    [imgIndexsArr addObject:[NSNumber numberWithInt:i+currentInsertIndex]];
                    
                    NSString * imgName = [[BSPicHandle sharedBSPicHandle] storeOneImageWith_BSTool:imgArr[i]];
                    [self insertOjbectToDataSourceWithPicName:imgName];
            }
            
            
            
            [self.dataSource showPhotosView:self imagesForindexArr:imgIndexsArr];

        }
    }
    
    
    if ([self.delegate respondsToSelector:@selector(showPhotosViewPicDidAdd:andCurrentPics:)]&&_currentAllPicCount!=self.photoDataSource.count) {
        [self.delegate showPhotosViewPicDidAdd:self andCurrentPics:[self.photoDataSource subarrayWithRange:NSMakeRange(0, self.photoDataSource.count-1)]];
    }
    
    _currentAllPicCount = self.photoDataSource.count;
    return _delImageName?self.photoDataSource.count:self.photoDataSource.count - 1;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *cellId = (indexPath.item+1)==self.photoDataSource.count?BSShowPhotoAddCellId:BSShowPhotoCellId;
    BSShowPhotoCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    
    if (self.photoDataSource.count > 0) {
        
        __weak __typeof(self)weakSelf = self;
        if (_delImageName) {
            //删除按钮 除了最后的添加按钮为空 其他都需赋值
            NSString *delImgName = (indexPath.item+1)==self.photoDataSource.count?nil:_delImageName;
            
            [cell updatePicCellWith:indexPath andPicName:self.photoDataSource[indexPath.item] andDelImg:delImgName andDelBlock:^(NSIndexPath *cellIndexPath) {
                
                //删除图片的block操作
                isDeletePicOperation = YES;
                NSString *delImgName = weakSelf.photoDataSource[indexPath.item];
                if (delImgName) {
                    
                    [[BSPicHandle sharedBSPicHandle] clearDesignatedPicsWith:@[delImgName]];
                    [weakSelf.photoDataSource removeObjectAtIndex:cellIndexPath.item];
                    if ([self.delegate respondsToSelector:@selector(showPhotosViewDeletePics:andRemainingPics:)]) {
                        [self.delegate showPhotosViewDeletePics:self andRemainingPics:[self.photoDataSource subarrayWithRange:NSMakeRange(0, self.photoDataSource.count-1)]];
                    }
                }
                [weakSelf.picsContainerCollectionView reloadData];
            }];
        } else {
            
            [cell updateOnlyShowPicCellWith:indexPath andPicName:self.photoDataSource[indexPath.item]];
        }
    }
    return cell;
}

//delegate
//选择了某个cell
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
    isDeletePicOperation = NO;
    if (indexPath.item+1 == self.photoDataSource.count) {//添加图片
        
        if (self.photoDataSource.count-1<maxLimitCount) {//到达容纳图片数量上限
            
            if ([self.delegate respondsToSelector:@selector(showPhotosViewAddDidSelected:andCurrentPics:)]) {
                
                NSArray *currentPicNames;
                if (self.photoDataSource.count > 1) {
                    currentPicNames = [self.photoDataSource subarrayWithRange:NSMakeRange(0, self.photoDataSource.count-1)];
                } else {
                    currentPicNames = @[];
                }
                
                [self.delegate showPhotosViewAddDidSelected:self andCurrentPics:currentPicNames];
            }
        } else {
            
            if ([self.delegate respondsToSelector:@selector(showPhotosView:withLimitMaxCount:andCurrentPicNames:)]) {
                [self.delegate showPhotosView:self withLimitMaxCount:maxLimitCount andCurrentPicNames:[self.photoDataSource subarrayWithRange:NSMakeRange(0, self.photoDataSource.count-1)]];
            }
        }
    } else {//浏览图片
        
        if ([self.delegate respondsToSelector:@selector(showPhotosViewScanPics:withAllPicNames:andClickedIndex:)]) {
            
            [self.delegate showPhotosViewScanPics:self withAllPicNames:[self.photoDataSource subarrayWithRange:NSMakeRange(0, self.photoDataSource.count-1)] andClickedIndex:indexPath.item];
        }
        
    }
}
//取消选择了某个cell
- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
    
}


//UICollectionViewDelegateFlowLayout
//定义每个UICollectionViewCell 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CGFloat bs_device_w = [UIScreen mainScreen].bounds.size.width;
    CGFloat cellW = (bs_device_w-(BS_ROW_MAX_COUNT-1)*BS_CELL_MARGIN)/BS_ROW_MAX_COUNT;
    bsCurrentSize = CGSizeMake(cellW,cellW);
    return bsCurrentSize;
}
//定义每个Section 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    
    return UIEdgeInsetsMake(0, 0, 0, 0);//分别为上、左、下、右
}
//每个section中不同的行之间的行间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    
    return BS_CELL_MARGIN*0.5;
}
//每个item之间的间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    
    return 0;
}


/*预留以后添加说明文字
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    UICollectionReusableView *reusableview = nil;
    if (kind == UICollectionElementKindSectionHeader) {
        myView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"meHeaderView" forIndexPath:indexPath];
        reusableview = headerView;
        headerView.backgroundColor = [UIColor redColor];
    }
    return reusableview;
}
//返回头headerView的大小
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    CGSize size={320,450};
    return size;
}
 */


#define mark - reload method -
- (void)reloadShowPhotosView {
    
    [self.picsContainerCollectionView reloadData];
}

- (void)cleanAllPicsAndPicCache {
    
    NSLog(@">>>>>>>清除所有图片>>>>>>>>>");
    [self.photoDataSource removeAllObjects];
    [[BSPicHandle sharedBSPicHandle] clearDesignatedPicsWith:nil];
  
}


- (void)insertOjbectToDataSourceWithPicName:(NSString *)picName {
    
    BOOL isExist = NO;
    for (NSString *subName in self.photoDataSource) {
        if ([subName isEqualToString:picName]) {
            isExist = YES;
        }
    }
    
    if (!isExist) {
        [self.photoDataSource insertObject:picName atIndex:self.photoDataSource.count-1];
    }

}

@end





