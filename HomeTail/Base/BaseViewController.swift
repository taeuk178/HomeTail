//
//  ViewController.swift
//  HomeTail
//
//  Created by taeuk on 2021/06/04.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white

        setupConfiguration()
        setupConstraints()
        setupProperties()
        setupBinding()

    }

    /// 프로퍼티
    @objc dynamic func setupProperties() {}
    
    /// 바인딩
    @objc dynamic func setupBinding() {}
    
    /// 설정
    @objc dynamic func setupConfiguration() {}

    /// 제약
    @objc dynamic func setupConstraints() {}
}
