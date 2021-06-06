//
//  Protocol+ReusableCell.swift
//  HomeTail
//
//  Created by taeuk on 2021/06/06.
//

import UIKit

protocol ReusableCell: class {
    static var reuseIdentifier: String { get }
}

extension ReusableCell {
    static var reuseIdentifier: String { return String(describing: self) }
}
