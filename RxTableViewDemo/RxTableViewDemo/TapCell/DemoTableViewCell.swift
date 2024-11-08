//
//  DemoTableViewCell.swift
//  RxTableViewDemo
//
//  Created by guoguo on 2022/11/8.
//

import UIKit

class DemoTableViewCell: RxTableViewCell {

    @IBOutlet weak var yellowview: UIView!
    
    @IBOutlet weak var pinkview: UIView!
    
    @IBOutlet weak var title: UILabel!
        
    override var gestureModels: [RxCellGestureModel] {
        return [
            RxCellGestureModel(identifier: "yellow",view: yellowview,indexPath: self.indexPath),
            RxCellGestureModel(identifier: "pink", view: pinkview, indexPath: self.indexPath)
        ]
    }
    
    override func setupCellIndexModel(model: Any, indexPath: IndexPath) {
        super.setupCellIndexModel(model: model, indexPath: indexPath)
        if let model = model as? RxXibModel {
            title.text = model.title
        }
        if let base = model as? AnyRxAnimationRowType,let model = base._base as? RxXibModel {
            title.text = model.title
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
