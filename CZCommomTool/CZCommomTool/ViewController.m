//
//  ViewController.m
//  CZCommomTool
//
//  Created by chuanzhang on 2020/10/29.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 100)];
    [self.view addSubview:label];
    label.center = self.view.center;
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"测试中";
    label.textColor = [UIColor redColor];
    
  NSLog(@"测试网络 %ld",[CZ_CommonTool getNetWorkStatesWithHostName:@"www.baidu.com"]);
    
    
}


@end
