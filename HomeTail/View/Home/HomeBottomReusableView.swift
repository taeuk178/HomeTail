//
//  HomeSelectReusableView.swift
//  HomeTail
//
//  Created by taeuk on 2021/06/19.
//

import UIKit
import SnapKit

class HomeBottomReusableView: UICollectionReusableView {
    
    // MARK: - properties
    
    private let headerView: UIView = {
        $0.backgroundColor = .white
        return $0
    }(UIView())
    
    private let headerLabel: UILabel = {
        $0.textAlignment = .center
        $0.font = .appSansFont(.sansHWBold, size: 28)
        return $0
    }(UILabel())
    
    // MARK: - LifeCycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("HomeSelectReusableView not")
    }
    
    // MARK: - setUp
    
    func headerLabelText(_ text: String) {
        headerLabel.text = text
    }
    
    func setConfigure() {
        
        addSubview(headerView)
        addSubview(headerLabel)
        
        headerView.frame = bounds
        
        headerLabel.snp.makeConstraints {
            $0.centerY.equalTo(headerView)
            $0.leading.equalTo(headerView).offset(50)
            $0.width.greaterThanOrEqualTo(70)
        }
    }
    
}
