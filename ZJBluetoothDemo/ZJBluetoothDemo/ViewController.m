//
//  ViewController.m
//  ZJBluetoothDemo
//
//  Created by 智鉴科技 on 2018/11/21.
//  Copyright © 2018年 com.bjzhijian.www. All rights reserved.
//

#import "ViewController.h"
#import "NSString+WiFiExtension.h"
#import <ZJBluetooth/ZJBluetoothManager.h>
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *errorCodeLabel;
@property (weak, nonatomic) IBOutlet UILabel *ssidLabel;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextFeild;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicatorView;
@property (nonatomic, copy) NSString *wifiSSID;
@property (weak, nonatomic) IBOutlet UITextField *macAddressLabel;
@end

@implementation ViewController
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (IBAction)ConfigNetworkButtonAction:(UIButton *)sender {
    __weak typeof(self) weakSelf = self;
    [self.activityIndicatorView startAnimating];
    sender.enabled = NO;
    
    //初始化SDK秘钥 可在 AppDelegate内初始化
    [ZJBluetoothManager initWithDefaultAESKey:@"1234567890123456" ivKey:@"1234567890123456"];
    //配置WiFi
    [[ZJBluetoothManager sharedManager] requestConfigNetworkByWiFiSSID:self.wifiSSID password:self.passwordTextFeild.text mac:self.macAddressLabel.text completeBlock:^(NSInteger errorCode) {
        
        [weakSelf.activityIndicatorView stopAnimating];
        sender.enabled = YES;
        weakSelf.errorCodeLabel.text = @(errorCode).stringValue;
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didBecomeActiveNotification) name:UIApplicationDidBecomeActiveNotification object:nil];
    [self reloadWiFiSSIDLabel];
}
- (void)didBecomeActiveNotification
{
    [self reloadWiFiSSIDLabel];
}
- (void)reloadWiFiSSIDLabel
{
    NSString *wifi_SSID = [NSString zj_getCurrentWifiSSID];
    self.ssidLabel.text = wifi_SSID.length?wifi_SSID:@"请手机联网后使用";
    self.wifiSSID = wifi_SSID;
}
@end
