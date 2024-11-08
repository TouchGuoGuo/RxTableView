//
//  RxXibTableViewCell.swift
//  RxTableViewDemo
//
//  Created by yh jl on 2024/11/1.
//

import UIKit

class RxXibTableViewCell: RxTableViewCell {

    @IBOutlet weak var title: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setupCellIndexModel(model: Any, indexPath: IndexPath) {
        super.setupCellIndexModel(model: model, indexPath: indexPath)
        if let model = model as? RxXibModel {
            title.text = model.title + "--Xib"
        }
        if let base = model as? AnyRxAnimationRowType,let model = base._base as? RxXibModel {
            title.text = model.title + "--Xib"
        }

    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
