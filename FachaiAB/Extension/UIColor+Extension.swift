//
//  UIColor+Extension.swift
//  FachaiAB
//
//  Created by 张海彬 on 2023/11/20.
//

import Foundation
import UIKit

extension UIColor {
    // 便利构造函数，使用十六进制颜色值创建 UIColor 对象
    convenience init(hex: String, alpha: CGFloat = 1.0) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")
        
        var rgb: UInt64 = 0
        
        Scanner(string: hexSanitized).scanHexInt64(&rgb)
        
        let red = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(rgb & 0x0000FF) / 255.0
        
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
    // 从颜色创建UIImage对象
    func toImage(size: CGSize = CGSize(width: screenWidth, height: 59)) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        guard let context = UIGraphicsGetCurrentContext() else { return UIImage() }
        
        context.setFillColor(self.cgColor)
        context.fill(CGRect(origin: .zero, size: size))
        
        guard let image = UIGraphicsGetImageFromCurrentImageContext() else { return UIImage() }
        UIGraphicsEndImageContext()
        
        return image
    }
    static func random() -> UIColor {
        let red = CGFloat.random(in: 0...1)
        let green = CGFloat.random(in: 0...1)
        let blue = CGFloat.random(in: 0...1)
        
        return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
    }
}
