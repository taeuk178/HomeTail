//
//  HomeSelectViewController.swift
//  HomeTail
//
//  Created by taeuk on 2021/06/13.
//

import UIKit
import SnapKit

class HomeSelectViewController: BaseViewController {

    // MARK: - Properties
    
    var customViewModel: HomeViewModel?
    
    lazy var collectionView: UICollectionView = {
        let rect = CGRect(x: 0, y: 0,
                          width: view.frame.size.width,
                          height: view.frame.size.height)

        let flowlayout = UICollectionViewFlowLayout()
        flowlayout.scrollDirection = .horizontal
        flowlayout.itemSize = CGSize(width: 60, height: 60)
        flowlayout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        let collection = UICollectionView(frame: rect, collectionViewLayout: flowlayout)
        
        return collection
    }()
    
    // MARK: - LifeCycle
    
    override func didMove(toParent parent: UIViewController?) {
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("A")
    }
    
}

// MARK: - CollectionView

extension HomeSelectViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: HomeSelectCell = collectionView.dequeueCollectionCell(for: indexPath)
        
        cell.setUpText("1")
        cell.backgroundColor = .orange
        
        return cell
    }
}

extension HomeSelectViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 60, height: 60)
    }
}
// MARK: - UI

extension HomeSelectViewController {
    
    override func setupConfiguration() {
        
        view.backgroundColor = .white
        view.addSubview(collectionView)
        
        collectionView.backgroundColor = .white
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.registerCell(HomeSelectCell.self)
    }
    
    override func setupConstraints() {
        
        collectionView.snp.makeConstraints {
            $0.edges.equalTo(view)
        }
    }
    
}
