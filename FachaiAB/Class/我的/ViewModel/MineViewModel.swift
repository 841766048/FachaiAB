//
//  MineViewModel.swift
//  FachaiAB
//
//  Created by 张海彬 on 2023/11/23.
//

import Foundation
import HandyJSON
struct BoxModel: HandyJSON {
    var url: String = ""
    var width: CGFloat = 0
    var height: CGFloat = 0
}

struct MineModel: HandyJSON {
    var prelogin: String = ""
    var full: String = ""
    var tab: String = ""
    var rank: Int = 0
    var box: [BoxModel] = []
}

struct CancellationModel: HandyJSON {
    var tip: String = ""
}

struct MineViewModel {
    static func getSetPermiss(_ completionHandler: @escaping (MineModel) -> Void) {
        Network.instance.Get(path: "sign/?a=my", params: ["key": LocalStorage.getUserKey()])
            .responseModel(MineModel.self) { result in
                if let data = result.data {
                    completionHandler(data)
                } else {
                    completionHandler(MineModel())
                }
            }
    }
    /// 获取注销文案
    static func getCancellationCopy(_ completionHandler: @escaping (CancellationModel) -> Void) {
        Network.instance.Get(path: "sign/?a=index", params: ["key": LocalStorage.getUserKey()])
            .responseModel(CancellationModel.self) { result in
                if let data = result.data {
                    completionHandler(data)
                } else {
                    completionHandler(CancellationModel())
                }
            }
    }
}
