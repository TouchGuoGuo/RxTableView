//
//  RxTableView.swift
//  RxSwiftDemo
//
//  Created by 臧志明 on 2022/10/31.
//

import UIKit
import RxSwift
import RxRelay
import RxDataSources
import EmptyDataSet_Swift
import MJRefresh
import RxGesture

class RxTableView: UITableView {

    private var disposebag = DisposeBag()
    
    /// 设置tableView的数据源
    private lazy var sectionSource = RxTableViewSectionedReloadDataSource<RxSectionModel> { dataSource, tableview, indexPath, element in
        var cell = tableview.dequeueReusableCell(withIdentifier: element.cellName)
        if cell == nil {
            cell = RxTableViewCell(style: .value1, reuseIdentifier: element.cellName)
        }
        guard let cell = cell as? RxTableViewCell else {
            return RxTableViewCell(style: .value1, reuseIdentifier: element.cellName)
        }
        cell.setupCellModel(model: element)
        cell.setupCellIndexModel(model: element, indexPath: indexPath)
        let models = cell.tapGestureViewsForCell()
        for (index,item) in models.enumerated() {
            if let view = item.view {
                view.rx.tapGesture().when(.recognized).subscribe { _ in
                    self.gestureSubject.onNext(item)
                }.disposed(by: cell.disposebag)
            }
        }
        return cell
    } canEditRowAtIndexPath: { dataSource, indexPath in
        let source = dataSource.sectionModels
        let items = source[indexPath.section]
        let model = items.items[indexPath.row]
        return self.allowEdit
    } canMoveRowAtIndexPath: { dataSource, indexPath in
        let source = dataSource.sectionModels
        let items = source[indexPath.section]
        let model = items.items[indexPath.row]
        return self.allowEdit
    }

    
    /// tableview是否允许编辑
    var allowEdit:Bool = false {
        didSet {
            reloadData()
        }
    }
    
    /// 空数据标题 （不设置不显示）
    var emptyModel:RxEmptyModel? {
        didSet {
            setupEmptyView()
        }
    }
        
    /// 绑定数据的数据源 使用方式： tableview.list.accept
    var list = BehaviorRelay<[RxSectionModel]>(value: [])
    /// cell中视图点击信号
    let gestureSubject = PublishSubject<RxGestureModel>()
    /// 下拉刷新的信号
    let headerRefreshSubject = PublishSubject<Void>()
    /// 加载更多的信号
    let footerRefreshSubject = PublishSubject<Void>()
    
    init(style:UITableView.Style = .plain,allowEdit:Bool = false) {
        super.init(frame: .zero, style: style)
        self.allowEdit = allowEdit
        bindObservable()
    }
        
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        bindObservable()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        bindObservable()
    }

}

// MARK: 基础用法
extension RxTableView {
    
    /// 装载下拉刷新功能
    func setupHeaderRefresh() {
        let header = MJRefreshNormalHeader { [weak self] in
            guard let self = self else { return }
            self.headerRefreshSubject.onNext(())
        }
        header.isAutomaticallyChangeAlpha = true
        header.lastUpdatedTimeLabel?.isHidden = true
        header.setTitle("下拉可以加载更多", for: MJRefreshState.idle)
        header.setTitle("松开立即加载更多", for: MJRefreshState.pulling)
        header.setTitle("正在加载数据中...", for: MJRefreshState.refreshing)
        header.setTitle("已经全部加载完毕", for: MJRefreshState.noMoreData)
        mj_header = header
    }
    
    /// 装载加载更多功能
    func setupFooterRefresh() {
        let footer = MJRefreshBackNormalFooter { [weak self] in
            guard let self = self else { return }
            self.footerRefreshSubject.onNext(())
        }
        footer.isAutomaticallyChangeAlpha = true
        footer.setTitle("上拉可以加载更多", for: MJRefreshState.idle)
        footer.setTitle("松开立即加载更多", for: MJRefreshState.pulling)
        footer.setTitle("正在加载..", for: MJRefreshState.refreshing)
        footer.setTitle("已经到底啦", for: MJRefreshState.noMoreData)
        mj_footer = footer
    }
    
    /// 装载空数据功能
    private func setupEmptyView() {
        emptyDataSetSource = self
        emptyDataSetDelegate = self
        reloadData()
    }
}

// MARK: 初始化方法以及私有方法
extension RxTableView {
    
    /// 将数据源和tableView进行动态绑定
    private func bindObservable() {
        separatorStyle = .none
        tableFooterView = UIView()
        if #available(iOS 15.0, *) {
            sectionHeaderTopPadding = 0
        }
        list.asObservable().bind(to: rx.items(dataSource: sectionSource)).disposed(by: disposebag)
        list.subscribe { [unowned self] event in
            if let models = event.element {
                models.forEach({
                    $0.items.forEach({
                        registerCell(nibName: $0.cellName, style: $0.registerStyle)
                    })
                })
            }
        }.disposed(by: disposebag)
    }
    
    /// 注册cell
    /// - Parameters:
    ///   - nibName: nibName description
    ///   - style: style description
    private func registerCell(nibName:String,style:RxSectionCellRegisterStyle) {
        switch style {
        case .nib:
            let nib = UINib(nibName:nibName , bundle: nil)
            register(nib, forCellReuseIdentifier: nibName)
        case .class:
            let namespace = Bundle.main.infoDictionary!["CFBundleExecutable"] as! String
            let clsName = namespace + "." + nibName
            let cls = NSClassFromString(clsName) as! UITableViewCell.Type
            register(cls, forCellReuseIdentifier: nibName)
        }
    }

}

// MARK: 空数据以及占位图
extension RxTableView : EmptyDataSetSource, EmptyDataSetDelegate {
    
    func emptyDataSetShouldAllowScroll(_ scrollView: UIScrollView) -> Bool {
        true
    }
    
    func title(forEmptyDataSet scrollView: UIScrollView) -> NSAttributedString? {
        return self.emptyModel?.title
    }
    
    func description(forEmptyDataSet scrollView: UIScrollView) -> NSAttributedString? {
        return self.emptyModel?.description
    }
    
    func image(forEmptyDataSet scrollView: UIScrollView) -> UIImage? {
        guard let image = self.emptyModel?.image else { return nil }
        let imageSize = image.size
        let imageRatio = imageSize.height / imageSize.width
        let newWidth = UIScreen.main.bounds.width * (self.emptyModel?.ratio ?? 1.0)
        let newHeight = newWidth * imageRatio
        let newSize = CGSize(width: newWidth, height: newHeight)
        return image.resetImageSize(size: newSize)
    }
}

extension UIImage {
    func resetImageSize(size:CGSize) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, UIScreen.main.scale)
        draw(in: CGRect(origin: .zero, size: size))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
}




