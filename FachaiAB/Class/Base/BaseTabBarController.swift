//
//  BaseTabBarController.swift
//  FachaiAB
//
//  Created by 张海彬 on 2023/11/21.
//

import UIKit
class TabBarController {
    static let instance = TabBarController()
    var tab: BaseTabBarController = BaseTabBarController()
}

class BaseTabBarController: UITabBarController, UITabBarControllerDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        initWithUI()
        setTabbar()
    }
    func initWithUI() {
        let customTabBar = CustomTabBar()
        setValue(customTabBar, forKey: "tabBar")
        
        self.tabBar.tintColor = UIColor(hex: "#4272D7")
        self.tabBar.unselectedItemTintColor = UIColor(hex: "#999999")
        
        
        
        let fachai_nav = configurationNav("脸猜", vc: FachaiVC())
        fachai_nav.tag = 111
        let lenchai_nav = configurationNav("连猜", vc: LenchaiVC())
        fachai_nav.tag = 222
        let leader_nav = configurationNav("榜单", vc: LeaderboardManagerVC())
        leader_nav.tag = 333
        let mine_nav = configurationNav("我的", vc: MineVC())
        mine_nav.tag = 444
        
        viewControllers = [fachai_nav, lenchai_nav, leader_nav, mine_nav]
        tabBar.backgroundColor = UIColor(hex: "#191919")
        tabBar.barTintColor = UIColor(hex: "#191919")
        
    }
    
    func configurationNav(_ title: String, vc: UIViewController) -> BaseNavigationController {
        let nav = BaseNavigationController(rootViewController: vc)
        nav.tabBarItem.title = title
        return nav
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let newFrame = CGRect(x: tabBar.frame.origin.x,
                              y: tabBar.frame.origin.y - 10,
                              width: tabBar.frame.size.width,
                              height: tabBar.frame.size.height + 10)
        tabBar.frame = newFrame
    }
    func setTabbar() {
        let customTabBar = UITabBar.appearance()
        if #available(iOS 13.0, *) {
            let tabBarAppearance = UITabBarAppearance()
            //设置tabar背景色
            tabBarAppearance.backgroundColor = .black
            customTabBar.standardAppearance = tabBarAppearance
            if #available(iOS 15.0, *) {
                customTabBar.scrollEdgeAppearance = tabBarAppearance
            } else {
                
            }
        } else {
            customTabBar.barTintColor = .black
        }
    }
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        let nav = viewController as! BaseNavigationController
        if nav.tag == 333 || nav.tag == 444 {
            if !LocalStorage.getIsLogin() {
                topViewController()?.navigationController?.pushViewController(LoginVC(), animated: true)
                return false
            }
        }
        return true
    }
}

class CustomTabBar: UITabBar {
    override func layoutSubviews() {
        self.backgroundColor = .black
        for vi in self.subviews {
            print("vi = \(vi)")
            if String(describing: type(of: vi)) == "_UIBarBackground" {
                vi.isHidden = true
            }
        }
        if #available(iOS 13.0, *) {
            standardAppearance.backgroundEffect = nil
        } else {
            // Fallback on earlier versions
        }
        super.layoutSubviews()
        for subview in subviews {
            if let label = subview as? UILabel {
                // 自定义标签的位置
                label.frame.origin.y = 24
            }
        }
    }
    
    
}
