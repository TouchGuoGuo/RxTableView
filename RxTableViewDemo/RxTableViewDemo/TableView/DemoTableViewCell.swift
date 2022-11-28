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
    
    var model:DemoTableViewModel?
    
    override func setupCellIndexModel(model: Any, indexPath: IndexPath) {
        if let model = model as? DemoTableViewModel {
            self.model = model
            title.text = model.title + "\(indexPath)"
        }
    }
    
    
    override func tapGestureViewsForCell() -> [RxGestureModel] {
        return [
            RxGestureModel(code: "title",model: nil,view: title),
            RxGestureModel(code: "yellowView",model: model,view: yellowview),
            RxGestureModel(code: "pinkview",model: model,view: pinkview),
        ]
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
