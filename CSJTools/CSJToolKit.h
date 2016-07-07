//
//  CSJToolKit.h
//  ZhichengApp
//
//  Created by iceesj on 14-2-18.
//  Copyright (c) 2014年 iceesj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "Reachability.h"

@interface CSJToolKit : NSObject
+ (CSJToolKit *)sharedDirector;

+ (BOOL)isExistenceNetwork;
//+ (CGSize)textSize:(NSString*)text withFont:(UIFont*)font inWidth:(CGFloat)width inHeight:(CGFloat)height;
+ (NSInteger)countWord:(NSString *)s;
//+ (UIViewController *)viewController;

+ (NSInteger)MinBetweenDate:(NSDate *)fromDateTime andDate:(NSDate *)toDateTime;
+ (NSInteger)daysBetweenDate:(NSDate*)fromDateTime andDate:(NSDate*)toDateTime;

+ (NSMutableDictionary*) dictionaryFromManagedObject:(NSManagedObject*)managedObject;

+(NSInteger)qdyxRandomNumber;
+(NSInteger)qdyxRandomTime;

@end
