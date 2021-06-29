//
//  HomeSelectViewController.swift
//  HomeTail
//
//  Created by taeuk on 2021/06/13.
//

/*
 
 addChild시 생명주기
 BaseViewController override 메소드 -> viewdidLoad -> didMove
 
 */

import UIKit
import SnapKit

class HomeBottomViewController: BaseViewController {

    // MARK: - Properties
    
    var customViewModel: HomeViewModel?
    
    lazy var collectionView: UICollectionView = {
        let rect = CGRect(x: 0, y: 0,
                          width: view.frame.size.width,
                          height: view.frame.size.height)

        let flowlayout = UICollectionViewFlowLayout()
        flowlayout.scrollDirection = .vertical
        flowlayout.itemSize = CGSize(width: 60, height: 60)
        flowlayout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        let collection = UICollectionView(frame: rect, collectionViewLayout: flowlayout)
        collection.showsVerticalScrollIndicator = false
        collection.showsHorizontalScrollIndicator = false
        return collection
    }()
    
    // MARK: - LifeCycle
    
    override func didMove(toParent parent: UIViewController?) {
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource

/*
 
 */
extension HomeBottomViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.size.width, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header: HomeBottomReusableView = collectionView.dequeueCollectionHeader(for: indexPath)
        
        header.setConfigure()
        switch customViewModel?.connectCase.value {
        case .taste:
            header.headerLabelText(SelectedCases.taste.texture)
        case .base:
            header.headerLabelText(SelectedCases.base.texture)
        case .alcohol:
            header.headerLabelText(SelectedCases.alcohol.texture)
        case .none:
            return header
        }
        
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch customViewModel?.connectCase.value {
        case .taste:
            return SelectedCases.taste.allCount
        case .base:
            return SelectedCases.base.allCount
        case .alcohol:
            return SelectedCases.alcohol.allCount
        case .none:
            return 0
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: HomeBottomCell = collectionView.dequeueCollectionCell(for: indexPath)
        
        switch customViewModel?.connectCase.value {
        case .taste:
            cell.setUpText(SelectedCases.taste.rawValues[indexPath.row])
        case .base:
            cell.setUpText(SelectedCases.base.rawValues[indexPath.row])
        case .alcohol:
            cell.setUpText(SelectedCases.alcohol.rawValues[indexPath.row])
        case .none:
            return cell
        }
        
        cell.backgroundColor = .orange
        cell.layer.cornerRadius = 15 // 고민중 cell.frame.size.height / 2
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        customViewModel?.connectCase.value = .alcohol
        collectionView.reloadData()
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension HomeBottomViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        switch customViewModel?.connectCase.value {
        case .taste:
            return UIEdgeInsets(top: 10, left: 50, bottom: 10, right: 50)
        case .base:
            return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        case .alcohol:
            return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        default:
            return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 100, height: 100)
    }
}

// MARK: - UI

extension HomeBottomViewController {
    
    override func setupConfiguration() {
        
        view.backgroundColor = .white
        view.addSubview(collectionView)
        
        collectionView.backgroundColor = .white
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.registerCell(HomeBottomCell.self)
        collectionView.registerHeader(HomeBottomReusableView.self)
        
    }
    
    override func setupProperties() {
        
    }
    
    override func setupConstraints() {
        
        collectionView.snp.makeConstraints {
            $0.edges.equalTo(view)
        }
    }
    
}
