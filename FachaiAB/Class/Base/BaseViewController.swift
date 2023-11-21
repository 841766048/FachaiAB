//
//  BaseViewController.swift
//  FachaiAB
//
//  Created by 张海彬 on 2023/11/20.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 13.0, *) {
            let tabbarAppearance = UITabBarAppearance()
            tabbarAppearance.configureWithOpaqueBackground()
            tabbarAppearance.backgroundColor = .white
            UITabBar.appearance().standardAppearance = tabbarAppearance
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
