//
//  DemoAnimationTableViewVC.swift
//  RxTableViewDemo
//
//  Created by guoguo on 2022/11/25.
//

import UIKit
import RxSwift


//class DemoAnimationCellModel : RxAnimationRowModel {
//    override var cellName: String {
//        get { return DemoAnimationTableViewCell.className }
//        set {}
//    }
//    override var registerStyle: RxSectionCellRegisterStyle {
//        get { return .nib }
//        set { }
//    }
//    var show:Bool = false
//}

class DemoAnimationTableViewVC: UIViewController {

    
    var disposebag = DisposeBag()
    
//    lazy var models:[RxAnimationRowModel] = [
//        DemoAnimationCellModel(index: "0"),
//        DemoAnimationCellModel(index: "1"),
//        DemoAnimationCellModel(index: "2"),
//        DemoAnimationCellModel(index: "3"),
//        DemoAnimationCellModel(index: "4")
//    ]
//    
//    lazy var sections:[RxAnimationSectionModel] = [RxAnimationSectionModel(models: models)]
    
//    @IBOutlet weak var tableview: RxAnimationTableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        self.tableview.list.accept(sections)


//        tableview.rx.itemSelected.subscribe { [weak self] event in
//            guard let self = self else { return }
//            if let indexPath = event.element {
//                if let model = self.sections[indexPath.section].models[indexPath.row] as? DemoAnimationCellModel {
//                    model.show = !model.show
//                    self.tableview.reloadRows(at: [indexPath], with: .automatic)
//                }
//            }
//        }.disposed(by: disposebag)
        
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
