//
//  DemoCollectionViewCell.swift
//  RxTableViewDemo
//
//  Created by guoguo on 2022/12/8.
//

import UIKit

class DemoCollectionViewCell: RxCollectionViewCell {

    @IBOutlet weak var title: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setupCellIndexModel(model: Any, indexPath: IndexPath) {
        title.text = "\(indexPath.row)"
    }

}
