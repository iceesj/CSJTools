//
//  ViewController.m
//  CSJToolsDemo
//
//  Created by 曹 盛杰 on 14-2-7.
//  Copyright (c) 2014年 曹 盛杰. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSString *st = @"nicainicanicnianicani";
    NSString *base64ST = [st base64String];
    NSLog(@"base64ST == %@",base64ST);
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
