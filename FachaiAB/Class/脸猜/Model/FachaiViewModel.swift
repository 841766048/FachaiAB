//
//  FachaiViewModel.swift
//  FachaiAB
//
//  Created by   on 2023/11/26.
//

import UIKit
import Alamofire
import HandyJSON

struct FachaiModel: HandyJSON {
    var id: String = ""
    var user_name: String = ""
    var user_sex: String = ""
    var user_age: String = ""
    var user_city: String = ""
    var user_label: [String] = []
    var user_declaration: String = ""
    var user_head: String = ""
}

class FachaiViewModel: NSObject {
    static func getFachaiData(completionHandler: @escaping ([FachaiModel?]) -> Void) {
        let url = "https://bai.tongchengjianzhi.cn/ba/facegs.json"
        AF
           .request(url,
                    method: .get,
                    parameters: [:],
                    headers: [:],
                    requestModifier: {$0.timeoutInterval = 15})
           .validate()
           .responseArrayModel(FachaiModel.self) { result in
               completionHandler(result)
           }
    }
    
    static func submitReport(completionHandler: @escaping () -> Void) {
        Network.instance.Post(path: "sign/?a=api", params: ["key": LocalStorage.getUserKey(), "any_other_key":"juBaogaiyonghu"])
            .responseModel(Bool.self) { result in
                completionHandler()
            }
    }
    
    static func submitBlack(completionHandler: @escaping () -> Void) {
        Network.instance.Post(path: "sign/?a=api", params: ["key": LocalStorage.getUserKey(), "any_other_key":"laruheimingdan"])
            .responseModel(Bool.self) { result in
                completionHandler()
            }
    }
}
