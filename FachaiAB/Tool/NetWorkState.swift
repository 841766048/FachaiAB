//
//  NetWorkState.swift
//  FachaiAB
//
//  Created by 张海彬 on 2024/1/11.
//

import Foundation
import CoreTelephony
import Reachability

func hasNetWorkPermission() -> Bool {
    let reachability = try! Reachability()
    let networkStatus = reachability.connection
    switch networkStatus {
    case .none, .unavailable:
        return false
    default:  
        return true
    }
}

class NetWorkState {
    // Network auth status
    static func networkAuthStatus(_ block: (() -> ())? = nil) {
        let cellularData = CTCellularData()
        cellularData.cellularDataRestrictionDidUpdateNotifier = { state in
            switch state {
            case .restricted:
                // 拒绝
                self.networkSettingAlert()
            case .notRestricted:
                // 允许
                block?()
            case .restrictedStateUnknown:
                // 未知
//                self.unknownNetwork()
                break
            @unknown default:
                break
            }
        }
    }

    static func networkSettingAlert() {
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: "提示", message: "您尚未授权“app”访问网络的权限，请前往设置开启网络授权", preferredStyle: .alert)
            
            alertController.addAction(UIAlertAction(title: "取消", style: .destructive, handler: { _ in }))
            
            alertController.addAction(UIAlertAction(title: "去设置", style: .default, handler: { _ in
                if let settingsURL = URL(string: UIApplication.openSettingsURLString) {
                    UIApplication.shared.open(settingsURL, options: [:], completionHandler: nil)
                }
            }))
            
            UIApplication.shared.windows.first?.rootViewController?.present(alertController, animated: true, completion: nil)
        }
    }

    static func unknownNetwork() {
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: "提示", message: "未知网络", preferredStyle: .alert)
            
            alertController.addAction(UIAlertAction(title: "确定", style: .default, handler: { _ in }))
            
            UIApplication.shared.windows.first?.rootViewController?.present(alertController, animated: true, completion: nil)
        }
    }

}
