//
//  NSLayoutConstraint+Extension.swift
//  RxSwiftDemo
//
//  Created by 臧志明 on 2022/11/3.
//

import Foundation
import UIKit


let autoScale = UIScreen.main.bounds.width / 375

extension NSLayoutConstraint {
    
    @IBInspectable
    var autoScreen : Bool {
        get {
            return true
        }
        set {
            if newValue {
                self.constant = self.constant * autoScale
            }
        }
    }
    
    
}

