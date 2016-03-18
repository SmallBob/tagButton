//
//  WKTagButtonTextField.m
//  tagButton
//
//  Created by developer_k on 16/3/18.
//  Copyright © 2016年 developer_k. All rights reserved.
//

#import "WKTagButtonTextField.h"

@implementation WKTagButtonTextField


-(void)deleteBackward{
 
    if (self.block) {
        self.block();
    }
    [super deleteBackward];
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
