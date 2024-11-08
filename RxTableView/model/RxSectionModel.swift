//
//  RxSectionModel.swift
//  RxSwiftDemo
//
//  Created by guoguo on 2022/10/31.
//

import Foundation
import RxDataSources


/// 通过Rx实现tableView或者collectionview的基础协议
public protocol RxRowType {
    /// cell
    var cell:UIView.Type { get set }
}

/// UITableView/UICollectionview的数据模型
public struct RxSectionModel {
    /// 放入遵循RxRowType的模型数组
    public var items:[RxRowType]
    public var header:String?
    public var footer:String?
}

extension RxSectionModel : SectionModelType {
    public typealias Item = RxRowType
    public init(original: RxSectionModel, items: [RxRowType]) {
        self = original
        self.items = items
    }
}





///// cell中传递点击事件模型
//public struct RxGestureModel {
//    /// 点击视图的唯一标识
//    public var code:String = ""
//    /// 点击cell中携带的model
//    public var model:RxSectionType?
//    /// 点击cell中置顶的view
//    public var view:UIView?
//    
//    public init(code: String, model: RxSectionType? = nil, view: UIView? = nil) {
//        self.code = code
//        self.model = model
//        self.view = view
//    }
//}
//
///// 空数据模型
//public struct RxEmptyModel {
//    /// 标题
//    public var title:NSAttributedString?
//    /// 描述
//    public var description:NSAttributedString?
//    /// 图片
//    public var image:UIImage?
//    /// 空数据图片对于屏幕宽度的占比
//    public var ratio:CGFloat = 1
//    
//    public init(title: NSAttributedString? = nil, description: NSAttributedString? = nil, image: UIImage? = nil, ratio: CGFloat) {
//        self.title = title
//        self.description = description
//        self.image = image
//        self.ratio = ratio
//    }
//}
//
///// 翻页模型
//public struct RxPageModel<T:RxSectionType> {
//    var model:T
//    var page:Int
//}
//
