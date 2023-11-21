//
//  UIButton+Extension.swift
//  FachaiAB
//
//  Created by 张海彬 on 2023/11/21.
//

import Foundation
import UIKit

enum ButtonImagePosition: Int {
    /// 左图右字
    case left
    /// 右图左字
    case right
    /// 上图下字
    case top
    /// 下图上字
    case bottom
}

extension UIButton {
    func adjustImagePosition(position: ButtonImagePosition, space: CGFloat) {
        let imageWidth = self.imageView?.intrinsicContentSize.width ?? 0;
        let imageHeight = self.imageView?.intrinsicContentSize.height ?? 0;
        let labelWidth = self.titleLabel?.intrinsicContentSize.width ?? 0;
        let labelHeight = self.titleLabel?.intrinsicContentSize.height ?? 0;
        switch position {
        case ButtonImagePosition.left:
            self.imageEdgeInsets = UIEdgeInsets(top: 0, left: -space / 2, bottom: 0, right: space / 2)
            self.titleEdgeInsets = UIEdgeInsets(top: 0, left: space / 2, bottom: 0, right: -space / 2)
        case ButtonImagePosition.right:
            self.imageEdgeInsets = UIEdgeInsets(top: 0, left: labelWidth + space / 2, bottom: 0, right: -labelWidth - space/2)
            self.titleEdgeInsets = UIEdgeInsets(top: 0, left: -imageWidth - space / 2, bottom: 0, right: imageWidth + space / 2)
        case ButtonImagePosition.top:
            self.imageEdgeInsets = UIEdgeInsets(top: -labelHeight - space / 2, left: 0, bottom: 0, right: -labelWidth)
            self.titleEdgeInsets = UIEdgeInsets(top: 0, left: -imageWidth, bottom: -imageHeight - space / 2, right: 0)
        case ButtonImagePosition.bottom:
            self.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: -labelHeight - space / 2, right: -labelWidth)
            self.titleEdgeInsets = UIEdgeInsets(top: -imageHeight - space / 2, left: -imageWidth, bottom: 0, right: 0)
        }
    }
}
