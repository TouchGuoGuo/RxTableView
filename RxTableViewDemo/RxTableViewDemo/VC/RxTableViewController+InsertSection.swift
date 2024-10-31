//
//  RxTableViewController+InsertSection.swift
//  RxTableViewDemo
//
//  Created by yh jl on 2024/10/30.
//

import UIKit

class RxTableViewController_InsertSection: BaseVC {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.rx.setDelegate(self).disposed(by: disposebag)
        animationTableView.rx.setDelegate(self).disposed(by: disposebag)
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


extension RxTableViewController_InsertSection : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIStackView()
        view.axis = .vertical
        view.addArrangedSubview(functionFooterView(title: "添加section", section: section))
        view.addArrangedSubview(functionFooterView(title: "插入section", section: section))
        view.addArrangedSubview(functionFooterView(title: "删除section", section: section))
        return view
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForFooterInSection section: Int) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
    
}
