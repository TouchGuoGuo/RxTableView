//
//  RxTableViewControllerCellTap.swift
//  RxTableViewDemo
//
//  Created by yh jl on 2024/11/7.
//

import UIKit

class RxTableViewControllerCellTap: BaseVC {

    

    override func viewDidLoad() {
        super.viewDidLoad()

        sections = [
            RxSectionModel(items: [
                RxXibModel(cell: DemoTableViewCell.self, title:"老虎🐅"),
                RxXibModel(cell: DemoTableViewCell.self,title:"猴子🐒"),
                RxXibModel(cell: DemoTableViewCell.self,title:"狮子🦁"),
                RxXibModel(cell: DemoTableViewCell.self,title:"长颈鹿🦒"),
                RxXibModel(cell: DemoTableViewCell.self,title:"大象🐘"),
                RxXibModel(cell: DemoTableViewCell.self,title:"大象🐘"),
                RxXibModel(cell: DemoTableViewCell.self,title:"大象🐘"),
                RxXibModel(cell: DemoTableViewCell.self,title:"大象🐘"),
                RxXibModel(cell: DemoTableViewCell.self,title:"大象🐘"),
                RxXibModel(cell: DemoTableViewCell.self,title:"大象🐘"),
                RxXibModel(cell: DemoTableViewCell.self,title:"大象🐘"),
                RxXibModel(cell: DemoTableViewCell.self,title:"大象🐘"),
                RxXibModel(cell: DemoTableViewCell.self,title:"大象🐘"),
                RxXibModel(cell: DemoTableViewCell.self,title:"大象🐘"),
                RxXibModel(cell: DemoTableViewCell.self,title:"大象🐘"),
                RxXibModel(cell: DemoTableViewCell.self,title:"大象🐘")
            ],header: "normal"),
        ]
        
        animationSections = [
            RxAnimationSectionModel(items: [
                AnyRxAnimationRowType(RxXibModel(cell: DemoTableViewCell.self,title:"老虎🐅")),
                AnyRxAnimationRowType(RxXibModel(cell: DemoTableViewCell.self,title:"猴子🐒")),
                AnyRxAnimationRowType(RxXibModel(cell: DemoTableViewCell.self,title:"狮子🦁")),
                AnyRxAnimationRowType(RxXibModel(cell: DemoTableViewCell.self,title:"长颈鹿🦒")),
                AnyRxAnimationRowType(RxXibModel(cell: DemoTableViewCell.self,title:"长颈鹿🦒")),
                AnyRxAnimationRowType(RxXibModel(cell: DemoTableViewCell.self,title:"长颈鹿🦒")),
                AnyRxAnimationRowType(RxXibModel(cell: DemoTableViewCell.self,title:"长颈鹿🦒")),
                AnyRxAnimationRowType(RxXibModel(cell: DemoTableViewCell.self,title:"长颈鹿🦒")),
                AnyRxAnimationRowType(RxXibModel(cell: DemoTableViewCell.self,title:"长颈鹿🦒")),
                AnyRxAnimationRowType(RxXibModel(cell: DemoTableViewCell.self,title:"长颈鹿🦒")),
                AnyRxAnimationRowType(RxXibModel(cell: DemoTableViewCell.self,title:"长颈鹿🦒")),
                AnyRxAnimationRowType(RxXibModel(cell: DemoTableViewCell.self,title:"长颈鹿🦒")),
                AnyRxAnimationRowType(RxXibModel(cell: DemoTableViewCell.self,title:"长颈鹿🦒")),
                AnyRxAnimationRowType(RxXibModel(cell: DemoTableViewCell.self,title:"长颈鹿🦒")),
                AnyRxAnimationRowType(RxXibModel(cell: DemoTableViewCell.self,title:"长颈鹿🦒")),
                AnyRxAnimationRowType(RxXibModel(cell: DemoTableViewCell.self,title:"大象🐘"))
            ],header: "animation",id:UUID()),
        ]
        
        tableview.list.accept(sections)
        animationTableView.list.accept(animationSections)
        
        
        tableview.gesture.bind { [weak self] event in
            guard let self = self else { return }
            if let indexPath = event.indexPath {
                self.showActionAlert(title: "点击cell", string: "\(event.identifier)--\(indexPath)")
            }
        }.disposed(by: disposebag)
        
        animationTableView.gesture.bind { [weak self] event in
            guard let self = self else { return }
            if let indexPath = event.indexPath {
                self.showActionAlert(title: "点击cell", string: "\(event.identifier)--\(indexPath)")
            }
        }.disposed(by: disposebag)

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
