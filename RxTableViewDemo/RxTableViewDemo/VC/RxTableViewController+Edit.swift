//
//  RxTableViewController+Edit.swift
//  RxTableViewDemo
//
//  Created by yh jl on 2024/10/30.
//

import UIKit
import SnapKit
import RxSwift
import RxRelay

class RxTableViewController_Edit: BaseVC {

    private lazy var edit:UILabel = {
        let view = UILabel()
        view.textAlignment = .center
        view.textColor = .systemBlue
        return view
    }()
    
    private let onEdit = BehaviorRelay<Bool>(value: false)
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        
        tableview.rx.setDelegate(self).disposed(by: disposebag)
        view.addSubview(edit)
        edit.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.height.equalTo(55)
            make.left.right.equalToSuperview()
        }
        
        onEdit.map({$0 ? "关闭" : "编辑"}).bind(to: edit.rx.text).disposed(by: disposebag)
        
        tableview.snp.remakeConstraints { make in
            make.left.bottom.right.equalToSuperview()
            make.top.equalTo(edit.snp.bottom)
        }
        
        animationTableView.snp.remakeConstraints { make in
            make.left.bottom.right.equalToSuperview()
            make.top.equalTo(edit.snp.bottom)
        }
        
        edit.rx.tapGesture().when(.recognized).bind { [weak self] _ in
            guard let self = self else { return }
            if self.onEdit.value {
                self.tableview.closeEdit()
                self.animationTableView.closeEdit()
                self.onEdit.accept(false)
            } else {
                self.tableview.openEdit()
                self.animationTableView.openEdit(move: true)
                self.onEdit.accept(true)
            }
        }.disposed(by: disposebag)
        
        
        tableview.rx.itemDeleted.bind { [weak self] event in
            guard let self = self else { return }
            let indexPath = event
            self.sections[indexPath.section].items.remove(at: indexPath.row)
            self.tableview.list.accept(self.sections)
        }.disposed(by: disposebag)
        
        tableview.rx.itemInserted.bind { [weak self] event in
            guard let self = self else { return }
            let indexPath = event
            if let item = self.sections[indexPath.section].items.first {
                self.sections[indexPath.section].items.insert(item, at: indexPath.row)
                self.tableview.list.accept(self.sections)
            }
            

        }.disposed(by: disposebag)
        
        animationTableView.rx.itemDeleted.bind { [weak self] event in
            guard let self = self else { return }
            let indexPath = event
            self.animationSections[indexPath.section].items.remove(at: indexPath.row)
            self.animationTableView.list.accept(self.animationSections)
        }.disposed(by: disposebag)

        
        tableview.rx.itemMoved.bind { [weak self] event in
            guard let self = self else { return }
            self.showActionAlert(title: "移动", string: "从\(event.sourceIndex)移动到\(event.destinationIndex)")
        }.disposed(by: disposebag)
        
        animationTableView.rx.itemMoved.bind { [weak self] event in
            guard let self = self else { return }
            self.showActionAlert(title: "移动", string: "从\(event.sourceIndex)移动到\(event.destinationIndex)")
        }.disposed(by: disposebag)

        
//        edit.rx.tapGesture().when(.recognized)
//            .map({ [weak self] _ in
//                guard let self = self else { return false }
//                !self.onEdit.value ? self.tableview.openEdit() : self.tableview.closeEdit()
//                return !self.onEdit.value }
//            )
//            .bind(to: onEdit).disposed(by: disposebag)
        
        

        
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


extension RxTableViewController_Edit : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .insert
    }
    
    
}

