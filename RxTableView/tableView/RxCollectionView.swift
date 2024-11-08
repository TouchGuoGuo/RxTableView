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

open class RxCollectionView: UICollectionView {

//    private var disposebag = DisposeBag()
//    
//    /// 设置tableView的数据源
//    private lazy var sectionSource = RxCollectionViewSectionedReloadDataSource<RxSectionModel> { dataSource, collectionview, indexPath, element in
//        var cell = collectionview.dequeueReusableCell(withReuseIdentifier: element.cellName, for: indexPath) as! RxCollectionViewCell
//        cell.setupCellModel(model: element)
//        cell.setupCellIndexModel(model: element, indexPath: indexPath)
//        return cell
//    }
//        
//        
//    /// 绑定数据的数据源 使用方式： tableview.list.accept
//    public var list = BehaviorRelay<[RxSectionModel]>(value: [])
//    /// cell中视图点击信号
//    public let gestureSubject = PublishSubject<RxGestureModel>()
//    
//    
//    init(layout:UICollectionViewLayout = UICollectionViewLayout()) {
//        super.init(frame: .zero, collectionViewLayout: layout)
//        bindObservable()
//    }
//    
//    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
//        super.init(frame: frame, collectionViewLayout: layout)
//        bindObservable()
//    }
//    
//    required public init?(coder: NSCoder) {
//        super.init(coder: coder)
//        bindObservable()
//    }
    

}

// MARK: 初始化方法以及私有方法
extension RxCollectionView {
    
//    /// 将数据源和tableView进行动态绑定
//    private func bindObservable() {
//        list.asObservable().bind(to: rx.items(dataSource: sectionSource)).disposed(by: disposebag)
//    }

}

