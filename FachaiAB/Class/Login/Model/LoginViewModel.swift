//
//  LoginViewModel.swift
//  FachaiAB
//
//  Created by 张海彬 on 2023/11/22.
//

import Foundation
import Alamofire
import HandyJSON
struct LoginModel: HandyJSON {
    /// 成功描述
    var msg: String = ""
    /// 登录后请求公参
    var key: String = ""
    /// 联系客服
    var kefu: String = ""
    /// 默认显示哪个tab页(重要)
    var tab: Int = 0
}

struct LoginViewModel {
    static func oneClickLogin(_ token: String, completionHandler: @escaping (LoginModel) -> Void) {
        Network.instance.Post(path: "sign/?a=index", params: ["token": token])
            .responseModel(LoginModel.self) { result in
                if result.error != nil {
                    toast(result.error!, state: .error)
                } else {
                    if let model = result.data  {
                        completionHandler(model)
                    }
                }
            }
    }
}

