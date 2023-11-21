//
//  BaseNavigationController.swift
//  FachaiAB
//
//  Created by 张海彬 on 2023/11/20.
//

import UIKit

class BaseNavigationController: UINavigationController {
    lazy var back_btn: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "back"), for: .normal)
        button.frame.size = CGSize(width: 22, height: 22)
        button.contentHorizontalAlignment = .left
        button.contentEdgeInsets = UIEdgeInsets(top: 0, left: -5, bottom: 0, right: 0)
        button.addTarget(self, action: #selector(backButtonClick), for: .touchUpInside)
        return  button
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTransparentNavigationBar()
        // Do any additional setup after loading the view.
    }
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if viewControllers.count > 0 {
            viewController.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: self.back_btn)
            // 隐藏 tabbar
            viewController.hidesBottomBarWhenPushed = true
        }
        super.pushViewController(viewController, animated: animated)
    }
    func configureTransparentNavigationBar() {
        if #available(iOS 15.0, *) {
            let var_appearance = UINavigationBarAppearance()
            var_appearance.configureWithDefaultBackground()
            var_appearance.shadowColor = nil
            var_appearance.backgroundEffect = nil
            var_appearance.backgroundColor = UIColor.clear
            var_appearance.titleTextAttributes = [
                .font: UIFont.systemFont(ofSize: 18, weight: .medium),
                .foregroundColor: UIColor.white
            ]
            self.navigationBar.backgroundColor = UIColor.clear
            self.navigationBar.barTintColor = UIColor.clear
            self.navigationBar.shadowImage = UIImage()
            self.navigationBar.standardAppearance = var_appearance
            self.navigationBar.scrollEdgeAppearance = var_appearance
        } else {
            self.navigationBar.backgroundColor = UIColor.clear
            self.navigationBar.barTintColor = UIColor.clear
            self.navigationBar.shadowImage = UIImage()
            self.navigationBar.titleTextAttributes = [
                .font: UIFont.systemFont(ofSize: 18, weight: .medium),
                .foregroundColor: UIColor.white
            ]
        }
        self.navigationBar.isTranslucent = true
        self.setNavigationBarHidden(false, animated: false)
    }
    @objc func backButtonClick() {
        popViewController(animated: true)
    }
}
