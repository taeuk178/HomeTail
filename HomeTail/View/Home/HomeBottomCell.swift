//
//  HomeSelectCell.swift
//  HomeTail
//
//  Created by taeuk on 2021/06/14.
//

import UIKit
import SnapKit

class HomeBottomCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    private let textLabel: UILabel = {
        $0.textAlignment = .center
        $0.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        return $0
    }(UILabel())
    
    // MARK: - LifeCycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - setUp
    
    func setUpText(_ text: String) {
        textLabel.text = text
    }
    
    func setUp() {
        contentView.addSubview(textLabel)
        
        textLabel.snp.makeConstraints {
            $0.centerX.centerY.equalTo(contentView)
            $0.width.greaterThanOrEqualTo(50)
        }
    }
}
