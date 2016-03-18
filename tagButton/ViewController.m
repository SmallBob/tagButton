//
//  ViewController.m
//  tagButton
//
//  Created by developer_k on 16/3/18.
//  Copyright © 2016年 developer_k. All rights reserved.
//

#import "ViewController.h"
#import "WKTagListView.h"
#import "WKTagEdtingView.h"
@interface ViewController ()

@property(nonatomic,strong)WKTagListView*listView;
@property(nonatomic,strong)WKTagEdtingView*edtingView;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.edtingView = [[WKTagEdtingView alloc]initWithFrame:CGRectMake(10, 40, self.view.bounds.size.width-20, 200)];
    self.edtingView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:self.edtingView];
    
    
    self.listView = [[WKTagListView alloc]init];
    self.listView.backgroundColor = [UIColor grayColor];
    self.listView.frame = CGRectMake(10, 260, self.view.bounds.size.width-20, 200);
    self.listView.canSelectTags = YES;
    
    [self.listView.tags addObjectsFromArray:@[@"NSString",@"NSArray",@"UILabel"]];
    
    __weak typeof(self)WeakSelf = self;
    
    [self.listView setCompletionBlockWithSelected:^(NSInteger index) {
        NSLog(@"----%d---",index);
        
        [WeakSelf.edtingView creatBtnWithTitle:WeakSelf.listView.tags[index]];
        
        
    }];
    
    [self.listView.collectionView reloadData];
    
    [self.view addSubview:self.listView];
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
