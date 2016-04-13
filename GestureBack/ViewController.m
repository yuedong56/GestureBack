//
//  ViewController.m
//  GestureBack
//
//  Created by 老岳 on 15/5/7.
//  Copyright (c) 2015年 Smartisan_Laoyue. All rights reserved.
//

#import "ViewController.h"
#import "DemoViewController.h"

@interface ViewController ()<UIGestureRecognizerDelegate> //第一步，添加UIGestureRecognizerDelegate

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UILabel *label = [[UILabel alloc] initWithFrame:self.view.bounds];
    label.text = @"首页";
    label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:label];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 100, [UIScreen mainScreen].bounds.size.width, 80);
    button.backgroundColor = [UIColor lightGrayColor];
    [button setTitle:@"点击弹出二级视图（首页）" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor darkGrayColor] forState:UIControlStateHighlighted];
    [self.view addSubview:button];
    [button addTarget:self action:@selector(button) forControlEvents:UIControlEventTouchUpInside];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    //第二步
    //viewWillAppear 打开滑动返回手势。打开后实现第四步UIGestureRecognizer的代理方法
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    //第三步
    //viewWillDisappear 时，取消delegate
    self.navigationController.interactivePopGestureRecognizer.delegate = nil;
}

#pragma mark - button events
- (void)button
{
    [self.navigationController pushViewController:[DemoViewController new] animated:YES];
}

//第四步
#pragma mark - UIGestureRecognizer Delegate
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    //判断是否是一级视图，若是则关闭滑动返回手势
    if (self.navigationController.viewControllers.count == 1)    {
        return NO;
    }
    else
    {
        return YES;
    }
}

@end
