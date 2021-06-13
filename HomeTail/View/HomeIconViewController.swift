//
//  HomeIconViewController.swift
//  HomeTail
//
//  Created by taeuk on 2021/06/13.
//

import UIKit

class HomeIconViewController: UIViewController {

    let customView = UIView()
    let testLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
    var customViewModel: HomeViewModel?
    
    override func didMove(toParent parent: UIViewController?) {
        customView.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height / 2)
        customView.backgroundColor = .blue
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        customViewModel?.onUpdated = { [weak self] in
//            self?.button.setTitle(self?.customViewModel.dateTest, for: .normal)   // 1
//            self?.testLabel.text = self?.customViewModel?.dateTest    // 2
            
        }
        
        customViewModel?.name.bindAndFire(listener: { [weak self] test in
            self?.testLabel.text = test
        })
        
//        testLabel.text 
        testLabel.center = customView.center
        testLabel.textAlignment = .center
        customView.addSubview(testLabel)
        
        self.customView.translatesAutoresizingMaskIntoConstraints = false
    }
    
}
