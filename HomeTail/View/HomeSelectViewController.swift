//
//  HomeSelectViewController.swift
//  HomeTail
//
//  Created by taeuk on 2021/06/13.
//

import UIKit

class HomeSelectViewController: BaseViewController {

    let customview = UIView()
    
    override func didMove(toParent parent: UIViewController?) {
        customview.frame = CGRect(x: 0, y: view.frame.size.height / 2, width: view.frame.size.width, height: view.frame.size.height / 2)
        
        customview.backgroundColor = .orange
          
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
        self.customview.translatesAutoresizingMaskIntoConstraints = false
        
        let button = UIButton(type: .close)
        button.setTitle("ㄷㅅㄴㅅ", for: .normal)
        button.center = customview.center
        button.backgroundColor = .white
        customview.addSubview(button)
    }
    
}
