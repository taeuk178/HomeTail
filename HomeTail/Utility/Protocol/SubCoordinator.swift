//
//  SubCoordinator.swift
//  HomeTail
//
//  Created by taeuk on 2021/07/02.
//

import UIKit

protocol SubCoordinator: AnyObject {
    func presenter()
}

extension SubCoordinator where Self: UIViewController {
    
    func previous() {
        self.dismiss(animated: true, completion: nil)
    }
}
