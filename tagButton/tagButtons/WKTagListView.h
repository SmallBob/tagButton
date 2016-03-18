//
//  WKTagListView.h
//  tagButton
//
//  Created by developer_k on 16/3/18.
//  Copyright © 2016年 developer_k. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^WKTagListViewBlock)(NSInteger index);

@interface WKTagListView : UIView
@property(nonatomic,strong)UIColor *tagStrokeColor ;
@property(nonatomic,strong)UIColor *tagTextColor;
@property(nonatomic,strong)UIColor *tagBackGroundColor;
@property(nonatomic,strong)UIColor *tagSelectedBackGroundColor;
@property(nonatomic,assign)CGFloat tagCornerRadius;//10
@property(nonatomic,assign)BOOL canSelectTags;//no

@property(nonatomic,strong)NSMutableArray*tags;
@property(nonatomic,strong,readonly)NSMutableArray*selectedTags;
@property(nonatomic,strong)UICollectionView *collectionView;


-(void)setCompletionBlockWithSelected : (WKTagListViewBlock)completionBlock;

@end
