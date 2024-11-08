//
//  ViewController.swift
//  RxTableViewDemo
//
//  Created by guoguo on 2022/11/8.
//

import UIKit
import RxSwift
import RxGesture

struct ChapterModel : RxRowType,RxAnimationRowType {
    
    var cell: UIView.Type = ChapterCell.self
    var title:String
}


class ChapterCell : RxTableViewCell  {
    
    override func setupCellIndexModel(model: Any, indexPath: IndexPath) {
        guard let model = model as? ChapterModel else { return }
        textLabel?.text = model.title
    }
}



class ViewController: UIViewController {

    private var disposebag = DisposeBag()
    
    private lazy var models:[ChapterModel] = [
        ChapterModel(title: "列表"),
        ChapterModel(title: "插入section"),
        ChapterModel(title: "插入row"),
        ChapterModel(title: "编辑"),
        ChapterModel(title: "混合cell样式"),
        ChapterModel(title: "xib"),
        ChapterModel(title: "cell中的组件点击"),
        ChapterModel(title: "索引")
    ]
    
    private let tableView:RxTableView = RxTableView(style: .grouped)

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.sectionFooterHeight = 0
        tableView.frame = view.bounds
        view.addSubview(tableView)
        let section = RxSectionModel(items: models,header: "RxTableView + RxAnimationTableView")
        tableView.list.accept([section])
        binder()
        

    }
    
    
    private func binder() {
        tableView.rx.modelSelected(ChapterModel.self).bind { [weak self] model in
            guard let self = self else { return }
            let title = model.title
            switch title {
            case "列表":
                let vc = RxTableViewController()
                self.show(vc, sender: self)
            case "插入section":
                let vc = RxTableViewController_InsertSection()
                self.show(vc, sender: self)
            case "插入row":
                let vc = RxTableViewController_InsertRow()
                self.show(vc, sender: self)
            case "编辑":
                let vc = RxTableViewController_Edit()
                self.show(vc, sender: self)
            case "混合cell样式":
                let vc = RxTableViewController_Mixed()
                self.show(vc, sender: self)
            case "xib":
                let vc = RxTableViewControllerXib()
                self.show(vc, sender: self)
            case "cell中的组件点击":
                let vc = RxTableViewControllerCellTap()
                self.show(vc, sender: self)
            case "索引":
                let vc = RxTableViewController_IndexTitles()
                self.show(vc, sender: self)
            default:
                break
            }
        }.disposed(by: disposebag)
        
    }
}
