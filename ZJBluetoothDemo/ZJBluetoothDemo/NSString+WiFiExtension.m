//
//  NSString+WiFiExtension.m
//  ZhiJianBluetooth
//
//  Created by 智鉴科技 on 2018/11/19.
//  Copyright © 2018年 com.bjzhijian.www. All rights reserved.
//

#import "NSString+WiFiExtension.h"
#import <SystemConfiguration/CaptiveNetwork.h>
#import <ifaddrs.h>
#import <arpa/inet.h>
@implementation NSString (WiFiExtension)
+ (NSString *)zj_getCurrentWifiSSID
{
    NSString *wifiName = nil;
    CFArrayRef myArray = CNCopySupportedInterfaces();
    if (myArray != nil) {
        CFDictionaryRef myDict = CNCopyCurrentNetworkInfo(CFArrayGetValueAtIndex(myArray, 0));
        if (myDict != nil) {
            NSDictionary *dict = (NSDictionary*)CFBridgingRelease(myDict);
            wifiName = [dict valueForKey:@"SSID"];
        }
    }else{
        myArray = nil;
    }
    return wifiName;
}
@end
