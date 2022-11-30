//
//  RxSectionModel.swift
//  RxSwiftDemo
//
//  Created by guoguo on 2022/10/31.
//

import Foundation
import RxDataSources

/// 注册cell的方式
public enum RxSectionCellRegisterStyle {
    /// 通过nib注册
    case nib
    /// 通过class注册
    case `class`
}

/// 通过Rx实现tableView或者collectionview的基础协议
public protocol RxSectionType {
    /// cell类名字符串
    var cellName:String { get set }
    /// 注册cell的方式
    var registerStyle:RxSectionCellRegisterStyle { get set }
}

/// tableView或者collectionview的数据模型
public struct RxSectionModel {
    /// 遵循RxSectionType协议的数据模型
    public var items:[Item] = []
    
    public init(original:RxSectionModel? = nil,items:[RxSectionType]) {
        if let original = original {
            self = original
        }
        self.items = items
    }
}

extension RxSectionModel : SectionModelType {
    public init(original: RxSectionModel, items: [Item]) {
        self = original
        self.items = items
    }
    public typealias Item = RxSectionType
}

/// cell中传递点击事件模型
public struct RxGestureModel {
    /// 点击视图的唯一标识
    public var code:String = ""
    /// 点击cell中携带的model
    public var model:RxSectionType?
    /// 点击cell中置顶的view
    public var view:UIView?
    
    public init(code: String, model: RxSectionType? = nil, view: UIView? = nil) {
        self.code = code
        self.model = model
        self.view = view
    }
}

/// 空数据模型
public struct RxEmptyModel {
    /// 标题
    public var title:NSAttributedString?
    /// 描述
    public var description:NSAttributedString?
    /// 图片
    public var image:UIImage?
    /// 空数据图片对于屏幕宽度的占比
    public var ratio:CGFloat = 1
    
    public init(title: NSAttributedString? = nil, description: NSAttributedString? = nil, image: UIImage? = nil, ratio: CGFloat) {
        self.title = title
        self.description = description
        self.image = image
        self.ratio = ratio
    }
}

/// 翻页模型
public struct RxPageModel<T:RxSectionType> {
    var model:T
    var page:Int
}

