//
//  RxTableViewController+IndexTitles.swift
//  RxTableViewDemo
//
//  Created by yh jl on 2024/11/7.
//

import UIKit

class RxTableViewController_IndexTitles: BaseVC {

    override func viewDidLoad() {
        super.viewDidLoad()

        
        tableview.indexTitlesType = .header
                
        animationTableView.indexTitlesType = .custom(items: ["A","B"])
        
        animationTableView.sectionIndexColor = .red
        
        tableview.indexTitlesGesture.bind { [weak self] event in
            guard let self = self else { return }
            self.showActionAlert(title: "点击索引", string: "\(event.0)--\(event.1)")
        }.disposed(by: disposebag)
        
        animationTableView.indexTitlesGesture.bind { [weak self] event in
            guard let self = self else { return }
            self.showActionAlert(title: "点击索引", string: "\(event.0)--\(event.1)")
        }.disposed(by: disposebag)
        
        
        
//        animationTableView.rx.sectionIndex
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
