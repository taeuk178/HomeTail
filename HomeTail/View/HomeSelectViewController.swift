//
//  HomeSelectViewController.swift
//  HomeTail
//
//  Created by taeuk on 2021/06/13.
//

import UIKit

class HomeSelectViewController: BaseViewController {

    let customview = UIView()
    var customViewModel: HomeViewModel?
    var button = UIButton()
    
    override func didMove(toParent parent: UIViewController?) {
        customview.frame = CGRect(x: 0, y: view.frame.size.height / 2, width: view.frame.size.width, height: view.frame.size.height / 2)
        
        customview.backgroundColor = .orange
          
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
        self.customview.translatesAutoresizingMaskIntoConstraints = false
        
        button = UIButton(type: .custom, primaryAction: UIAction(handler: { _ in
//                self.customViewModel.bindData("hello ViewModel")
            self.customViewModel?.dateTest = "hello"
        }))
        
        button.frame = CGRect(x: 0, y: 0, width: 150, height: 50)
        button.setTitle("ㄷㅅㄴㅅ", for: .normal)
        button.center = customview.center
        customview.addSubview(button)
    }
    
}
