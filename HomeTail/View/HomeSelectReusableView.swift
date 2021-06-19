//
//  HomeSelectReusableView.swift
//  HomeTail
//
//  Created by taeuk on 2021/06/19.
//

import UIKit
import SnapKit

class HomeSelectReusableView: UICollectionReusableView {
    
    private let headerView: UIView = create {
        $0.backgroundColor = .blue
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("HomeSelectReusableView not")
    }
    
    func setConfigure() {
        addSubview(headerView)
        headerView.frame = bounds
    }
    
}
