//
//  CSJToolKit.m
//  CSJToolsDemo
//
//  Created by 曹 盛杰 on 14-3-1.
//  Copyright (c) 2014年 曹 盛杰. All rights reserved.
//

#import "CSJToolKit.h"

@implementation CSJToolKit
+ (CSJToolKit *)sharedManager {
    @synchronized(self) {
        static CSJToolKit *sharedManager = nil;
        if (sharedManager==nil) {
            sharedManager = [[CSJToolKit alloc]init];
        }
        return sharedManager;
    }
}

+ (CGSize)textSize:(NSString*)text withFont:(UIFont*)font inWidth:(CGFloat)width{
    CGSize constraint = CGSizeMake(width, MAXFLOAT);
    
    NSDictionary* attrs = [NSDictionary dictionaryWithObjectsAndKeys: font, NSFontAttributeName, nil];
    NSAttributedString *attributedText = [[NSAttributedString alloc]initWithString:text attributes: attrs];
    CGRect rect = [attributedText boundingRectWithSize:constraint
                                               options:NSStringDrawingUsesLineFragmentOrigin
                                               context:nil];
    return rect.size;
}

///**************
+ (NSInteger)countWord:(NSString *)s
{
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
    return l+(NSInteger)ceilf((float)(a+b)/2.0);
}

//文件路径 for 字典
+ (NSURL*)fileUrlForDirectory: (NSString *)name {
    NSArray *paths = [[NSFileManager defaultManager] URLsForDirectory:NSLibraryDirectory
                                                            inDomains:NSUserDomainMask];
    NSURL *libPath = [paths objectAtIndex:0];
    NSURL *fileUrl = [libPath URLByAppendingPathComponent: name];
    //防止云存储
    [self AddSkipBackupAttributeToFile:fileUrl];
    return fileUrl;
}

//通过文件name，返回文件路径
+ (NSURL*)fileUrlForName: (NSString *)name {
    NSArray *paths = [[NSFileManager defaultManager] URLsForDirectory:NSLibraryDirectory
                                                            inDomains:NSUserDomainMask];
    NSURL *libPath = [paths objectAtIndex:0];
    NSURL *fileUrl = [[libPath URLByAppendingPathComponent: name] URLByAppendingPathExtension:@"txt"];
    //防止云存储
    [self AddSkipBackupAttributeToFile:fileUrl];
    return fileUrl;
}


+ (NSURL*)fileUrlForTempName: (NSString *)name {
    NSArray *paths = [[NSFileManager defaultManager] URLsForDirectory:NSCachesDirectory
                                                            inDomains:NSUserDomainMask];
    NSURL *tempPath = [paths objectAtIndex:0];
    NSURL *fileUrl = [[tempPath URLByAppendingPathComponent: name] URLByAppendingPathExtension:@"txt"];
    //防止云存储
    [self AddSkipBackupAttributeToFile:fileUrl];
    return fileUrl;
}

+ (NSURL*)fileUrlForJPGName: (NSString *)name {
    NSArray *paths = [[NSFileManager defaultManager] URLsForDirectory:NSLibraryDirectory
                                                            inDomains:NSUserDomainMask];
    NSURL *libPath = [paths objectAtIndex:0];
    NSURL *fileUrl = [[libPath URLByAppendingPathComponent: name] URLByAppendingPathExtension:@"jpg"];
    //防止云存储
    [self AddSkipBackupAttributeToFile:fileUrl];
    return fileUrl;
}

+ (NSURL*)fileUrlForJsonType: (NSString *)type {
    NSArray *paths = [[NSFileManager defaultManager] URLsForDirectory:NSLibraryDirectory inDomains:NSUserDomainMask];
    
    NSURL *libPath = [paths objectAtIndex:0];
    NSURL *fileUrl = [[libPath URLByAppendingPathComponent: type] URLByAppendingPathExtension:@"plist"];
    //防止云存储
    [self AddSkipBackupAttributeToFile:fileUrl];
    return fileUrl;
}

//防止云存储
+ (void) AddSkipBackupAttributeToFile: (NSURL*) url //文件的URL
{
    if ([[NSFileManager defaultManager]fileExistsAtPath:url.path]) {
        [url setResourceValue: [NSNumber numberWithBool: YES] forKey: NSURLIsExcludedFromBackupKey error: nil];
        u_int8_t b = 1;
        setxattr([[url path] fileSystemRepresentation], "com.apple.MobileBackup", &b, sizeof(b), 0, 0);
    }
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
@end
