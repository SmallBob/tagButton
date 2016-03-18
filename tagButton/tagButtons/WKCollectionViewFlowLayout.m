//
//  WKCollectionViewFlowLayout.m
//  tagButton
//
//  Created by developer_k on 16/3/18.
//  Copyright © 2016年 developer_k. All rights reserved.
//

#import "WKCollectionViewFlowLayout.h"

@interface WKCollectionViewFlowLayout()
@property(nonatomic,weak)id <UICollectionViewDelegateFlowLayout>delegate;
@property(nonatomic,strong)NSMutableArray*itemAttributes;
@property(nonatomic,assign)CGFloat contentHeight;


@end

@implementation WKCollectionViewFlowLayout


-(instancetype)init
{
    if (self = [super init]) {
        [self setUpdate];
    }
    return self;
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        [self setUpdate];
    }
    return self;
}

-(NSMutableArray *)itemAttributes
{
    if (!_itemAttributes) {
        _itemAttributes = [NSMutableArray array ];
        
    }
    return _itemAttributes;
}

-(void)setUpdate
{
    self.itemSize = CGSizeMake(100.0f, 26.0f);
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.minimumInteritemSpacing = 10.0f;
    self.minimumLineSpacing = 10.0f;
    self.sectionInset = UIEdgeInsetsMake(10.0f, 10.0f, 10.0f, 10.0f);
    
}

-(void)prepareLayout
{
    [self.itemAttributes removeAllObjects];
    self.contentHeight = self.sectionInset.top + self.itemSize.height;
    
    CGFloat originX = self.sectionInset.left;
    CGFloat originY = self.sectionInset.top;
    
    NSInteger itemCount = [self.collectionView numberOfItemsInSection:0];
    for (NSInteger i = 0; i < itemCount; i++) {
        NSIndexPath * indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        CGSize itemSize = [self itemSizeForIndexPath:indexPath];
        
        if ((originX + itemSize.width +self.sectionInset.right/2 ) > self.collectionView.frame.size.width) {
            originX = self.sectionInset.left;
            originY += itemSize.height + self.minimumLineSpacing;
            
            self.contentHeight += itemSize.height + self.minimumLineSpacing;
        }
        UICollectionViewLayoutAttributes * att = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
        att.frame = CGRectMake(originX, originY, itemSize.width, itemSize.height);
        
        [self.itemAttributes addObject:att];
        
        originX += itemSize.width + self.minimumInteritemSpacing;
        
    }
    self.contentHeight += self.sectionInset.bottom;
    
}


-(CGSize)itemSizeForIndexPath:(NSIndexPath*)indexPath{
    if ([self.delegate respondsToSelector:@selector(collectionView:layout:sizeForItemAtIndexPath:)]) {
        self.itemSize = [self.delegate collectionView:self.collectionView layout:self sizeForItemAtIndexPath:indexPath];
    }
    return self.itemSize;

}

-(CGSize)collectionViewContentSize
{
    return CGSizeMake(self.collectionView.frame.size.width, self.contentHeight);
}

-(BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    CGRect oldBounds = self.collectionView.bounds;
    if (CGRectGetWidth(newBounds) != CGRectGetWidth(oldBounds)) {
        return YES;
    }
    return NO;
}

-(NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    return self.itemAttributes;
}

-(id<UICollectionViewDelegateFlowLayout>)delegate
{
    if (_delegate == nil) {
        _delegate = (id<UICollectionViewDelegateFlowLayout>)self.collectionView.delegate;
    }
    return _delegate;
}



@end
