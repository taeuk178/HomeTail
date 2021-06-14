//
//  Extension+UICollectionView.swift
//  HomeTail
//
//  Created by taeuk on 2021/06/06.
//

import UIKit

extension UICollectionView {
    
    func registerCell<T: UICollectionViewCell>(_: T.Type) {
        register(T.self, forCellWithReuseIdentifier: T.reuseIdentifier)
    }
    
    func dequeueCollectionCell<T: UICollectionViewCell>(for indexPath: IndexPath) -> T {
        guard let cell: T = dequeueReusableCell(withReuseIdentifier: T.reuseIdentifier, for: indexPath) as? T else { fatalError("Generic UITableViewCell is Error") }
        
        return cell
    }
}

extension UICollectionViewCell: ReusableCell {}
