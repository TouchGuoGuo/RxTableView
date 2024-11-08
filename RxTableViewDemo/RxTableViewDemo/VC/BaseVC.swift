//
//  BaseVC.swift
//  RxTableViewDemo
//
//  Created by yh jl on 2024/10/29.
//

import UIKit
import RxSwift
import RxRelay

class Manager {
    
    static let shared = Manager()
    
    let animationSwitch = BehaviorRelay<Bool>(value:false)
}

struct RxTableViewControllerModel : RxRowType,RxAnimationRowType {
    var cell: UIView.Type = RxTableViewControllerCell.self
    var title:String
}

class RxTableViewControllerCell : RxTableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setupCellIndexModel(model: Any, indexPath: IndexPath) {
        super.setupCellIndexModel(model: model, indexPath: indexPath)
        if let model = model as? RxTableViewControllerModel {
            textLabel?.text = model.title
        }
        if let base = model as? AnyRxAnimationRowType,let model = base._base as? RxTableViewControllerModel {
            textLabel?.text = model.title
        }
        
    }
}

class RxTableViewCustomStyleCell : RxTableViewCell {
    
    private let colors:[UIColor] = [.red,.blue,.orange,.purple,.yellow,.green,.cyan,.gray]
    
    private lazy var label:UILabel = {
       let view = UILabel()
        if let color = colors.randomElement() {
            view.textColor = color
        }
        view.textAlignment = .center
        view.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(label)
        label.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.height.equalTo(100).priority(.high)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setupCellIndexModel(model: Any, indexPath: IndexPath) {
        super.setupCellIndexModel(model: model, indexPath: indexPath)
        if let model = model as? RxTableViewControllerModel {
            label.text = model.title
        }
        if let base = model as? AnyRxAnimationRowType,let model = base._base as? RxTableViewControllerModel {
            label.text = model.title
        }
    }
}



class BaseVC: UIViewController {

    var disposebag = DisposeBag()
    
    lazy var tableview = RxTableView(style: .grouped)
    
    lazy var animationTableView = RxAnimationTableView(style: .grouped)
    
    lazy var sections:[RxSectionModel] = [
        RxSectionModel(items: [
            RxTableViewControllerModel(title:"老虎🐅"),
            RxTableViewControllerModel(title:"猴子🐒"),
            RxTableViewControllerModel(title:"狮子🦁"),
            RxTableViewControllerModel(title:"长颈鹿🦒"),
            RxTableViewControllerModel(title:"大象🐘"),
            RxTableViewControllerModel(title:"狗🐶"),
            RxTableViewControllerModel(title:"猫🐱"),
            RxTableViewControllerModel(title:"鸟🐦"),
            RxTableViewControllerModel(title:"熊🐻"),
            RxTableViewControllerModel(title:"熊猫🐼"),
            RxTableViewControllerModel(title:"老鼠🐭"),
            RxTableViewControllerModel(title:"企鹅🐧"),
            RxTableViewControllerModel(title:"绵阳🐑"),
            RxTableViewControllerModel(title:"狐狸🦊"),
            RxTableViewControllerModel(title:"袋鼠🦘"),
        ],header: "动物"),
        RxSectionModel(items: [
            RxTableViewControllerModel(title:"梨🍐"),
            RxTableViewControllerModel(title:"西瓜🍉"),
            RxTableViewControllerModel(title:"桃子🍑"),
            RxTableViewControllerModel(title:"草莓🍓"),
            RxTableViewControllerModel(title:"香蕉🍌"),
            RxTableViewControllerModel(title:"苹果🍎"),
            RxTableViewControllerModel(title:"青苹果🍏"),
            RxTableViewControllerModel(title:"菠萝🍍"),
            RxTableViewControllerModel(title:"柠檬🍋"),
            RxTableViewControllerModel(title:"葡萄🍇"),
            RxTableViewControllerModel(title:"西红柿🍅"),
            RxTableViewControllerModel(title:"奇异果🥝"),
            RxTableViewControllerModel(title:"橘子🍊"),
            RxTableViewControllerModel(title:"芒果🥭"),
            RxTableViewControllerModel(title:"椰子🥥"),
            RxTableViewControllerModel(title:"樱桃🍒"),
        ],header: "水果")
    ]
    
