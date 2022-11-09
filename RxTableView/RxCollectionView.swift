//
//  RxCollectionView.swift
//  RxSwiftDemo
//
//  Created by guoguo on 2022/10/31.
//

import UIKit
import RxSwift
import RxRelay
import RxDataSources
import EmptyDataSet_Swift
import MJRefresh
import RxGesture

class RxCollectionView: UICollectionView {

    private var disposebag = DisposeBag()
    
    /// 设置tableView的数据源
    private lazy var sectionSource = RxCollectionViewSectionedReloadDataSource<RxSectionModel> { dataSource, collectionview, indexPath, element in
        var cell = collectionview.dequeueReusableCell(withReuseIdentifier: element.cellName, for: indexPath) as! RxCollectionViewCell
        cell.setupCellModel(model: element)
        cell.setupCellIndexModel(model: element, indexPath: indexPath)
        return cell
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
    
    
    init(layout:UICollectionViewLayout = UICollectionViewLayout()) {
        super.init(frame: .zero, collectionViewLayout: layout)
        bindObservable()
    }
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        bindObservable()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        bindObservable()
    }
    

}

// MARK: 初始化方法以及私有方法
extension RxCollectionView {
    
    /// 将数据源和tableView进行动态绑定
    private func bindObservable() {
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
            register(nib, forCellWithReuseIdentifier: nibName)
        case .class:
            let namespace = Bundle.main.infoDictionary!["CFBundleExecutable"] as! String
            let clsName = namespace + "." + nibName
            let cls = NSClassFromString(clsName) as! UITableViewCell.Type
            register(cls, forCellWithReuseIdentifier: nibName)
        }
    }
}

// MARK: 基础用法
extension RxCollectionView {
    
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



// MARK: 空数据以及占位图
extension RxCollectionView : EmptyDataSetSource, EmptyDataSetDelegate {
    
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
