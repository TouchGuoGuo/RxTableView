//
//  RxTableViewControllerXib.swift
//  RxTableViewDemo
//
//  Created by yh jl on 2024/11/1.
//

import UIKit

struct RxXibModel : RxRowType, RxAnimationRowType {
    var cell: UIView.Type = RxXibTableViewCell.self
    var title:String
}

class RxTableViewControllerXib: UIViewController {

    @IBOutlet weak var tableview: RxTableView!
    
    
    @IBOutlet weak var animationTableView: RxAnimationTableView!
    
    lazy var sections:[RxSectionModel] = [
        RxSectionModel(items: [
            RxXibModel(title:"老虎🐅"),
            RxXibModel(title:"猴子🐒"),
            RxXibModel(title:"狮子🦁"),
            RxXibModel(title:"长颈鹿🦒"),
            RxXibModel(title:"大象🐘")
        ],header: "normal"),
    ]
    
    
    lazy var animationSections:[RxAnimationSectionModel] = [
        RxAnimationSectionModel(items: [
            AnyRxAnimationRowType(RxXibModel(title:"老虎🐅")),
            AnyRxAnimationRowType(RxXibModel(title:"猴子🐒")),
            AnyRxAnimationRowType(RxXibModel(title:"狮子🦁")),
            AnyRxAnimationRowType(RxXibModel(title:"长颈鹿🦒")),
            AnyRxAnimationRowType(RxXibModel(title:"大象🐘"))
        ],header: "animation",id:UUID()),
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
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
