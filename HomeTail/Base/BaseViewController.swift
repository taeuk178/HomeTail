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

        configuration()
        constraints()

    }

    // 설정
    @objc dynamic func configuration() {

    }

    // 제약
    @objc dynamic func constraints() {

    }
}
