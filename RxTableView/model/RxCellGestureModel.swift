//
//  RxCellGestureModel.swift
//  RxTableViewDemo
//
//  Created by yh jl on 2024/11/1.
//

import Foundation
import UIKit


protocol RxCellGestureType {
    var gestureModels:[RxCellGestureModel] { get }
}

public struct RxCellGestureModel {
    var identifier:String
    var view:UIView
    var indexPath:IndexPath?
}
