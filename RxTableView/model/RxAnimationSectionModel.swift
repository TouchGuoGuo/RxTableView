//
//  RxAnimationSectionModel.swift
//  RxTableViewDemo
//
//  Created by yh jl on 2024/10/29.
//

import Foundation
import RxDataSources


public protocol RxAnimationRowType : IdentifiableType,Equatable {
    var cell:UIView.Type { get set }
}

extension RxAnimationRowType where Self: IdentifiableType, Self.Identity == UUID {
    public var identity: UUID { UUID() }
    static public func == (lhs: Self, rhs: Self) -> Bool {
        guard lhs.identity == rhs.identity else { return false }
        return Mirror(reflecting: lhs).children.elementsEqual(
            Mirror(reflecting: rhs).children,
            by: { ($0.label, "\($0.value)") == ($1.label, "\($1.value)") }
        )
    }
}

public struct AnyRxAnimationRowType: RxAnimationRowType {
    
    var _base: any RxAnimationRowType
    private let cachedIdentity: UUID

    public var cell: UIView.Type {
        set {}
        get {
            return _base.cell
        }
    }
    public var identity: UUID {
        return cachedIdentity
    }

    init(_ base: any RxAnimationRowType) {
        self._base = base
        self.cachedIdentity = base.identity as! UUID
    }
        
}


public struct RxAnimationSectionModel {
    public var items: [AnyRxAnimationRowType]
    public var header:String?
    public var footer:String?
    public var id:UUID = UUID()
}

extension RxAnimationSectionModel: AnimatableSectionModelType {
    
    public typealias Identity = UUID
    
    public typealias Item = AnyRxAnimationRowType

    public var identity: UUID {
        return id
    }

    public init(original: RxAnimationSectionModel, items: [AnyRxAnimationRowType]) {
        self = original
        self.items = items
    }
}
