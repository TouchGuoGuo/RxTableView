//
//  DemoCollectionViewVC.swift
//  RxTableViewDemo
//
//  Created by guoguo on 2022/11/8.
//

import UIKit


struct DemoCollectionCellModel : RxSectionType {
    var cellName: String = DemoCollectionViewCell.className
    var registerStyle: RxSectionCellRegisterStyle = .nib
}

class DemoCollectionViewVC: UIViewController {

    @IBOutlet weak var collectionview: RxCollectionView! {
        didSet {
            let layout = UICollectionViewFlowLayout()
            layout.itemSize = CGSize(width: screen_width / 4 - 10, height: screen_width / 4 - 10)
            layout.minimumLineSpacing = 10
            layout.minimumInteritemSpacing = 10
            collectionview.collectionViewLayout = layout
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let model = DemoCollectionCellModel()
        let section = RxSectionModel(items: [model,model,model,model,model,model,model])
        collectionview.list.accept([section])
        
        // Do any additional setup after loading the view.
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
