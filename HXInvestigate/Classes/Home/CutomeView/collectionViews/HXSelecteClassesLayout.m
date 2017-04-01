//
//  HXSelecteClassesLayout.m
//  HXInvestigate
//
//  Created by 董富强 on 2016/11/10.
//  Copyright © 2016年 董富强. All rights reserved.
//

#import "HXSelecteClassesLayout.h"

#define bskScreen_Height      ([UIScreen mainScreen].bounds.size.height)
#define bskScreen_Width       ([UIScreen mainScreen].bounds.size.width)

@interface HXSelecteClassesLayout ()

@property (nonatomic, assign) CGFloat itemBtnH;
@property (nonatomic, assign) CGFloat itemBtnW;
@property (nonatomic, assign) CGFloat leftEdge;

@end

@implementation HXSelecteClassesLayout

- (instancetype)initWithWidth:(CGFloat)w andHeight:(CGFloat)h {
    if (self = [super init]) {
        
        _itemBtnW = w;_itemBtnH = h;
        self.minimumLineSpacing = PX_TO_PT(30);
        self.itemSize = CGSizeMake(_itemBtnW, 30);
        self.scrollDirection = UICollectionViewScrollDirectionVertical;
        self.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    }
    return self;
}

- (void)prepareLayout {
    
    [super prepareLayout];
    self.itemSize = CGSizeMake(_itemBtnW, _itemBtnH);
}

- (CGSize)collectionViewContentSize {
    
    NSInteger itemsCount = [self.collectionView numberOfItemsInSection:0];
    CGFloat contentW = CGRectGetWidth(self.collectionView.frame);
    CGFloat contentH = (self.minimumLineSpacing+_itemBtnH)*(itemsCount/3+1);
    return CGSizeMake(contentW , contentH);
}

//+ (Class)layoutAttributesClass {
//
//}

/*
 - (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
 
 }
 - (UICollectionViewLayoutAttributes *)layoutAttributesForInteractivelyMovingItemAtIndexPath:(NSIndexPath *)indexPath withTargetPosition:(CGPoint)position {
 
 }
 - (UICollectionViewLayoutAttributes *)layoutAttributesForSupplementaryViewOfKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath {
 
 }
 - (UICollectionViewLayoutAttributes *)layoutAttributesForDecorationViewOfKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath {
 
 }

 */
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return YES;
}

@end