    lazy var animationSections:[RxAnimationSectionModel] = [
        RxAnimationSectionModel(items: [
            AnyRxAnimationRowType(RxTableViewControllerModel(title:"老虎🐅")),
            AnyRxAnimationRowType(RxTableViewControllerModel(title:"猴子🐒")),
            AnyRxAnimationRowType(RxTableViewControllerModel(title:"狮子🦁")),
            AnyRxAnimationRowType(RxTableViewControllerModel(title:"长颈鹿🦒")),
            AnyRxAnimationRowType(RxTableViewControllerModel(title:"大象🐘")),
            AnyRxAnimationRowType(RxTableViewControllerModel(title:"狗🐶")),
            AnyRxAnimationRowType(RxTableViewControllerModel(title:"猫🐱")),
            AnyRxAnimationRowType(RxTableViewControllerModel(title:"鸟🐦")),
            AnyRxAnimationRowType(RxTableViewControllerModel(title:"熊🐻")),
            AnyRxAnimationRowType(RxTableViewControllerModel(title:"熊猫🐼")),
            AnyRxAnimationRowType(RxTableViewControllerModel(title:"老鼠🐭")),
            AnyRxAnimationRowType(RxTableViewControllerModel(title:"企鹅🐧")),
            AnyRxAnimationRowType(RxTableViewControllerModel(title:"绵阳🐑")),
            AnyRxAnimationRowType(RxTableViewControllerModel(title:"狐狸🦊")),
            AnyRxAnimationRowType(RxTableViewControllerModel(title:"袋鼠🦘")),

        ],header: "动物",id:UUID()),
        RxAnimationSectionModel(items: [
            AnyRxAnimationRowType(RxTableViewControllerModel(title:"梨🍐")),
            AnyRxAnimationRowType(RxTableViewControllerModel(title:"西瓜🍉")),
            AnyRxAnimationRowType(RxTableViewControllerModel(title:"桃子🍑")),
            AnyRxAnimationRowType(RxTableViewControllerModel(title:"草莓🍓")),
            AnyRxAnimationRowType(RxTableViewControllerModel(title:"香蕉🍌")),
            AnyRxAnimationRowType(RxTableViewControllerModel(title:"苹果🍎")),
            AnyRxAnimationRowType(RxTableViewControllerModel(title:"青苹果🍏")),
            AnyRxAnimationRowType(RxTableViewControllerModel(title:"菠萝🍍")),
            AnyRxAnimationRowType(RxTableViewControllerModel(title:"柠檬🍋")),
            AnyRxAnimationRowType(RxTableViewControllerModel(title:"葡萄🍇")),
            AnyRxAnimationRowType(RxTableViewControllerModel(title:"西红柿🍅")),
            AnyRxAnimationRowType(RxTableViewControllerModel(title:"奇异果🥝")),
            AnyRxAnimationRowType(RxTableViewControllerModel(title:"橘子🍊")),
            AnyRxAnimationRowType(RxTableViewControllerModel(title:"芒果🥭")),
            AnyRxAnimationRowType(RxTableViewControllerModel(title:"椰子🥥")),
            AnyRxAnimationRowType(RxTableViewControllerModel(title:"樱桃🍒")),
        ],header: "水果",id: UUID())
    ]

    private lazy var onSwitch:UISwitch = {
       let view = UISwitch()
        return view
    }()


    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        tableview.frame = view.bounds
        view.addSubview(tableview)
        animationTableView.frame = view.bounds
        view.addSubview(animationTableView)
        tableview.sectionFooterHeight = 0
        animationTableView.sectionFooterHeight = 0
        setupRightItems(views: [onSwitch])
        
        Manager.shared.animationSwitch.bind(to: onSwitch.rx.isOn).disposed(by: disposebag)
        onSwitch.rx.isOn.bind(to: Manager.shared.animationSwitch).disposed(by: disposebag)
        onSwitch.rx.isOn.map({$0}).bind(to: tableview.rx.isHidden).disposed(by: disposebag)
        onSwitch.rx.isOn.map({!$0}).bind(to: animationTableView.rx.isHidden).disposed(by: disposebag)
        Manager.shared.animationSwitch.map({$0 ? "动画开启" : "动画关闭"}).bind(to: rx.title).disposed(by: disposebag)
        
        animationTableView.list.accept(animationSections)
        tableview.list.accept(sections)

    }
    
    func setupRightItems(views:[UIView]) {
        var barbuttonItems:[UIBarButtonItem] = []
        views.forEach({
            let rightItem = UIBarButtonItem(customView: $0)
            barbuttonItems.append(rightItem)
        })
        navigationItem.rightBarButtonItems = barbuttonItems
    }
    
    func setupLeftItems(views:[UIView]) {
        var barbuttonItems:[UIBarButtonItem] = []
        views.forEach({
            let rightItem = UIBarButtonItem(customView: $0)
            barbuttonItems.append(rightItem)
        })
        navigationItem.leftBarButtonItems = barbuttonItems
    }
    
    func showActionAlert(title:String,string:String) {
        let alert = UIAlertController(title: title, message: string, preferredStyle: .alert)
        let action = UIAlertAction(title: "确定", style: .default)
        alert.addAction(action)
        showDetailViewController(alert, sender: self)
    }


    func functionFooterView(title:String,section:Int) -> UIView {
        let button = UIButton(type: .custom)
        button.setTitle("\(title)-\(section)", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        let tapGesture = UITapGestureRecognizer()
        tapGesture.rx.event.bind(onNext: { [weak self] _ in
            guard let self = self else { return }
            let new = RxTableViewControllerModel(title: "点击\(section)-\(title)")
            let newSection = RxSectionModel(items: [new])
            let new_animation = AnyRxAnimationRowType(new)
            let newSection_animation = RxAnimationSectionModel(items: [new_animation],id: UUID())
            switch title {
            case "添加section":
                tableview.list.append(newSection)
                animationTableView.list.append(newSection_animation)
                tableview.scrollToRow(at: IndexPath(row: 0, section: tableview.list.value.count - 1), at: .middle, animated: true)
                animationTableView.scrollToRow(at: IndexPath(row: 0, section: animationTableView.list.value.count - 1), at: .middle, animated: true)
            case "插入section":
                tableview.list.insert(newSection, at: section)
                animationTableView.list.insert(newSection_animation, at: section)
            case "删除section":
                tableview.list.removeFirst()
                animationTableView.list.removeFirst()
            case "添加row":
                tableview.list.updateItems(inSection: section, modify: {$0.append(new)})
                animationTableView.list.updateItems(inSection: section, modify: {$0.append(new_animation)})
            case "插入row":
                tableview.list.updateItems(inSection: section, modify: {$0.insert(new, at: 0)})
                animationTableView.list.updateItems(inSection: section, modify: {$0.insert(new_animation, at: 0)})
            case "删除row":
                tableview.list.updateItems(inSection: section, modify: {
                    if $0.isEmpty {return}
                    $0.removeLast()
                })
                animationTableView.list.updateItems(inSection: section, modify: {
                    if $0.isEmpty {return}
                    $0.removeLast()
                })
            default:
                break
            }
            
        }).disposed(by: disposebag)
        button.addGestureRecognizer(tapGesture)
        return button
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
