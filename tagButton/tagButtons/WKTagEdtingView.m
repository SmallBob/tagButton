//
//  WKTagEdtingView.m
//  tagButton
//
//  Created by developer_k on 16/3/18.
//  Copyright © 2016年 developer_k. All rights reserved.
//

#import "WKTagEdtingView.h"


#define kDisPathQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)


@interface WKTagEdtingView()<UITextFieldDelegate>


@end

@implementation WKTagEdtingView

static CGFloat WKTagMinLength = 30;  //textfeild 最小保持宽度
static CGFloat WKDistanceLength = 10;
static CGFloat MAXTagCount = 50 ;

#pragma mark - 懒加载
-(NSMutableArray *)btnArray
{
    if (_btnArray == nil) {
        _btnArray = [NSMutableArray array ];
        
    }
    return _btnArray;
}

-(WKTagButtonTextField *)textField
{
    if (!_textField) {
        _textField = [[WKTagButtonTextField alloc]initWithFrame:[self updateTextFrame]];
        
       // _textField.placeholder = @"";
        
        _textField.backgroundColor = [UIColor clearColor];
        _textField.delegate = self;
        _textField.font = [UIFont systemFontOfSize:14.0f];
        _textField.frame = CGRectMake(WKDistanceLength, WKDistanceLength, self.bounds.size.width-2*WKDistanceLength, 26); // 定制一个高度
        
        [_textField addTarget:self action:@selector(textFielddidChange:) forControlEvents:UIControlEventEditingChanged];
        
        __weak typeof(self)WeakSelf = self;
        
        _textField.block = ^{
            if (![WeakSelf.textField hasText]) {
                UIButton*btn = WeakSelf.btnArray.lastObject;
                btn.state != UIControlStateSelected ?  [btn setSelected:YES]:[WeakSelf tagBtnClick:btn];
                
            }
            
        };
        
    }
    return _textField;
}

