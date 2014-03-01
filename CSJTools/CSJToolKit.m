//
//  CSJToolKit.m
//  CSJToolsDemo
//
//  Created by 曹 盛杰 on 14-3-1.
//  Copyright (c) 2014年 曹 盛杰. All rights reserved.
//

#import "CSJToolKit.h"

@implementation CSJToolKit

+ (CGSize)textSize:(NSString*)text withFont:(UIFont*)font inWidth:(CGFloat)width{
    CGSize constraint = CGSizeMake(width, MAXFLOAT);
    
    NSDictionary* attrs = [NSDictionary dictionaryWithObjectsAndKeys: font, NSFontAttributeName, nil];
    NSAttributedString *attributedText = [[NSAttributedString alloc]initWithString:text attributes: attrs];
    CGRect rect = [attributedText boundingRectWithSize:constraint
                                               options:NSStringDrawingUsesLineFragmentOrigin
                                               context:nil];
    return rect.size;
}

@end
