//
//  CSJHUD.h
//  ZhichengApp
//
//  Created by iceesj on 14-2-12.
//  Copyright (c) 2014年 iceesj. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "SVProgressHUD.h"
//#import "MBProgressHUD.h"
#import <MBProgressHUD/MBProgressHUD.h>

@interface CSJHUD : NSObject<MBProgressHUDDelegate>
{
    MBProgressHUD *HUD;
    
	long long expectedLength;
	long long currentLength;
}

+(CSJHUD *)Instance;

//提示对话框
+ (void)alert:(NSString *)message;
+ (void)alertWithTitle:(NSString *)title andMessage:(NSString *)message;

//类似于Android一个显示框效果
+ (void)toast:(UIViewController *)controller withMessage:(NSString *) message;
+ (void)toast:(NSString *)message;

//+ (void)simpleToast:(NSString *)message;
//+ (void)hideSimpleToast;

//显示在屏幕中间
+ (void)csjtoastCenter:(NSString *)message time:(NSTimeInterval)ti;

//带进度条
+ (void)progressToast:(NSString *)message;

//带遮罩效果的进度条
- (void)gradient:(UIViewController *)controller seletor:(SEL)method;

//显示遮罩
- (void)showProgress:(UIViewController *)controller;

//关闭遮罩
- (void)hideProgress;

//带说明的进度条
- (void)progressWithLabel:(UIViewController *)controller seletor:(SEL)method;

//显示带说明的进度条
- (void)showProgress:(UIViewController *)controller withLabel:(NSString *)labelText;
- (void)showCenterProgressWithLabel:(NSString *)labelText;

@end
