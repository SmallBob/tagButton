//
//  WKTagCollectionViewCell.m
//  tagButton
//
//  Created by developer_k on 16/3/18.
//  Copyright © 2016年 developer_k. All rights reserved.
//

#import "WKTagCollectionViewCell.h"

@implementation WKTagCollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.layer.masksToBounds = YES;
        self.layer.borderWidth = 1.0f;
        
        _titleLabel = [[UILabel alloc]initWithFrame:self.bounds];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = [UIFont systemFontOfSize:14.0f];
        [self.contentView addSubview: _titleLabel];
        
    }
    return self;
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    self.titleLabel.frame = self.bounds;
}
-(void)prepareForReuse
{
    [super prepareForReuse];
    self.titleLabel.text = @"";
}

@end
