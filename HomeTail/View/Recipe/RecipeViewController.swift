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
    
    // 라벨스택뷰, 출처, 텍스트뷰
    private lazy var recipeStackView: UIStackView = create {
        $0.addArrangedSubview(labelStackView)
        $0.addArrangedSubview(resourceLabel)
        $0.addArrangedSubview(descriptionTextView)
        $0.alignment = .fill
        $0.distribution = .fill
        $0.axis = .vertical
        $0.spacing = 10
    }
    
    // 칵테일 이름라벨, 영어이름 라벨
    private lazy var labelStackView: UIStackView = create {
        $0.addArrangedSubview(cockNameLabel)
        $0.addArrangedSubview(cockSubnameLabel)
        $0.alignment = .fill
        $0.distribution = .fill
        $0.axis = .vertical
        $0.spacing = 3
    }
    
    // 칵테일 인포그래픽이미지
    private let infoGraphicImage: UIImageView = create {
        $0.contentMode = .scaleAspectFit
        $0.backgroundColor = .systemIndigo
    }
    
    private let cockNameLabel: UILabel = create {
        $0.textAlignment = .left
        $0.font = .systemFont(ofSize: 20)
        $0.text = "스크류 드라이버"
    }
    
    private let cockSubnameLabel: UILabel = create {
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
        $0.setContentHuggingPriority(.defaultLow - 1, for: .vertical)
    }
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    deinit {
        print("Recipe Deinit")
    }
}

// MARK: - UI

extension RecipeViewController {
    
    override func setupConfiguration() {
        
        view.addSubview(scrollView)
        scrollView.addSubview(recipeView)
        recipeView.addSubview(infoGraphicImage)
        recipeView.addSubview(recipeStackView)
        infoGraphicImage.frame = CGRect(x: 0, y: 0, width: recipeView.frame.size.width, height: recipeView.frame.size.height / 2)
    }
    
    override func setupConstraints() {
        
        scrollView.snp.makeConstraints {
            $0.edges.equalTo(view)
        }
        
        recipeView.snp.makeConstraints {
            $0.width.equalTo(scrollView)
            $0.edges.equalTo(scrollView)
            $0.height.equalTo(800)
        }
        
        infoGraphicImage.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(recipeView)
            $0.height.equalTo(view.frame.size.height / 2)
        }
        
        recipeStackView.snp.makeConstraints {
            $0.top.equalTo(infoGraphicImage.snp.bottom).offset(20)
            $0.leading.equalTo(recipeView).offset(20)
            $0.trailing.equalTo(recipeView).offset(-20)
            $0.bottom.equalTo(recipeView)
        }
    }
}
