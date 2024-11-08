//
//  RxTableViewController+Mixed.swift
//  RxTableViewDemo
//
//  Created by yh jl on 2024/10/31.
//

import UIKit

class RxTableViewController_Mixed: BaseVC {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        sections = sections.map({ item in
            let element = item.items.map { model in
                var new = model as? RxTableViewControllerModel
                new?.title = "点我改变样式"
                return new!
            }
            return RxSectionModel(items: element)
        })
        
        animationSections = animationSections.map({ item in
            let element = item.items.map { model in
                var new = model._base as? RxTableViewControllerModel
                new?.title = "点我改变样式"
                
                return AnyRxAnimationRowType(new!)
            }
            return RxAnimationSectionModel(items: element)
        })
        
        tableview.list.accept(sections)
        animationTableView.list.accept(animationSections)
        
        tableview.rx.itemSelected.bind { [weak self] event in
            guard let self = self else { return }
            let indexPath = event
            var new = self.tableview.list.value[indexPath.section].items[indexPath.row]
            self.tableview.list.updateItems(inSection: indexPath.section) { rows in
                if (new.cell == RxTableViewControllerCell.self) {
                    new.cell = RxTableViewCustomStyleCell.self
                } else {
                    new.cell = RxTableViewControllerCell.self
                }
                rows[indexPath.row] = new
            }
        }.disposed(by: disposebag)
        
        
        animationTableView.rx.itemSelected.bind { [weak self] event in
            guard let self = self else { return }
            let indexPath = event
            animationTableView.deselectRow(at: indexPath, animated: true)
            var new = self.animationTableView.list.value[indexPath.section].items[indexPath.row]
            self.animationTableView.list.updateItems(inSection: indexPath.section) { rows in
                if (new._base.cell == RxTableViewControllerCell.self) {
                    new._base.cell = RxTableViewCustomStyleCell.self
                } else {
                    new._base.cell = RxTableViewControllerCell.self
                }
                rows[indexPath.row] = new
            }
        }.disposed(by: disposebag)


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
