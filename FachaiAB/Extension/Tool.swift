//
//  Tool.swift
//  FachaiAB
//
//  Created by 张海彬 on 2023/11/20.
//

import Foundation
import UIKit

/// 获取屏幕宽度
var screenWidth: CGFloat {
    return UIScreen.main.bounds.width
}

/// 获取屏幕高度
var screenHeight: CGFloat {
    return UIScreen.main.bounds.height
}
/// 获取状态栏的高度
var statusBarHeight: CGFloat {
    if #available(iOS 13.0, *) {
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            return windowScene.statusBarManager?.statusBarFrame.height ?? 0
        } else {
            return 0
        }
    } else {
        return UIApplication.shared.statusBarFrame.height
    }
}

/// 获取导航栏的高度
var navigationBarHeight: CGFloat {
    return 44
}

/// 获取导航栏总高度
var navigationBarTotalHeight: CGFloat {
    return 44 + statusBarHeight
}
/// 底部安全边距
var bottomSafeAreaHeight: CGFloat {
    if #available(iOS 13.0, *) {
        if let statusBarManager = UIApplication.shared.windows.first?.windowScene?.statusBarManager {
            let statusBarFrame = statusBarManager.statusBarFrame
            let statusBarHeight = statusBarFrame.height
            let safeAreaBottom = statusBarHeight > 20 ? 34 : 0
            return CGFloat(safeAreaBottom)
        }
    } else {
        // Fallback on earlier versions
    }
    return 0
}

/// 获取keyWindow
var keyWindow: UIWindow? {
    if #available(iOS 13.0, *) {
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        let keyWindow = windowScene?.windows.first(where: { $0.isKeyWindow })
        return keyWindow
    } else {
        return UIApplication.shared.keyWindow
    }
   
}

/// 获取最顶层视图
/// - Returns: VC
func topViewController() -> UIViewController? {
    guard var topViewController = keyWindow?.rootViewController else {
        return nil
    }
    
    while let presentedViewController = topViewController.presentedViewController {
        topViewController = presentedViewController
    }
    
    if let tabBarController = topViewController as? UITabBarController {
        return tabBarController.selectedViewController
    }
    
    if let navigationController = topViewController as? UINavigationController {
        return navigationController.topViewController
    }
    
    return topViewController
}
