//
//  HomeIconViewController.swift
//  HomeTail
//
//  Created by taeuk on 2021/06/13.
//

import UIKit

class HomeIconViewController: UIViewController {

    let customView = UIView()
    
    override func didMove(toParent parent: UIViewController?) {
        customView.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height / 2)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        customView.backgroundColor = .blue
        
    }
    

}
