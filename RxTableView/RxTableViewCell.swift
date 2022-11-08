//
//  RxTableViewCell.swift
//  RxSwiftDemo
//
//  Created by 臧志明 on 2022/10/31.
//

import UIKit
import RxSwift

class RxTableViewCell: UITableViewCell {

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


    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
