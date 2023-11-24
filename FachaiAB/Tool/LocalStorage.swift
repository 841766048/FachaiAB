//
//  LocalStorage.swift
//  FachaiAB
//
//  Created by 张海彬 on 2023/11/20.
//

import Foundation

class LocalStorage {
    // UserDefaults 键(key)的定义
    enum StorageKey: String {
        /// 昵称
        case userName
        /// 用户年龄
        case userAge
        /// 是否同意隐私政策
        case isPrivacyPolicy
        
        
        /// 是否登录(退出登录需要清除)
        case isLogin
        /// idfa
        case idfa
        /// device_token
        case device_token
        /// 经度
        case lfi
        /// 纬度
        case lob
        /// 默认tab(退出登录需要清除)
        case defaultTab
        /// 客服(退出登录需要清除)
        case kefu
        /// 用户Key(退出登录需要清除)
        case userKey
        /// 弹框文案
        case full
    }
    
    // 存储用户名
    static func saveUserName(_ name: String) {
        UserDefaults.standard.set(name, forKey: StorageKey.userName.rawValue)
    }
    
    // 获取用户名
    static func getUserName() -> String? {
        return UserDefaults.standard.string(forKey: StorageKey.userName.rawValue)
    }
    
    // 存储用户年龄
    static func saveUserAge(_ age: Int) {
        UserDefaults.standard.set(age, forKey: StorageKey.userAge.rawValue)
    }
    
    // 获取用户年龄
    static func getUserAge() -> Int {
        return UserDefaults.standard.integer(forKey: StorageKey.userAge.rawValue)
    }
    
    
    // 存储隐私政策
    static func savePrivacyPolicy(_ isPrivacyPolicy: Bool) {
        UserDefaults.standard.set(isPrivacyPolicy, forKey: StorageKey.isPrivacyPolicy.rawValue)
    }
    /// 获取隐私政策的同意情况
    static func getPrivacyPolicy() -> Bool {
        return UserDefaults.standard.bool(forKey: StorageKey.isPrivacyPolicy.rawValue)
    }
    
    // 存储登录状态
    static func saveIsLogin(_ isLogin: Bool) {
        UserDefaults.standard.set(isLogin, forKey: StorageKey.isLogin.rawValue)
    }
    /// 获取登录状态
    static func getIsLogin() -> Bool {
        return UserDefaults.standard.bool(forKey: StorageKey.isLogin.rawValue)
    }
    
    // 存储idfa
    static func saveIdfa(_ idfa: String) {
        UserDefaults.standard.set(idfa, forKey: StorageKey.idfa.rawValue)
    }
    /// 获取idfa
    static func getIdfa() -> String {
        return UserDefaults.standard.string(forKey: StorageKey.idfa.rawValue) ?? ""
    }
    
    // 存储DeviceToken
    static func saveDeviceToken(_ device_token: String) {
        UserDefaults.standard.set(device_token, forKey: StorageKey.device_token.rawValue)
    }
    /// 获取DeviceToken
    static func getDeviceToken() -> String {
        return UserDefaults.standard.string(forKey: StorageKey.device_token.rawValue) ?? ""
    }

    // 存储经度(lng)
    static func savelfi(_ lfi: String) {
        UserDefaults.standard.set(lfi, forKey: StorageKey.lfi.rawValue)
    }
    /// 获取经度(lng)
    static func getlfi() -> String {
        return UserDefaults.standard.string(forKey: StorageKey.lfi.rawValue) ?? "0.0"
    }
    
    
    // 存储纬度(lat)
    static func savelob(_ lob: String) {
        UserDefaults.standard.set(lob, forKey: StorageKey.lob.rawValue)
    }
    /// 获取纬度(lat)
    static func getlob() -> String {
        return UserDefaults.standard.string(forKey: StorageKey.lob.rawValue) ?? "0.0"
    }
    
    // 存储默认Tab
    static func saveDefaultTab(_ tab: Int) {
        UserDefaults.standard.set(tab, forKey: StorageKey.defaultTab.rawValue)
    }
    /// 获取默认Tab
    static func getDefaultTab() -> Int {
        return UserDefaults.standard.integer(forKey: StorageKey.defaultTab.rawValue)
    }
    
    
    // 存储客服
    static func saveKefu(_ kefu: String) {
        UserDefaults.standard.set(kefu, forKey: StorageKey.kefu.rawValue)
    }
    /// 获取客服
    static func getKefu() -> String {
        return UserDefaults.standard.string(forKey: StorageKey.kefu.rawValue) ?? ""
    }
    
    // 存储用户Key
    static func saveUserKey(_ userKey: String) {
        UserDefaults.standard.set(userKey, forKey: StorageKey.userKey.rawValue)
    }
    /// 获取用户Key
    static func getUserKey() -> String {
        return UserDefaults.standard.string(forKey: StorageKey.userKey.rawValue) ?? ""
    }
    
    // 存储full文案
    static func saveFull(_ full: String) {
        UserDefaults.standard.set(full, forKey: StorageKey.full.rawValue)
    }
    /// 获取用户Key
    static func getFull() -> String {
        return UserDefaults.standard.string(forKey: StorageKey.full.rawValue) ?? ""
    }
    
    
    
    // 清除用户数据
    static func clearUserData() {
        UserDefaults.standard.removeObject(forKey: StorageKey.userName.rawValue)
        UserDefaults.standard.removeObject(forKey: StorageKey.userAge.rawValue)
        UserDefaults.standard.removeObject(forKey: StorageKey.isLogin.rawValue)
        UserDefaults.standard.removeObject(forKey: StorageKey.defaultTab.rawValue)
        UserDefaults.standard.removeObject(forKey: StorageKey.kefu.rawValue)
        UserDefaults.standard.removeObject(forKey: StorageKey.userKey.rawValue)
        // 添加其他需要清除的数据
    }
    
    
}

//// 使用示例
//LocalStorage.saveUserName("Alice")
//LocalStorage.saveUserAge(30)
//
//if let userName = LocalStorage.getUserName() {
//    print("Stored username: \(userName)")
//}

//let userAge = LocalStorage.getUserAge()
//print("Stored user age: \(userAge)")
//
//// 清除用户数据示例
//LocalStorage.clearUserData()
//
