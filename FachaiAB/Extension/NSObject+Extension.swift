//
//  NSObject+Extension.swift
//  FachaiAB
//
//  Created by   on 2023/11/20.
//

import Foundation
import UIKit

extension NSObject {
    func topViewController(_  base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
            if let  nav =  base as? UINavigationController {
                return topViewController(  nav.visibleViewController)
            }
            if let  tab =  base as? UITabBarController {
                if let  selected =  tab.selectedViewController {
                    return  topViewController( selected)
                }
            }
            if let  presented =  base?.presentedViewController {
                return  topViewController( presented)
            }
            return  base
        }
    
    static func topViewController(_  base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let  nav =  base as? UINavigationController {
            return topViewController(  nav.visibleViewController)
        }
        if let  tab =  base as? UITabBarController {
            if let  selected =  tab.selectedViewController {
                return  topViewController( selected)
            }
        }
        if let  presented =  base?.presentedViewController {
            return  topViewController( presented)
        }
        return  base
    }
}
