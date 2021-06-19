//
//  HomeSelectReusableView.swift
//  HomeTail
//
//  Created by taeuk on 2021/06/19.
//

import UIKit
import SnapKit

class HomeSelectReusableView: UICollectionReusableView {
    
    // MARK: - properties
    
    private let headerView: UIView = create {
        $0.backgroundColor = .white
    }
    
    private let headerLabel: UILabel = create {
        $0.textAlignment = .center
        $0.font = .systemFont(ofSize: 20)
    }
    
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
