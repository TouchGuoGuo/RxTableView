//
//  DemoListCell.swift
//  RxTableViewDemo
//
//  Created by guoguo on 2022/11/8.
//

import UIKit
import RxTableView_RxCollectionView

class DemoListCell: RxTableViewCell {

    @IBOutlet weak var title: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    override func setupCellModel(model: Any) {
        guard let model = model as? DemoListModel else { return }
        title.text = model.title
    }
    
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
