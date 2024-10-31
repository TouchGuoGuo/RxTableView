//
//  RxTableViewCell.swift
//  RxSwiftDemo
//
//  Created by guoguo on 2022/10/31.
//

import UIKit
import RxSwift

open class RxTableViewCell: UITableViewCell {

    private var disposebag = DisposeBag()
        
    public private(set) var indexPath:IndexPath?
    
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
    
    open func setupCellIndexModel(model: Any, indexPath: IndexPath) {
        self.indexPath = indexPath
    }
    
//    open func tapGestureViewsForCell() -> [RxGestureModel] {
//        return []
//    }


    open override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
