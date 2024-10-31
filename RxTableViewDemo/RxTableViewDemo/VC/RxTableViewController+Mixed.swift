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
            let types = [RxTableViewControllerCell.self,RxTableViewCustomStyleCell.self]
            let element = item.items.map { model in
                var new = model as? RxTableViewControllerModel
                new?.cell = types.randomElement() ?? RxTableViewCustomStyleCell.self
                return new!
            }
            return RxSectionModel(items: element)
        })
        
        animationSections = animationSections.map({ item in
            let types = [RxTableViewControllerCell.self,RxTableViewCustomStyleCell.self]
            let element = item.items.map { model in
                var new = model._base as? RxTableViewControllerModel
                new?.cell = types.randomElement() ?? RxTableViewCustomStyleCell.self
                return AnyRxAnimationRowType(new!)
            }
            return RxAnimationSectionModel(items: element)
        })
        
        tableview.list.accept(sections)
        animationTableView.list.accept(animationSections)
        

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
