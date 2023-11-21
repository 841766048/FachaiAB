//
//  Network.swift
//  FachaiAB
//
//  Created by 张海彬 on 2023/11/21.
//

import Foundation
import HandyJSON
import Alamofire

let baseURL:String = ""


class Network {
    static let instance = Network()
    var commonParameters: [String: String] {
        let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? ""
        let device = UIDevice.current.model //设备型号
        return [
            "vjrzgaf": appVersion,
            "hlgjfb": "苹果iPhone手机客户端",
            "djvghj": device,
            "gdno": LocalStorage.getIdfa(),
            "djvghj_bakjf": LocalStorage.getDeviceToken(),
            "bdgd":"",
            "lfi":LocalStorage.getlfi(),
            "lob":LocalStorage.getlob(),
            "appname":"bafacegs"
        ]
    }
    public func Get(path: String, params: [String:String]) -> DataRequest {
        return AF
            .request(baseURL + path,
                     method: .get,
                     parameters: params,
                     encoder: URLEncodedFormParameterEncoder(destination: .queryString),
                     headers: [:],
                     requestModifier: {$0.timeoutInterval = 15})
            .validate()
    }
}
