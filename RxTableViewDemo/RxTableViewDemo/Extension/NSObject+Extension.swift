//
//  NSObject+Extension.swift
//  RxSwiftDemo
//
//  Created by 臧志明 on 2022/11/3.
//

import Foundation


extension NSObject {
    public var className: String {
        return type(of: self).className
    }

    public static var className: String {
        return String(describing: self)
    }
}
