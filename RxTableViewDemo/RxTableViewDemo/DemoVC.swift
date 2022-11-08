//
//  DemoVC.swift
//  RxTableViewDemo
//
//  Created by guoguo on 2022/11/8.
//

import UIKit
import RxTableView_RxCollectionView

class DemoVC: UIViewController {

    
    
    var tableview = RxTableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        view.addSubview(tableview)
        
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
