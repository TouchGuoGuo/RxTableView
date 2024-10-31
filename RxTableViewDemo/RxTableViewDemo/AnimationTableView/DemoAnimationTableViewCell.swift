//
//  DemoAnimationTableViewCell.swift
//  withta
//
//  Created by guoguo on 2022/11/25.
//

import UIKit
import RxSwift

class DemoAnimationTableViewCell: RxTableViewCell {

    @IBOutlet weak var moreImage: UIImageView!
    
    @IBOutlet weak var contentHeight: NSLayoutConstraint!
    
    @IBOutlet weak var contentBackView: UIView!
        
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
    

//    override func setupCellModel(model: Any) {
//        if let model = model as? DemoAnimationCellModel {
//            contentHeight.constant = model.show ? 100 : 200
//        }
//        if let row = model as? RxAnimationRowModel,let model = row.model as? DemoAnimationCellModel {
//            print("打印的是否展示--\(model.show ? 200 : 120)--\(row)")
//
//            contentBackView.layoutIfNeeded()
//        }

//    }
    
//    override func tapGestureViewsForCell() -> [RxGestureModel] {
//        return [RxGestureModel(code: "moreImage",view: moreImage)]
//    }
//
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
