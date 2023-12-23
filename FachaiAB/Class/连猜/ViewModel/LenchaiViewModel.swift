//
//  LenchaiViewModel.swift
//  FachaiAB
//
//  Created by   on 2023/11/27.
//

import UIKit
import Alamofire
import HandyJSON


class LenchaiViewModel: NSObject {
    static func getLianCaiData(completionHandler: @escaping (FachaiModel?) -> Void) {
        let url = "https://bai.tongchengjianzhi.cn/ba/liangs.json"
        AF
           .request(url,
                    method: .get,
                    parameters: [:],
                    headers: [:],
                    requestModifier: {$0.timeoutInterval = 15})
           .validate()
           .responseArrayModel(FachaiModel.self) { result in
               let index = Int.random(in: 0..<result.count)
               let model = result[index];
               completionHandler(model)
           }
    }
    
}
