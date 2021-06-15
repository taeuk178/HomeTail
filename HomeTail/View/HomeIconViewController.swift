//
//  HomeIconViewController.swift
//  HomeTail
//
//  Created by taeuk on 2021/06/13.
//

import UIKit

class HomeIconViewController: BaseViewController {

    // MARK: - Properties
    
    let customView = UIView()
    let testLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
    var customViewModel: HomeViewModel?
    
    
    // MARK: - LifeCycle
    
    override func didMove(toParent parent: UIViewController?) {
        view.backgroundColor = .blue
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
    }
    
}

// MARK: - UI

extension HomeIconViewController {
    
    override func setupConfiguration() {
        
        testLabel.text = "A"
        testLabel.textAlignment = .center
        
        view.addSubview(testLabel)
        view.addSubview(customView)
        
    }
    
    override func setupConstraints() {
        
        customView.snp.makeConstraints {
            $0.top.equalTo(view).offset(20)
            $0.leading.equalTo(view).offset(20)
            $0.width.equalTo(100)
        }
        testLabel.snp.makeConstraints {
            $0.centerY.centerX.equalTo(view)
            $0.width.equalTo(50)
        }
    }
}
