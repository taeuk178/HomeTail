//
//  HomeIconViewController.swift
//  HomeTail
//
//  Created by taeuk on 2021/06/13.
//

import UIKit

class HomeTopViewController: BaseViewController {

    // MARK: - Properties
    
    private let customView: UIView = {
        $0.backgroundColor = .white
        return $0
    }(UIView())
    
    private let selectHelpLabel: UILabel = {
        $0.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        $0.textAlignment = .center
        $0.font = .systemFont(ofSize: 28)
        return $0
    }(UILabel())
    
    var customViewModel: HomeViewModel?

    lazy var customDrawView: CustomGlassView = {
        $0.backgroundColor = .clear
        $0.frame = CGRect(x: 0, y: 0, width: view.frame.size.width * 0.5, height: view.frame.size.height * 0.25)
        return $0
    }(CustomGlassView())
    
    // MARK: - LifeCycle
    
    override func didMove(toParent parent: UIViewController?) {
        view.backgroundColor = .white
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        customView.addSubview(customDrawView)
        
        customViewModel?.name.bindAndFire(listener: { [weak self] test in
            self?.selectHelpLabel.text = test
        })
        
        customViewModel?.connectCase.bindAndFire(listener: { [weak self] test in
            guard let self = self else { return }
            
            switch test {
            case .taste:
                self.selectHelpLabel.text = "\(test.texture)을 선택해 주세요."
//                self.customDrawView.gradientColorInit()

            case .base:
                self.selectHelpLabel.text = "\(test.texture)를 선택해 주세요."
//                self.customDrawView.tasteGradient()
                
            case .alcohol:
                
                self.selectHelpLabel.text = "\(test.texture)를 선택해 주세요."
//                self.customDrawView.baseGradient()
            }
        })
        
        customViewModel?.showColor.bind(listener: { [weak self] color in
            guard let self = self else { return }
            
            switch color {
            case .taste:
                self.customDrawView.gradientColorInit()
            case .base:
                self.customDrawView.tasteGradient()
            case .alcohol:
                self.customDrawView.baseGradient()
            case .none:
                self.customDrawView.alcoholGradient()
            }
        })
    }
    
}

// MARK: - UI

extension HomeTopViewController {
    
    override func setupConfiguration() {
                    
        view.addSubview(selectHelpLabel)
        view.addSubview(customView)
        
    }
    
    override func setupConstraints() {
        
        customView.snp.makeConstraints {
            $0.bottom.equalTo(view).offset(-20)
            $0.centerX.equalTo(view)
            $0.width.height.equalTo(200)
        }
        
        selectHelpLabel.snp.makeConstraints {
            $0.top.equalTo(view).offset(view.frame.size.height * 0.1)
            $0.centerX.equalTo(view)
            $0.width.greaterThanOrEqualTo(50)
        }
    }
}
