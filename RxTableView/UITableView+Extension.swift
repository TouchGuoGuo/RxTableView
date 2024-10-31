//
//  UITableView+Extension.swift
//  RxTableViewDemo
//
//  Created by yh jl on 2024/10/29.
//

import Foundation
import UIKit

private var registeredCellsKey: Void?

extension UITableView {

    // 动态添加 registeredCells 属性
    var registeredCells: Set<String> {
        get {
            // 获取关联对象
            return objc_getAssociatedObject(self, &registeredCellsKey) as? Set<String> ?? []
        }
        set {
            // 设置关联对象
            objc_setAssociatedObject(self, &registeredCellsKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }

    func register(cell:UIView.Type) {
        let identifier = String(describing: cell)
        if !registeredCells.contains(identifier) {
            if Bundle.main.path(forResource: identifier, ofType: "nib") != nil {
                let nib = UINib(nibName: identifier, bundle: nil)
                self.register(nib, forCellReuseIdentifier: identifier)
            } else {
                self.register(cell, forCellReuseIdentifier: identifier)
            }
            registeredCells.insert(identifier)
        }
    }
}
