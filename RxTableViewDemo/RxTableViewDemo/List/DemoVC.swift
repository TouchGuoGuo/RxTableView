//
//  DemoVC.swift
//  RxTableViewDemo
//
//  Created by guoguo on 2022/11/8.
//

import UIKit
import RxTableView_RxCollectionView
import RxSwift

struct DemoListModel :  RxSectionType {
    var registerStyle: RxSectionCellRegisterStyle = .nib
    var cellName: String = DemoListCell.className
    var title:String = ""
    var style:DemoListStyle = .tableview
}

enum DemoListStyle {
    case tableview
    case collectionview
}

class DemoVC: UIViewController {
    
    var tableview = RxTableView()

    var models:[DemoListModel] = [
        DemoListModel(title:"TableView",style: .tableview),
        DemoListModel(title:"CollectionView",style: .collectionview)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Demo"
        
        view.backgroundColor = .white
        
        tableview.frame = view.bounds
        
        view.addSubview(tableview)
        
        let section = RxSectionModel(items:models)
        
        tableview.list.accept([section])

        tableviewSelected()
    }
    
    
    let disposebag = DisposeBag()
    
    func tableviewSelected() {
        
        /// model类型不一致
        tableview.rx.itemSelected.subscribe { [weak self] event in
            guard let self = self else { return }
            if let indexPath = event.element {
                self.tableview.deselectRow(at: indexPath, animated: true)
                print("当前点击行---\(indexPath)")
                let model = self.models[indexPath.row]
                switch model.style {
                case .tableview:
                    let vc = DemoTableViewVC()
                    self.show(vc, sender: self)
                case .collectionview:
                    let vc = DemoCollectionViewVC()
                    self.show(vc, sender: self)
                    break
                }
            }
        }.disposed(by: disposebag)
        
        /// model类型一致或者不一致
//        RxSectionType.self
//        tableview.rx.modelSelected(DemoListModel.self).subscribe { [weak self] event in
//            guard let self = self else { return }
//            if let model = event.element {
//                switch model.style {
//                case .tableview:
//                    break
//                case .collectionview:
//                    break
//                }
//            }
//        }.disposed(by: disposebag)
        
        
        
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
