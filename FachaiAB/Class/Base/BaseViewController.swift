//
//  BaseViewController.swift
//  FachaiAB
//
//  Created by   on 2023/11/20.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 13.0, *) {
            let tabbarAppearance = UITabBarAppearance()
            tabbarAppearance.configureWithOpaqueBackground()
            tabbarAppearance.backgroundColor = .white
            // 设置普通状态下的字体大小
            tabbarAppearance.stackedLayoutAppearance.normal.titleTextAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16, weight: .semibold)]
            // 设置选中状态下的字体大小
            tabbarAppearance.stackedLayoutAppearance.selected.titleTextAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16, weight: .semibold)]

            UITabBar.appearance().standardAppearance = tabbarAppearance
            UITabBarItem.appearance().setBadgeTextAttributes([NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16, weight: .semibold)], for: .normal)
            UITabBarItem.appearance().setBadgeTextAttributes([NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16, weight: .semibold)], for: .selected)
            self.tabBarItem.standardAppearance = tabbarAppearance
            if #available(iOS 15.0, *) {
                self.tabBarItem.scrollEdgeAppearance = tabbarAppearance
            }
        }
        
        initWithUI()
    }
    
    func initWithUI() {
        self.view.backgroundColor = .black
    }
}
