//
//  HomeIconViewController.swift
//  HomeTail
//
//  Created by taeuk on 2021/06/13.
//

import UIKit

class HomeTopViewController: BaseViewController {

    // MARK: - Properties
    
    let customView = UIView()
    let selectHelpLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
    var customViewModel: HomeViewModel?

    lazy var customDrawView: CustomGlassView = {
        $0.backgroundColor = .clear
        return $0
    }(CustomGlassView(frame: CGRect(x: 0,
                                    y: 0,
                                    width: view.frame.size.width * 0.5,
                                    height: view.frame.size.height * 0.25)))
    
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

            case .base:
                self.selectHelpLabel.text = "\(test.texture)를 선택해 주세요."
                self.customDrawView.tasteGradient()
                
            case .alcohol:
                
                self.selectHelpLabel.text = "\(test.texture)를 선택해 주세요."
                self.customDrawView.baseGradient()
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
    
    override func setupProperties() {
        
        selectHelpLabel.textAlignment = .center
        selectHelpLabel.font = .systemFont(ofSize: 28)

        customView.backgroundColor = .appMainColor(.subSkyBlueColor)
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
