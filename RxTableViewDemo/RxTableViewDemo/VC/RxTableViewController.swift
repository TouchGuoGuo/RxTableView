//
//  RxTableViewController.swift
//  RxTableViewDemo
//
//  Created by yh jl on 2024/10/29.
//

import UIKit
import RxDataSources



class RxTableViewController: BaseVC {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        Manager.shared.animationSwitch.bind { [weak self] event in
//            guard let self = self else { return }
////            animationTableView.list.accept([])
////            tableview.list.accept([])
//            if event {
//            } else {
//            }
//        }.disposed(by: disposebag)
        
//        tableview.rx.modelSelected(RxTableViewControllerModel.self).subscribe { [weak self] event in
//            guard let self = self else { return }
//            if let model = event.element {
//            }
//        }.disposed(by: disposebag)
        
        tableview.rx.itemSelected.subscribe { [weak self] event in
            guard let self = self else { return }
            if let indexPath = event.element {
                let section = self.sections[indexPath.section]
                if let model = section.items[indexPath.row] as? RxTableViewControllerModel {
                    self.showActionAlert(title: "选中", string: "选中了:\(model.title)\nSection：\(indexPath.section)\nRow：\(indexPath.row)")
                }
            }
        }.disposed(by: disposebag)
        
        animationTableView.rx.itemSelected.subscribe { [weak self] event in
            guard let self = self else { return }
            if let indexPath = event.element {
                let section = self.sections[indexPath.section]
                if let model = section.items[indexPath.row] as? RxTableViewControllerModel {
                    self.showActionAlert(title: "选中", string: "选中了:\(model.title)\nSection：\(indexPath.section)\nRow：\(indexPath.row)")
                }
            }
        }.disposed(by: disposebag)

        
                
    }
    
}
