//
//  CSJToolKit.h
//  CSJToolsDemo
//
//  Created by 曹 盛杰 on 14-3-1.
//  Copyright (c) 2014年 曹 盛杰. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "sys/xattr.h"

@interface CSJToolKit : NSObject
+ (CSJToolKit *)sharedManager;
+ (CGSize)textSize:(NSString*)text withFont:(UIFont*)font inWidth:(CGFloat)width;

///*******
+ (NSInteger)countWord:(NSString *)s;

+ (NSURL*)fileUrlForDirectory: (NSString *)name;
+ (NSURL*)fileUrlForName: (NSString *)name;
+ (NSURL*)fileUrlForTempName: (NSString *)name;
+ (NSURL*)fileUrlForJPGName: (NSString *)name;
+ (NSURL*)fileUrlForJsonType: (NSString *)type;
+ (void)AddSkipBackupAttributeToFile:(NSURL*)url;
+ (NSMutableDictionary*)dictionaryFromManagedObject:(NSManagedObject*)managedObject;

@end
