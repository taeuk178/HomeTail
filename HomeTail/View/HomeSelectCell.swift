//
//  HomeSelectCell.swift
//  HomeTail
//
//  Created by taeuk on 2021/06/14.
//

import UIKit
import SnapKit

class HomeSelectCell: UICollectionViewCell {
    
    private let textLabel: UILabel = create {
        $0.text = "test"
        $0.textAlignment = .center
        $0.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpText(_ text: String) {
        textLabel.text = text
    }
    
    func setUp() {
        
//        textLabel.snp.makeConstraints {
//            $0.centerX.centerY.equalTo(contentView)
//            $0.width.equalTo(50)
//        }
//        textLabel.translatesAutoresizingMaskIntoConstraints = false
//        textLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
//        textLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
//        textLabel.widthAnchor.constraint(equalToConstant: 50).isActive = true
    }
}
