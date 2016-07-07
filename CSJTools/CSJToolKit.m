//
//  CSJToolKit.m
//  ZhichengApp
//
//  Created by iceesj on 14-2-18.
//  Copyright (c) 2014年 iceesj. All rights reserved.
//

#import "CSJToolKit.h"
#import <Reachability/Reachability.h>

#import <sys/socket.h>
#import <netinet/in.h>
#import <netinet6/in6.h>
#import <arpa/inet.h>
#import <ifaddrs.h>
#import <netdb.h>


@implementation CSJToolKit

+ (CSJToolKit *)sharedDirector {
    @synchronized(self) {
        static CSJToolKit *sharedDirector = nil;
        if (sharedDirector == nil) {
            sharedDirector = [[CSJToolKit alloc]init];
        }
        return sharedDirector;
    }
}

//判断当前网络是否可用
+ (BOOL)isExistenceNetwork{
    // Create zero addy
    struct sockaddr_in zeroAddress;
    bzero(&zeroAddress, sizeof(zeroAddress));
    zeroAddress.sin_len = sizeof(zeroAddress);
    zeroAddress.sin_family = AF_INET;
    
    // Recover reachability flags
    SCNetworkReachabilityRef defaultRouteReachability = SCNetworkReachabilityCreateWithAddress(NULL, (struct sockaddr *)&zeroAddress);
    SCNetworkReachabilityFlags flags;
    
    BOOL didRetrieveFlags = SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags);
    CFRelease(defaultRouteReachability);
    
    if (!didRetrieveFlags)
    {
        return NO;
    }
    
    BOOL isReachable = flags & kSCNetworkFlagsReachable;
    BOOL needsConnection = flags & kSCNetworkFlagsConnectionRequired;
    return (isReachable && !needsConnection) ? YES : NO;
    
    /*
    Reachability *r = [Reachability reachabilityWithHostname:@"http://www.baidu.com"];
    switch (r.currentReachabilityStatus) {
        case NotReachable:
//            isExistenceNetwork = NO;
            return NO;
            break;
        case ReachableViaWWAN:
//            isExistenceNetwork = YES;
            return YES;
            break;
        case ReachableViaWiFi:
//            isExistenceNetwork = YES;
            return YES;
            break;
        default:
            break;
    }
    */
}


//自动检label高度 iOS7
/*
+ (CGSize)textSize:(NSString*)text withFont:(UIFont*)font inWidth:(CGFloat)width inHeight:(CGFloat)height{
    CGSize constraint = CGSizeMake(width, height);
    
    NSDictionary* attrs = [NSDictionary dictionaryWithObjectsAndKeys: font, NSFontAttributeName, nil];
    NSAttributedString *attributedText = [[NSAttributedString alloc]initWithString:text attributes: attrs];
    CGRect rect = [attributedText boundingRectWithSize:constraint
                                               options:NSStringDrawingUsesLineFragmentOrigin
                                               context:nil];
    return rect.size;
}
*/

+(NSInteger)countWord:(NSString *)s{
    NSInteger i,n=[s length],l=0,a=0,b=0;
    unichar c;
    for(i=0;i<n;i++){
        c=[s characterAtIndex:i];
        if(isblank(c)){
            b++;
        }else if(isascii(c)){
            a++;
        }else{
            l++;
        }
    }
    if(a==0 && l==0) return 0;
    return l+(int)ceilf((float)(a+b)/2.0);
}

/*
+ (UIViewController *)viewController {
    UIResponder *responder = self;
    while (![responder isKindOfClass:[UIViewController class]]) {
        responder = [responder nextResponder];
        if (nil == responder) {
            break;
        }
    }
    return (UIViewController *)responder;
}
*/

+(NSInteger)MinBetweenDate:(NSDate *)fromDateTime andDate:(NSDate *)toDateTime{
    NSDate *fromDate;
    NSDate *toDate;
    NSCalendar *calendar = [NSCalendar currentCalendar];
    [calendar rangeOfUnit:NSCalendarUnitMinute startDate:&fromDate
                 interval:NULL forDate:fromDateTime];
    [calendar rangeOfUnit:NSCalendarUnitMinute startDate:&toDate
                 interval:NULL forDate:toDateTime];
    NSDateComponents *difference = [calendar components:NSCalendarUnitMinute
                                               fromDate:fromDate toDate:toDate options:0];
    return [difference minute];
}

+ (NSInteger)daysBetweenDate:(NSDate*)fromDateTime andDate:(NSDate*)toDateTime
{
    NSDate *fromDate;
    NSDate *toDate;
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    [calendar rangeOfUnit:NSCalendarUnitHour startDate:&fromDate
                 interval:NULL forDate:fromDateTime];
    //NSDayCalendarUnit,,NSHourCalendarUnit
    [calendar rangeOfUnit:NSCalendarUnitHour startDate:&toDate
                 interval:NULL forDate:toDateTime];
    
    NSDateComponents *difference = [calendar components:NSCalendarUnitHour
                                               fromDate:fromDate toDate:toDate options:0];
    
    return [difference hour];
}

//从存储对象变成字典
+ (NSMutableDictionary*)dictionaryFromManagedObject:(NSManagedObject*)managedObject
{
    if (managedObject==nil) {
        return [NSMutableDictionary dictionary];
    }
    
    NSDictionary *attributesByName = [[managedObject entity] attributesByName];
    //存储所有的值到 字典
    
    NSDictionary *valuesDictionary = [managedObject dictionaryWithValuesForKeys:[attributesByName allKeys]];
    NSMutableDictionary *resultDict = [NSMutableDictionary dictionary];
    
    [resultDict setObject:[[managedObject entity] name] forKey:@"ManagedObjectName"];
    
    for (NSString *attr in valuesDictionary) {
        id value = [valuesDictionary valueForKey:attr];
        
        if ([value isKindOfClass:[NSDate class]]) {
            NSDateFormatter * dateFormatter =[[NSDateFormatter alloc] init];
            dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
            value = [dateFormatter stringFromDate:value];
        }
        
        if ([value isKindOfClass:[NSNull class]]) {
            value = @"";
        }
        
        [resultDict setValue:value forKey:attr];
    }
    
    return resultDict;
}


+(NSInteger)qdyxRandomNumber{
    if (![[NSUserDefaults standardUserDefaults]integerForKey:@"qdyxRandomNumber"]){
        [[NSUserDefaults standardUserDefaults]setInteger:2 forKey:@"qdyxRandomNumber"];
        NSInteger ii = 1;
        return ii;
    }else{
        NSInteger oldPaixuNum = [[NSUserDefaults standardUserDefaults]integerForKey:@"qdyxRandomNumber"];
//        [dd setValue:[NSNumber numberWithInteger:oldPaixuNum] forKey:@"paixunum"];
        NSInteger newPaixuNum = oldPaixuNum+1;
        [[NSUserDefaults standardUserDefaults]setInteger:newPaixuNum forKey:@"qdyxRandomNumber"];
        return oldPaixuNum;
    }
    
}

+(NSInteger)qdyxRandomTime{
    NSDate *nowDate = [NSDate date];
//    NSString *nowDateString = [NSDate stringFromDate:nowDate withFormat:@"yyyy-MM-dd HH:mm:ss"];
//    NSString *nowDateString = [NSDate stringFromDate:nowDate];
    double nihao = [nowDate timeIntervalSince1970];
    NSInteger ii = nihao;
    return ii;
}

@end
