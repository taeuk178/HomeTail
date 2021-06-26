//
//  RecipeViewController.swift
//  HomeTail
//
//  Created by taeuk on 2021/06/26.
//

import UIKit
import SnapKit

class RecipeViewController: BaseViewController {

    // MARK: - Properties
    
    private let scrollView: UIScrollView = create {
        $0.showsHorizontalScrollIndicator = false
        $0.showsVerticalScrollIndicator = false
        $0.backgroundColor = .darkGray
        $0.isScrollEnabled = true
    }
    
    private let recipeView: UIView = create {
        $0.backgroundColor = .white
    }
    
    private lazy var recipeStackView: UIStackView = create {
        $0.addArrangedSubview(infoGraphicImage)
        $0.addArrangedSubview(cockNameLabel)
        $0.addArrangedSubview(cockSubLabel)
        $0.addArrangedSubview(resourceLabel)
        $0.addArrangedSubview(descriptionTextView)
        $0.alignment = .fill
        $0.distribution = .fill
        $0.axis = .vertical
        $0.spacing = 10
    }
    
    private let infoGraphicImage: UIImageView = create {
        $0.contentMode = .scaleAspectFit
        $0.backgroundColor = .systemIndigo
    }
    
    private let cockNameLabel: UILabel = create {
        $0.textAlignment = .left
        $0.font = .systemFont(ofSize: 20)
        $0.text = "스크류 드라이버"
    }
    
    private let cockSubLabel: UILabel = create {
        $0.textAlignment = .left
        $0.textColor = .lightGray
        $0.font = .systemFont(ofSize: 12)
        $0.text = "Screw Driver"
    }
    
    private let resourceLabel: UILabel = create {
        $0.textAlignment = .left
        $0.font = .systemFont(ofSize: 14)
        $0.text = "출처: IBA"
    }
    
    private let descriptionTextView: UITextView = create {
        $0.isEditable = false
        $0.isScrollEnabled = false
        $0.font = .systemFont(ofSize: 16)
        $0.contentInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        $0.text = "1. asd\n2. fds\n3. 123"
    }
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
}

// MARK: - UI

extension RecipeViewController {
    
    override func setupConfiguration() {
        
        view.addSubview(scrollView)
        scrollView.addSubview(recipeView)
        recipeView.addSubview(recipeStackView)
    }
    
    override func setupConstraints() {
        
        scrollView.snp.makeConstraints {
            $0.edges.equalTo(view)
        }
        
        recipeView.snp.makeConstraints {
            $0.width.equalTo(scrollView)
            $0.edges.equalTo(scrollView)
        }
        
        recipeStackView.snp.makeConstraints {
            $0.edges.equalTo(recipeView)
            $0.height.equalTo(1000)
        }
    }
}
