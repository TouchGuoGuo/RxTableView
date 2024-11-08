//
//  RxTableView.swift
//  RxSwiftDemo
//
//  Created by guoguo on 2022/10/31.
//

import UIKit
import RxSwift
import RxRelay
import RxDataSources
import RxGesture

public enum RxTableViewIndexTitles {
    case none
    case header
    case footer
    case custom(items:[String])
}

open class RxTableView : UITableView {

    private var disposebag = DisposeBag()
            
    /// 设置tableView默认数据源
    private lazy var sectionSource = RxTableViewSectionedReloadDataSource<RxSectionModel> { [weak self] dataSource, tableview, indexPath, element in
        guard let self = self else { return UITableViewCell() }
        self.register(cell: element.cell)
        let identifier = String(describing: element.cell)
        guard let cell = tableview.dequeueReusableCell(withIdentifier: identifier) as? RxTableViewCell else { return UITableViewCell() }
        cell.setupCellIndexModel(model: element, indexPath: indexPath)
        cell.gestureModels.forEach { item in
            item.view.rx.tapGesture().when(.recognized)
                .map({ _ in item })
                .bind(to: self.gesture)
                .disposed(by: cell.disposebag)
        }
        return cell
    } titleForHeaderInSection: { dataSource, index in
        return dataSource.sectionModels[index].header
    } titleForFooterInSection: { dataSource, index in
        return dataSource.sectionModels[index].footer
    } canEditRowAtIndexPath: { [weak self] dataSource, indexPath in
        guard let self = self else { return false }
        return self.allowEdit
    } canMoveRowAtIndexPath: { [weak self] dataSource, indexPath in
        guard let self = self else { return false }
        return self.allowMove
    } sectionIndexTitles: { [weak self] dataSource in
        guard let self = self else { return nil }
        switch indexTitlesType {
        case .none:
            return nil
        case .header:
            return dataSource.sectionModels.map({$0.header ?? ""})
        case .footer:
            return dataSource.sectionModels.map({$0.footer ?? ""})
        case .custom(let items):
            return items
        }
    } sectionForSectionIndexTitle: { [weak self] dataSource, title, index in
        guard let self = self else { return index }
        self.indexTitlesGesture.onNext((title,index))
        return index
    }
        
    /// 绑定数据的数据源
    public var list = BehaviorRelay<[RxSectionModel]>(value: [])
    
    /// cell中的点击事件模型
    public var gesture = PublishSubject<RxCellGestureModel>()
    
    /// indexTitles类型 根据数据源自动设置 也可以使用custom自定义
    public var indexTitlesType:RxTableViewIndexTitles = .none {
        didSet {
            reloadSectionIndexTitles()
        }
    }
    
    /// 索引的点击事件
    public var indexTitlesGesture = PublishSubject<(String,Int)>()
    
    /// 允许编辑
    var allowEdit:Bool = false
    
    /// 允许拖动
    private var allowMove:Bool = false

    /// cell中视图点击信号
//    public let gestureSubject = PublishSubject<(model:RxGestureModel,indexPath:IndexPath)>()
    
    init(style:UITableView.Style = .plain) {
        super.init(frame: .zero, style: style)
        bindObservable()
    }
        
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        bindObservable()
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        bindObservable()
    }
    
    /// 打开编辑模式
    /// - Parameters:
    ///   - move: 是否允许拖动
    ///   - animated: animated description
    public func openEdit(move:Bool = false,animated:Bool = true) {
        setEditing(true, animated: animated)
        allowEdit = true
        allowMove = move
        reloadData()
    }
    
    /// 关闭编辑模式
    /// - Parameter animated: animated description
    public func closeEdit(animated:Bool = true) {
        setEditing(false, animated: animated)
        allowEdit = false
        allowMove = false
        reloadData()
    }


}


// MARK: 初始化方法以及私有方法
extension RxTableView {
    
    /// 将数据源和tableView进行动态绑定
    private func bindObservable() {
        if #available(iOS 15.0, *) {
            sectionHeaderTopPadding = 0
        }
        list.asObservable().bind(to: rx.items(dataSource: sectionSource)).disposed(by: disposebag)
    }
    
    
    
    

}


