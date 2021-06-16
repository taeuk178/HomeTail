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
    let selectHelpLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
    var customViewModel: HomeViewModel?

    // MARK: - LifeCycle
    
    override func didMove(toParent parent: UIViewController?) {
        view.backgroundColor = .white
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        customViewModel?.onUpdated = { [weak self] in
//            self?.button.setTitle(self?.customViewModel.dateTest, for: .normal)   // 1
//            self?.testLabel.text = self?.customViewModel?.dateTest    // 2
            
        }
        
        customViewModel?.name.bindAndFire(listener: { [weak self] test in
            self?.selectHelpLabel.text = test
        })
    }
    
}

// MARK: - UI

extension HomeIconViewController {
    
    override func setupConfiguration() {
        
        selectHelpLabel.textAlignment = .center
        selectHelpLabel.font = .systemFont(ofSize: 28)
        
        view.addSubview(selectHelpLabel)
        view.addSubview(customView)
        
    }
    
    override func setupConstraints() {
        
        customView.snp.makeConstraints {
            $0.top.equalTo(view).offset(20)
            $0.leading.equalTo(view).offset(20)
            $0.width.equalTo(100)
        }
        
        selectHelpLabel.snp.makeConstraints {
            $0.top.equalTo(view).offset(view.frame.size.height / 5)
            $0.centerX.equalTo(view)
            $0.width.greaterThanOrEqualTo(50)
        }
    }
}
