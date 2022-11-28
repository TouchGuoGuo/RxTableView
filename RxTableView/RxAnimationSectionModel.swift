//
//  RxAnimationSectionModel.swift
//  RxTableViewDemo
//
//  Created by guoguo on 2022/11/25.
//

import Foundation
import RxDataSources


public struct RxAnimationSectionModel {
    
    var models:[RxAnimationRowModel] = []
    
}

extension RxAnimationSectionModel : AnimatableSectionModelType {
    
    public typealias Item = RxAnimationRowModel
    
    public typealias Identity = String
    
    public var identity: String {
        return ""
    }
    public var items: [RxAnimationRowModel] {
        return models
    }
    
    public init(original: RxAnimationSectionModel, items: [RxAnimationRowModel]) {
        self = original
        self.models = items
    }
}

open class RxAnimationRowModel : NSObject , RxSectionType {
    
    open var cellName: String {
        set {}
        get { "" }
    }
    
    open var registerStyle: RxSectionCellRegisterStyle {
        set {}
        get { .nib }
    }
    
    open var index:String
    
    init(index: String) {
        self.index = index
    }
}


extension RxAnimationRowModel : IdentifiableType  {
    
    public typealias Identity = String
    public var identity: String {
        return index
    }
}


