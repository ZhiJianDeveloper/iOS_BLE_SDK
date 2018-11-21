//
//  ViewController.swift
//  ZJBluetoothSwiftDemo
//
//  Created by 智鉴科技 on 2018/11/21.
//  Copyright © 2018年 com.bjzhijian.www. All rights reserved.
//

import UIKit
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        ZJBluetoothManager.shared()?.requestConfigNetwork(byWiFiSSID: "1", password: "1", mac: "12:23:34:45:56", complete: { (errorCode) in
          print(errorCode)
        })
    }


}

