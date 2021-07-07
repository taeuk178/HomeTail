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
    
    private let dismissButton: UIButton = create {
        $0.setImage(UIImage(named: "back"), for: .normal)
    }
    
    private let scrollView: UIScrollView = create {
        $0.showsHorizontalScrollIndicator = false
        $0.showsVerticalScrollIndicator = false
        $0.backgroundColor = .white
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
        $0.distribution = .fillProportionally
        $0.axis = .vertical
        $0.spacing = 3
    }
    
    // 칵테일 인포그래픽이미지
    let infoGraphicImage: UIImageView = create {
        $0.image = UIImage(named: "exImage") // png
//        $0.image = UIImage(named: "InfoImage") // jpg
        $0.contentMode = .scaleAspectFit
        $0.backgroundColor = .white
    }
    
    private let cockNameLabel: UILabel = create {
        $0.textAlignment = .left
        $0.font = .appSansFont(.sansHWRegular, size: 20)
    }
    
    private let cockSubnameLabel: UILabel = create {
        $0.textAlignment = .left
        $0.textColor = .lightGray
        $0.font = .apphelveticaFont(.helveticaLight, size: 14)
    }
    
    private let resourceLabel: UILabel = create {
        $0.textAlignment = .left
        $0.font = .appSansFont(.sansHWRegular, size: 12)
    }
    
    private let descriptionTextView: UITextView = create {
        $0.backgroundColor = .appMainColor(.subWhiteColor)
        $0.isEditable = false
        $0.isScrollEnabled = false
        $0.sizeToFit()
        $0.font = .appSansFont(.sansHWRegular, size: 16)
        $0.contentInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: -10)
        $0.setContentHuggingPriority(.defaultLow - 1, for: .horizontal)
        $0.setContentCompressionResistancePriority(.defaultHigh - 1, for: .vertical)
    }
    
    private let alcoholLabel: UILabel = create {
        $0.textColor = .customRGB(red: 40, green: 180, blue: 180, alpha: 1)
        $0.font = .apphelveticaFont(.helveticaLight, size: 18)
        $0.textAlignment = .center
    }
    
    let recipeViewModel = RecipeViewModel()
    
    var cockTailListIndex = 0
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        recipeViewModel.showList()
        setRecipe()
        
        dismissButton.addTarget(self, action: #selector(dismissAction(_:)), for: .touchUpInside)
    }
    
    func setRecipe() {
        cockNameLabel.text = recipeViewModel.cockRecipe?.name
        cockSubnameLabel.text = recipeViewModel.cockRecipe?.subname
        resourceLabel.text = "출처: \(recipeViewModel.cockRecipe?.source ?? "")"
        descriptionTextView.text = recipeViewModel.cockRecipe?.explain
        alcoholLabel.text = "도수: \(recipeViewModel.cockRecipe?.alcohol ?? "")%"
    }
    
    @objc func dismissAction(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
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
        recipeView.addSubview(dismissButton)
        recipeView.addSubview(infoGraphicImage)
        recipeView.addSubview(recipeStackView)
        recipeView.addSubview(alcoholLabel)
        infoGraphicImage.frame = CGRect(x: 0, y: 0, width: recipeView.frame.size.width, height: recipeView.frame.size.height / 2)
    }
    
    override func setupConstraints() {
        
        scrollView.snp.makeConstraints {
            $0.edges.equalTo(view)
        }
        
        recipeView.snp.makeConstraints {
            $0.width.equalTo(scrollView)
            $0.edges.equalTo(scrollView)
            $0.height.equalTo(1000)
        }
        
        dismissButton.snp.makeConstraints {
            $0.top.equalTo(recipeView.safeAreaLayoutGuide).offset(20)
            $0.leading.equalTo(recipeView).offset(20)
            $0.width.equalTo(40)
        }
        
        infoGraphicImage.snp.makeConstraints {
            $0.top.equalTo(dismissButton.snp.bottom).offset(20)
            $0.leading.trailing.equalTo(recipeView)
            $0.height.equalTo(view.frame.size.height / 2)
        }
        
        recipeStackView.snp.makeConstraints {
            $0.top.equalTo(infoGraphicImage.snp.bottom).offset(20)
            $0.leading.equalTo(recipeView).offset(20)
            $0.trailing.equalTo(recipeView).offset(-20)
        }
        
        alcoholLabel.snp.makeConstraints {
            $0.top.equalTo(recipeStackView.snp.bottom).offset(20)
            $0.centerX.equalTo(view)
            $0.width.greaterThanOrEqualTo(50)
            $0.height.equalTo(30)
            $0.bottom.lessThanOrEqualTo(recipeView).offset(-20)
        }
    }
}
