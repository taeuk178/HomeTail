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
    
    let customview = UIView()
    var customViewModel: HomeViewModel?
    var button = UIButton()
    
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
        
        collectionView.frame = CGRect(x: 0, y: customview.frame.size.height / 3,
                                      width: customview.frame.size.width,
                                      height: customview.frame.size.height / 2)

        customview.addSubview(collectionView)
        customview.backgroundColor = .white
        collectionView.backgroundColor = .brown
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(customview).offset(30)
            $0.leading.trailing.bottom.equalTo(customview)
        }
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.registerCell(HomeSelectCell.self)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        cell.backgroundColor = .white
        
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
        
    }
    
}
