//
//  Network.swift
//  FachaiAB
//
//  Created by 张海彬 on 2023/11/21.
//

import Foundation
import HandyJSON
import Alamofire
import CommonCrypto



let baseURL:String = "https://bafacegs.tongchengjianzhi.cn/"


class Network {
    static let instance = Network()
    /// 公共参数
    var commonParameters: [String: String] {
        let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? ""
        let device = UIDevice.current.model //设备型号
        // 生成 MD5 签名
        let key = "bafacegs"
        let currentHour = getCurrentHour()
        let md5Signature = generateMD5Hash(key: key, hour: currentHour)
        return [
            "vjrzgaf": appVersion,
            "hlgjfb": "苹果iPhone手机客户端",
            "djvghj": device,
            "gdno": LocalStorage.getIdfa(),
            "djvghj_bakjf": LocalStorage.getDeviceToken(),
            "bdgd": TalkingDataSDK.getDeviceId(),
            "lfi":LocalStorage.getlfi(),
            "lob":LocalStorage.getlob(),
            "appname":"bafacegs",
            "signature": md5Signature
        ]
    }
    func Get(path: String, params: [String:String], encoder: ParameterEncoder = URLEncodedFormParameterEncoder(destination: .queryString)) -> DataRequest {
        let par = commonParameters.merging(params) { _, new in
            new
        }
        SVProgressHUD.show()
//        ProgressHUD.animate("", .circleDotSpinFade)
        return AF
            .request(baseURL + path,
                     method: .get,
                     parameters: par,
                     encoder: encoder,
                     headers: [:],
                     requestModifier: {$0.timeoutInterval = 15})
            .validate()
    }
    
    func Post(path: String, params: [String:String], encoder: ParameterEncoder = URLEncodedFormParameterEncoder(destination: .queryString)) -> DataRequest {
        let par = commonParameters.merging(params) { _, new in
            new
        }
        return AF.request(baseURL + path,
                          method: .post,
                          parameters: par,
                          encoder: encoder,
                          headers: [:],
                          requestModifier: {$0.timeoutInterval = 15}
        )
    }
    
    func generateMD5Hash(key: String, hour: Int) -> String {
        let dateString = "\(key)\(String(format: "%02d", hour))"
        if let data = dateString.data(using: .utf8) {
            var digest = [UInt8](repeating: 0, count: Int(CC_MD5_DIGEST_LENGTH))
            data.withUnsafeBytes {
                _ = CC_MD5($0.baseAddress, CC_LONG(data.count), &digest)
            }
            let md5String = digest.map { String(format: "%02hhx", $0) }.joined()
            return md5String
        }
        return ""
    }
    
    func getCurrentHour() -> Int {
        let currentDate = Date()
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: currentDate)
        return hour
    }
}

extension DataRequest {
    func responseModel<T: HandyJSON>(_ type: T.Type, completionHandler: @escaping (DataResult<T>) -> Void) {
        SVProgressHUD.dismiss()
        self.response { response in
            guard let data = response.data else {
                completionHandler(DataResult(data: nil, error: "Date 不存在"))
                return
            }
            guard let jsonString = String(data: data, encoding: .utf8) else {
                completionHandler(DataResult(data: nil, error: "json解析出错"))
                return
            }
            
            guard let object = JSONDeserializer<T>.deserializeFrom(json: jsonString) else {
                completionHandler(DataResult(data: nil, error: "Json字符串不能转换为object"))
                return
            }
            completionHandler(DataResult(data: object, error: nil))
        }
    }
}

struct DataResult<T: HandyJSON> {
    let data: T?
    let error: String?
}
