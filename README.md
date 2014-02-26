#CSJTools

##About

CSJTools is an Objective-C library for iOS developers.

##Version
####0.0.5
* first version

####0.0.6
* add custom UINavigationController
* add use coredata FetchedResults tableviewcontroller

##Requirements
* iOS 6.0 or later
* must support ARC

##Installation with CocoaPods
#####Podfile
```
platform :ios, '6.0'
pod 'CSJTools'
```

##List
#####CSJMaster.h
```
//import all .h
```

#####CSJLog.h
```
//common define & log
```
#####CSJBase64.h
```
//return NSString/NSData base64 String
//NSString
+(NSString *)stringFromBase64String:(NSString *)base64String;
-(NSString *)base64String;

//NSData
+(NSData *)dataWithBase64String:(NSString *)base64String;
-(NSString *)base64String;

+(NSData *)dataFromBase64String:(NSString *)base64String;
+(NSString *)base64StringFromData:(NSData *)data;
```

#####CSJData.h
```
//天数差
+(NSInteger)daysBetweenDate:(NSDate*)fromDateTime andDate:(NSDate*)toDateTime;
//小时差
+(NSInteger)hoursBetweenDate:(NSDate *)fromDateTime andDate:(NSDate*)toDateTime;
//分钟差
+(NSInteger)minsBetweenDate:(NSDate*)fromDateTime andDate:(NSDate*)toDateTime;
//秒差
+(NSInteger)secondBetweenDate:(NSDate*)fromDateTime andDate:(NSDate*)toDateTime;

//返回当前年，月，日..
-(int)year;
-(int)month;
-(int)day;
-(int)hour;
-(int)minute;
-(int)second;
```

#####CSJDES.h
```
//与服务器的加密解密
//加密
- (NSString *) DESEncryptByKey:(NSString *)key;
//解密
- (NSString *) DESDecryptByKey:(NSString *)key;
```

#####CSJMD5.h
```
-(NSString *)fileMD5;
-(NSString *)stringMD5;
+(NSString *)md5:(NSString *)inPutText;
```

#####CSJString.h
```
//判断是否是电话号码
- (BOOL)isMobileNumber;
//email
-(BOOL)isEmailAddress;
```

#####CSJURL.h
```
-(NSString *)parameterForKey:(NSString *)key;
-(NSDictionary  *)parameters;

```

#####CSJ_NavGestureViewController
A custom gesture to return Navigationcontroller

#####CSJ_CoredataTableViewController
A automatic NSFetchedResults Coredata Tableviewcontroller


##Special thanks to
Thank them sparked my inspiration. Thank them for their contributions to the open source community.

* [ZXTools](https://github.com/zhangxigithub/ZXTools) 
* [RCNavigationController](https://github.com/RoCry/RCNavigationController)
* [cs193p Coredata](http://www.stanford.edu/class/cs193p/cgi-bin/drupal/node/389)

## License
CSJTools is available under the MIT license.