#pragma mark - 辅助
-(UIButton *)assBtn
{
    if (!_assBtn) {
        _assBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _assBtn.backgroundColor = [UIColor blueColor];
        _assBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [_assBtn addTarget:self action:@selector(assBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _assBtn;
}


-(void)layoutSubviews
{
    [self addSubview:self.textField];
}


#pragma mark - 计算textField 位置
-(CGRect)updateTextFrame
{
    // x y 固定
    CGFloat height = 26;
    
    //计算宽高
    //取最后一个btn
    UIButton* btn = self.btnArray.lastObject;
    
    //无按钮 直接定位
    if (btn == nil) {
        return CGRectMake(WKDistanceLength, WKDistanceLength, self.bounds.size.width-2*WKDistanceLength, height);
    }
    
    // 占据的我宽度   按钮宽度 ＋ x坐标偏移位置 ＋ 间距
    CGFloat widthPart = btn.frame.size.width + btn.frame.origin.x + WKDistanceLength;
    
    //x  view宽度 － 占据的宽度 > textfield 最小预留的宽度 ？   是否越界
    CGFloat x = self.bounds.size.width - widthPart > WKTagMinLength ? widthPart : WKDistanceLength;
    
    
    CGFloat y = self.bounds.size.width - widthPart > WKTagMinLength ? btn.frame.origin.y : btn.frame.origin.y + WKDistanceLength + btn.frame.size.height;
    CGFloat width = x == WKDistanceLength ? self.bounds.size.width - 2*WKDistanceLength : self.bounds.size.width - widthPart - WKDistanceLength;
    
    CGRect frame = CGRectMake(x,y , width, height);
    return frame;
    
    
}


#pragma mark - 添加btn
-(void)creatBtnWithTitle:(NSString*)btnTitle
{
    
    
    UIButton*btn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    //去掉首尾空格
    btnTitle = [btnTitle stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if ([btnTitle isEqualToString:@""]||[btnTitle isKindOfClass:[NSNull class]]||btnTitle == nil) {
        NSLog(@"null");
        return;
    }
    
    [btn setTitle:btnTitle forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    btn.backgroundColor = [UIColor grayColor];
    
    [btn setTitleColor:[UIColor blueColor] forState:UIControlStateSelected];
    
    btn.titleEdgeInsets = UIEdgeInsetsMake(2, 2, 2, 2);
    [btn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    
    
    
    btn.layer.borderColor = [UIColor lightGrayColor].CGColor;
    btn.layer.borderWidth = 1;
    btn.layer.cornerRadius = 5;
    
    [btn addTarget:self action:@selector(tagBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    
    CGSize sizeToFit = [btnTitle boundingRectWithSize:CGSizeMake(MAXFLOAT, 26)
                                              options:\
                        NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                           attributes:@{NSFontAttributeName : btn.font}
                                              context:nil].size ;
    //提前在 上下左右 做好偏移
    
    btn.frame = CGRectMake(0, 0, sizeToFit.width+8, sizeToFit.height+4);
//    [btn sizeToFit];
    //btn宽高
    if (btn.frame.size.width > self.frame.size.width - 2 * WKDistanceLength) {
        CGRect frame = btn.frame;
        frame.size.width = self.bounds.size.width - 2*WKDistanceLength;
        btn.frame = frame;
        
        
    }
    //判定
    UIButton*lastBtn = self.btnArray.lastObject;
    if (lastBtn == nil) {
        CGRect frame = btn.frame;
        frame.origin.x = WKDistanceLength;
        frame.origin.y = WKDistanceLength;
        btn.frame = frame;
    }else{
        CGFloat widthPart = lastBtn.frame.origin.x + lastBtn.frame.size.width + WKDistanceLength ;
        CGRect frame = btn.frame;
        frame.origin.x = self.bounds.size.width - widthPart > btn.frame.size.width ? widthPart : WKDistanceLength;
        frame.origin.y = self.bounds.size.width - widthPart > btn.frame.size.width ? lastBtn.frame.origin.y :lastBtn.frame.origin.y + lastBtn.frame.size.height + WKDistanceLength;
        btn.frame = frame;
        
    }
    
    //添加btn
    dispatch_async(kDisPathQueue, ^{
        NSMutableArray*titleAry = [NSMutableArray array ];
        for (int i = 0 ; i < self.btnArray.count; i++) {
            UIButton*btn = (UIButton*)self.btnArray[i];
            [titleAry addObject:btn.titleLabel.text];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if (![titleAry containsObject:btn.titleLabel.text]) {
                [self.btnArray addObject:btn];
                [self addSubview:btn];
                self.textField.frame = [self updateTextFrame];
            }else{
                NSLog(@"已经存在同名btn");
            }
        });
    });
    
    
    
    
}

-(void)tagBtnClick:(UIButton*)sender
{
    [sender removeFromSuperview];
    [self.btnArray removeObject:sender];
    
    [UIView animateWithDuration:0.1 animations:^{
        [self updateTagsFrame];
        self.textField.frame =  [self updateTextFrame];
        self.assBtn.frame = CGRectMake(self.textField.frame.origin.x, self.textField.frame.origin.y+self.textField.frame.size.height, self.textField.frame.size.width, self.textField.frame.size.height);
    }];
}


//更新所有tagbtn的frame
-(void)updateTagsFrame
{
    UIButton *lastBtn = nil;
    for (int i = 0; i<self.btnArray.count; i++) {
        
        UIButton*btn = self.btnArray[i];
        CGRect frame = btn.frame;
        
        if (lastBtn == nil) {
            frame.origin.x = WKDistanceLength;
            frame.origin.y = WKDistanceLength;
        }else{
            CGFloat widthPart = lastBtn.frame.origin.x + lastBtn.frame.size.width + WKDistanceLength ;
           
            frame.origin.x = self.bounds.size.width - widthPart > btn.frame.size.width ? widthPart : WKDistanceLength;
            frame.origin.y = self.bounds.size.width - widthPart > btn.frame.size.width ? lastBtn.frame.origin.y :lastBtn.frame.origin.y + lastBtn.frame.size.height + WKDistanceLength;
            
            
        }
        
        btn.frame = frame;
        lastBtn = btn;
        
    }
}

//辅助按钮功能
-(void)assBtnClick
{
    [self textFieldShouldReturn:self.textField];
    
}



#pragma mark - textFeildDelegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (self.btnArray.count >= MAXTagCount) {
        return NO;
    }
    
    if ([textField.text isEqualToString:@" "]||[textField.text isKindOfClass:[NSNull class]]||textField.text == nil) {
        return NO;
    }
    
    [self creatBtnWithTitle:textField.text];
    self.textField.text = nil;
    [self.assBtn removeFromSuperview];
    return YES;
    
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
    
    if (string.length == 0) {
        return YES;
    }
    NSInteger existedLength = textField.text.length;
    NSInteger selectedLength = range.length;
    NSInteger replaceLength = string.length;
    if (existedLength - selectedLength + replaceLength >12) {
        return NO;
    }
    
    if ([NSStringFromRange(range) isEqualToString:@"{0, 0}"]) {
        self.assBtn.frame = CGRectMake(textField.frame.origin.x, textField.frame.origin.y+textField.frame.size.height, textField.frame.size.width,textField.frame.size.height);
        [self addSubview:self.assBtn];
    }
    NSString*assBtnStr = [@"点击添加标签：" stringByAppendingString:textField.text];
    [self.assBtn setTitle:assBtnStr forState:UIControlStateNormal];
    
    //换行
    CGFloat stringWidth = [self.assBtn.titleLabel.text sizeWithFont:self.assBtn.titleLabel.font constrainedToSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX)].width;
    if (stringWidth > self.assBtn.frame.size.width && self.assBtn.frame.origin.x != WKDistanceLength) {
        UIButton*btn = self.btnArray.lastObject;
        [UIView animateWithDuration:0.1 animations:^{
            CGRect frame = self.textField.frame;
            frame.origin.x = WKDistanceLength;
            frame.origin.y = btn.frame.size.height+btn.frame.origin.y +WKDistanceLength;
            frame.size.width = self.bounds.size.width - 2*WKDistanceLength ;
            self.textField.frame = frame;
            self.assBtn.frame = CGRectMake(textField.frame.origin.x, textField.frame.origin.y+textField.frame.size.height, textField.frame.size.width, textField.frame.size.height);
            
        }];
    }
    
    if ([string isEqualToString:@","]&&range.location != 0 ) {
        [self textFieldShouldReturn:self.textField];
        return NO;
    }
    
    return YES;
}

#pragma mark - textFied tager
-(void)textFielddidChange:(UITextField*)sender
{
    if (sender.text.length > 12) {
        sender.text = [sender.text substringToIndex:12];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
