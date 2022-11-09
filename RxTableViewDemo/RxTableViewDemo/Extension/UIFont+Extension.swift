//
//  UIFont+Extension.swift
//  RxSwiftDemo
//
//  Created by 臧志明 on 2022/11/3.
//

import Foundation
import UIKit

enum PingFangFontType : String {
    case regular = "PingFang-SC-Regular"
    case medium = "PingFang-SC-Medium"
    case bold = "PingFangSC-Semibold"
}

extension UIFont {
    
    class func PingFangFont(type:PingFangFontType,size:CGFloat) -> UIFont {
        return UIFont(name: type.rawValue, size: size)!
    }
}
