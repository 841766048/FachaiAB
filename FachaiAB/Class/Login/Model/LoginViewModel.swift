//
//  LoginViewModel.swift
//  FachaiAB
//
//  Created by   on 2023/11/22.
//

import Foundation
import Alamofire
import HandyJSON
struct LoginModel: HandyJSON {
    /// 登录后请求公参
    var key: String = ""
    /// 联系客服
    var kefu: String = ""
    /// 默认显示哪个tab页(重要)
    var tab: Int = 0
}



struct LoginViewModel {
    static func oneClickLogin(_ token: String, completionHandler: @escaping (LoginModel) -> Void) {
        Network.instance.Post(path: "sign/?a=index", params: ["result": "{\"token\":\"\(token)\"}"])
            .responseModel(LoginModel.self) { result in
                if result.error != nil {
                    toast(result.error!, state: .error)
                } else {
                    if let model = result.data {
                        completionHandler(model)
                    }
                }
            }
    }
    
    static func sendVerificationCode(_ mobile: String) {
        Network.instance.Post(path: "sign/?a=index", params: ["mobile": mobile])
            .responseModel(LoginModel.self) { _ in }
    }
    
    static func codeLogin(_ mobile: String, code: String, completionHandler: @escaping (LoginModel) -> Void) {
        Network.instance.Post(path: "sign/?a=index", params: ["mobile": mobile, "code": code])
            .responseModel(LoginModel.self) { result in
                if result.error != nil {
                    toast(result.error!, state: .error)
                } else {
                    if let model = result.data {
                        completionHandler(model)
                    }
                }
            }
    }
    /// 退出登录
    static func logOutLogin() {
        Network.instance.Post(path: "sign/?a=index", params: ["key": LocalStorage.getUserKey()])
            .responseModel(Bool.self) { result in
                if result.error != nil {
                    toast(result.error!, state: .error)
                } else {
                    LocalStorage.clearUserData()
                    TabBarController.instance.tab = BaseTabBarController()
                    let notification = Notification(name: .switchRootViewController)
                    NotificationCenter.default.post(notification)
                }
            }
    }
    
    static func logoff() {
        Network.instance.Post(path: "sign/?a=index", params: ["key": LocalStorage.getUserKey(), "cancel_member":"1"])
            .responseModel(Bool.self) { result in
                if result.error != nil {
                    toast(result.error!, state: .error)
                } else {
                    LocalStorage.clearUserData()
                    TabBarController.instance.tab = BaseTabBarController()
                    let notification = Notification(name: .switchRootViewController)
                    NotificationCenter.default.post(notification)
                    
                }
            }
    }
}

