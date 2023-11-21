//
//  BaseTabBarController.swift
//  FachaiAB
//
//  Created by 张海彬 on 2023/11/21.
//

import UIKit

class BaseTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initWithUI()
        // Do any additional setup after loading the view.
    }
    func initWithUI() {
        let customTabBar = CustomTabBar()
        setValue(customTabBar, forKey: "tabBar")

        self.tabBar.tintColor = UIColor(hex: "#4272D7")
        self.tabBar.unselectedItemTintColor = UIColor(hex: "#999999")
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)], for: .normal)
        
        
        let fachai_nav = configurationNav("脸猜", vc: FachaiVC())
        let lenchai_nav = configurationNav("连猜", vc: LenchaiVC())
        let leader_nav = configurationNav("榜单", vc: LeaderboardManagerVC())
        let mine_nav = configurationNav("我的", vc: MineVC())
        
        viewControllers = [fachai_nav, lenchai_nav, leader_nav, mine_nav]
        tabBar.backgroundColor = UIColor(hex: "#191919")
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
    
}

class CustomTabBar: UITabBar {
    override func layoutSubviews() {
        super.layoutSubviews()
        for subview in subviews {
            if let label = subview as? UILabel {
                // 自定义标签的位置
                label.frame.origin.y = 24
            }
        }
    }
}
