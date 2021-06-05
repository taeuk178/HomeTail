//
//  Extension+UITableView.swift
//  HomeTail
//
//  Created by taeuk on 2021/06/06.
//

import UIKit

extension UITableView {
    
    func registerCell<T: UITableViewCell>(_: T.Type) {
        register(T.self, forCellReuseIdentifier: T.reuseIdentifier)
    }
    
    func dequeueTableCell<T: UITableViewCell>(for indexPath: IndexPath) -> T {
        guard let cell: T = dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as? T else { fatalError("Generic UITableViewCell is Error") }
        
        return cell
    }
}

extension UITableViewCell: ReusableCell {}
