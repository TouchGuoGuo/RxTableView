//
//  RxSectionModel.swift
//  RxSwiftDemo
//
//  Created by 臧志明 on 2022/10/31.
//

import Foundation
import RxDataSources

/// 注册cell的方式
enum RxSectionCellRegisterStyle {
    /// 通过nib注册
    case nib
    /// 通过class注册
    case `class`
}

/// 通过Rx实现tableView或者collectionview的基础协议
protocol RxSectionType {
    /// cell类名字符串
    var cellName:String { get set }
    /// 注册cell的方式
    var registerStyle:RxSectionCellRegisterStyle { get set }
}

/// tableView或者collectionview的数据模型
struct RxSectionModel {
    /// 遵循RxSectionType协议的数据模型
    var items:[Item] = []
}

extension RxSectionModel : SectionModelType {
    init(original: RxSectionModel, items: [RxSectionType]) {
        self = original
        self.items = items
    }
    typealias Item = RxSectionType
}

/// cell中传递点击事件模型
struct RxGestureModel {
    /// 点击视图的唯一标识
    var code:String = ""
    /// 点击cell中携带的model
    var model:RxSectionType?
    /// 点击cell中置顶的view
    var view:UIView?
}

/// 空数据模型
struct RxEmptyModel {
    /// 标题
    var title:NSAttributedString?
    /// 描述
    var description:NSAttributedString?
    /// 图片
    var image:UIImage?
    /// 空数据图片对于屏幕宽度的占比
    var ratio:CGFloat = 1
}

