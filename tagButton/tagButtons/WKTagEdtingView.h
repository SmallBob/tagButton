//
//  WKTagEdtingView.h
//  tagButton
//
//  Created by developer_k on 16/3/18.
//  Copyright © 2016年 developer_k. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "WKTagButtonTextField.h"

@interface WKTagEdtingView : UIView

/*
 文本编辑
 */
@property(nonatomic,strong)WKTagButtonTextField*textField;

/*
 创建的btn数组
 注：只用于一次性创建和读取 btn， 单独创建不可用；
 */
@property(nonatomic,strong)NSMutableArray*btnArray;

/*
 辅助提示按钮
 */
@property(nonatomic,strong)UIButton* assBtn;


/*
 新增Btn
 */
-(void)creatBtnWithTitle:(NSString*)btnTitle;




@end
