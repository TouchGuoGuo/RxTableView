//
//  RxCollectionViewCell.swift
//  RxSwiftDemo
//
//  Created by guoguo on 2022/10/31.
//

import UIKit
import RxSwift
open class RxCollectionViewCell: UICollectionViewCell {
    
    open var disposebag = DisposeBag()

    open override func prepareForReuse() {
        super.prepareForReuse()
        disposebag = DisposeBag()
    }

    open override func awakeFromNib() {
        super.awakeFromNib()
        setUI()
        setRx()
    }
    
    open func setUI() {}
    
    open func setRx() {}
    
    open func setupCellModel(model: Any) {}
    
    open func setupCellIndexModel(model: Any, indexPath: IndexPath) {}
    
//    open func tapGestureViewsForCell() -> [RxGestureModel] {
//        return []
//    }

}
