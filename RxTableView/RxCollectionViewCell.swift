//
//  RxCollectionViewCell.swift
//  RxSwiftDemo
//
//  Created by 臧志明 on 2022/10/31.
//

import UIKit
import RxSwift
class RxCollectionViewCell: UICollectionViewCell {
    
    var disposebag = DisposeBag()

    override func prepareForReuse() {
        super.prepareForReuse()
        disposebag = DisposeBag()
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        setUI()
        setRx()
    }
    
    func setUI() {}
    
    func setRx() {}
    
    func setupCellModel(model: Any) {}
    
    func setupCellIndexModel(model: Any, indexPath: IndexPath) {}
    
    func tapGestureViewsForCell() -> [RxGestureModel] {
        return []
    }

}
