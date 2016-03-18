//
//  WKTagButtonTextField.h
//  tagButton
//
//  Created by developer_k on 16/3/18.
//  Copyright © 2016年 developer_k. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^WKTagButtonTextFieldBlock)();

@interface WKTagButtonTextField : UITextField

@property(nonatomic,copy)WKTagButtonTextFieldBlock block;


@end
