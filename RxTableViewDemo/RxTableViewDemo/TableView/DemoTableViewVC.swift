//
//  DemoTableViewVC.swift
//  RxTableViewDemo
//
//  Created by guoguo on 2022/11/8.
//

import UIKit
import RxTableView_RxCollectionView
import RxSwift


struct DemoTableViewModel : RxSectionType {
    var cellName: String = DemoTableViewCell.className
    var registerStyle: RxSectionCellRegisterStyle = .nib
    var title:String = ""
    
}

class DemoTableViewVC: UIViewController {

    let disposebag = DisposeBag()

    var source1:[DemoTableViewModel] = [
        DemoTableViewModel(title:"老虎🐅"),
        DemoTableViewModel(title:"猴子🐒"),
        DemoTableViewModel(title:"狮子🦁"),
        DemoTableViewModel(title:"长颈鹿🦒"),
        DemoTableViewModel(title:"大象🐘")
    ]
    var source2:[DemoTableViewModel] = [
        DemoTableViewModel(title:"苹果"),
        DemoTableViewModel(title:"西瓜🍉"),
        DemoTableViewModel(title:"桃子🍑"),
        DemoTableViewModel(title:"草莓🍓"),
        DemoTableViewModel(title:"香蕉🍌")
    ]
    
    lazy var sections = [
        RxSectionModel(items:source1),
        RxSectionModel(items:source2)
        ]

    var isEdit:Bool = false
    
    @IBOutlet weak var tableview: RxTableView! {
        didSet {
            tableview.rx.setDelegate(self).disposed(by: disposebag)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "TableView"
        setupItem()
        binderSource()
        loadAction()
    }
    
    
    func setupItem() {
        
        let label = UILabel()
        label.text = "Edit"
        let rightItem = UIBarButtonItem(customView: label)
        navigationItem.rightBarButtonItem = rightItem
        label.rx.tapGesture().when(.recognized).subscribe { [weak self] _ in
            guard let self = self else { return }
            self.isEdit = !self.isEdit
            label.text = self.isEdit ? "Exit" : "Edit"
            self.tableview.allowEdit = self.isEdit
            self.tableview.reloadData()
        }.disposed(by: disposebag)
        
    }
    
    func binderSource() {
        tableview.list.accept(sections)
    }
    
    func loadAction() {
        
        tableview.rx.modelSelected(DemoTableViewModel.self).subscribe { [weak self] event in
            guard let self = self else { return }
            if let model = event.element {
                self.showActionAlert(title: "点击行中的model", string: "\(model.title)")
            }
        }.disposed(by: disposebag)
        
        tableview.rx.itemDeleted.subscribe { [weak self] event in
            guard let self = self else { return }
            if let indexPath = event.element {
                var section = self.sections[indexPath.section]
                section.items.remove(at: indexPath.row)
                self.sections[indexPath.section] = section
                self.binderSource()
            }
        }.disposed(by: disposebag)
        
        /// 移动cell事件的实现
//        tableview.rx.itemMoved.subscribe { [weak self] event in
////            event.element?.sourceIndex
//        }.disposed(by: disposebag)
        
        tableview.gestureSubject.subscribe { [weak self] event in
            guard let self = self else { return }
            if let model = event.element {
                self.showActionAlert(title: "点击cell中的组件", string: "code:-\(model.code)-model:\(model.model.debugDescription)")
            }
        }.disposed(by: disposebag)
        
        
    }
    
    func showActionAlert(title:String,string:String) {
        
        let alert = UIAlertController(title: title, message: string, preferredStyle: .alert)
        let action = UIAlertAction(title: "Done", style: .default)
        alert.addAction(action)
        showDetailViewController(alert, sender: self)
    }
    
    
    

}

extension DemoTableViewVC : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.frame = CGRect(x: 0, y: 0, width: screen_width, height: 40)
        view.backgroundColor = .gray
        let label = UILabel()
        view.addSubview(label)
        label.textAlignment = .center
        label.textColor = .blue
        label.frame = view.bounds
        label.text = "header=\(section)"
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView()
        view.frame = CGRect(origin: .zero, size: CGSize(width: screen_width, height: 40))
        view.backgroundColor = .lightGray
        let label = UILabel()
        view.addSubview(label)
        label.textAlignment = .center
        label.textColor = .red
        label.frame = view.bounds
        label.text = "footer=\(section)"
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 40
    }
    
//    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
//        return .none
//    }
    
    
    
    
    
}
