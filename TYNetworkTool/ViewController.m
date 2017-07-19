//
//  ViewController.m
//  TYNetworkTool
//
//  Created by 王天永 on 2017/7/18.
//  Copyright © 2017年 王天永. All rights reserved.
//

#import "ViewController.h"
//#import "TYNetworkTool.h"
#import "TYHttpRequest.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UIButton *noCacaheBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 30)];
    noCacaheBtn.center = self.view.center;
    noCacaheBtn.backgroundColor = [UIColor colorWithRed:arc4random() % 256 / 256.0 green:arc4random() % 256 / 256.0 blue:arc4random() % 256 / 256.0 alpha:1];
    [self.view addSubview:noCacaheBtn];
    [noCacaheBtn addTarget:self action:@selector(noCacheHttpRequest:) forControlEvents:UIControlEventTouchUpInside];
}
- (void)noCacheHttpRequest:(UIButton *)button {
    [TYHttpRequest getDataWithParameters:@{ @"accountId":@"d7dc065f4f224af4aa2066bcc3e32c7f",@"pageNo":@1,@"pageSize":@100,@"rankType":@0,@"type":@0} success:^(id response) {
        NSLog(@"%@",response);
    } failure:^(NSError *error) {
        
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
