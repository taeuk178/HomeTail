//
//  Extension+UICollectionView.swift
//  HomeTail
//
//  Created by taeuk on 2021/06/06.
//

import UIKit

extension UICollectionView {
    
    // CollectionViewCell
    func registerCell<T: UICollectionViewCell>(_: T.Type) {
        register(T.self, forCellWithReuseIdentifier: T.reuseIdentifier)
    }
    
    // CollectionViewHeader
    func registerHeader<T: UICollectionReusableView>(_: T.Type) {
        register(T.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: T.reuseIdentifier)
    }
    
    // CollectionViewCell
    func dequeueCollectionCell<T: UICollectionViewCell>(for indexPath: IndexPath) -> T {
        guard let cell: T = dequeueReusableCell(withReuseIdentifier: T.reuseIdentifier, for: indexPath) as? T else { fatalError("\(Date()): Generic UICollectionHeader is Error") }
        
        return cell
    }
    
    // CollectionViewHeader
    func dequeueCollectionHeader<T: UICollectionReusableView>(for indexPath: IndexPath) -> T {
        guard let header: T = dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: T.reuseIdentifier, for: indexPath) as? T else { fatalError("\(Date()): Generic UICollectionHeader is Error")}
        
        return header
    }
}

extension UICollectionViewCell: ReusableCell {}
extension UICollectionReusableView: ReusableCell {}
