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
    
    // 스크롤 뷰
    private let scrollView: UIScrollView = {
        $0.showsHorizontalScrollIndicator = false
        $0.showsVerticalScrollIndicator = false
        $0.backgroundColor = .white
        $0.isScrollEnabled = true
        return $0
    }(UIScrollView())
    
    // 레시피 뷰
    private let recipeView: UIView = {
        $0.backgroundColor = .white
        return $0
    }(UIView())
    
    // 뒤로가기 버튼
    private let dismissButton: UIButton = {
        $0.setImage(UIImage(named: "back"), for: .normal)
        return $0
    }(UIButton())
    
    // 라벨스택뷰, 출처, 텍스트뷰
    private lazy var recipeStackView: UIStackView = {
        $0.addArrangedSubview(labelStackView)
        $0.addArrangedSubview(resourceLabel)
        $0.addArrangedSubview(descriptionTextView)
        $0.alignment = .fill
        $0.distribution = .fill
        $0.axis = .vertical
        $0.spacing = 10
        return $0
    }(UIStackView())
    
    // 칵테일 이름라벨, 영어이름 라벨
    private lazy var labelStackView: UIStackView = {
        $0.addArrangedSubview(cockNameLabel)
        $0.addArrangedSubview(cockSubnameLabel)
        $0.alignment = .fill
        $0.distribution = .fillProportionally
        $0.axis = .vertical
        $0.spacing = 3
        return $0
    }(UIStackView())
    
    // 칵테일 인포그래픽이미지
    let infoGraphicImage: UIImageView = {
//        $0.image = UIImage(named: "exImage") // png
//        $0.image = UIImage(named: "InfoImage") // png
        $0.image = UIImage(named: "MojitoRecipe") // png
        $0.contentMode = .scaleAspectFit
        $0.backgroundColor = .white
        return $0
    }(UIImageView())
    
    // 한글이름
    private let cockNameLabel: UILabel = {
        $0.textAlignment = .left
        $0.font = .appSansFont(.sansHWRegular, size: 20)
        return $0
    }(UILabel())
    
    // 영어이름
    private let cockSubnameLabel: UILabel = {
        $0.textAlignment = .left
        $0.textColor = .lightGray
        $0.font = .apphelveticaFont(.helveticaLight, size: 14)
        return $0
    }(UILabel())
    
    // 출처
    private let resourceLabel: UILabel = {
        $0.textAlignment = .left
        $0.font = .appSansFont(.sansHWRegular, size: 12)
        return $0
    }(UILabel())
    
    // 설명
    private let descriptionTextView: UITextView = {
        $0.backgroundColor = .appMainColor(.subWhiteColor)
        $0.isEditable = false
        $0.isScrollEnabled = false
        $0.sizeToFit()
        $0.font = .appSansFont(.sansHWRegular, size: 16)
        $0.contentInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: -10)
        $0.setContentHuggingPriority(.defaultLow - 1, for: .horizontal)
        $0.setContentCompressionResistancePriority(.defaultHigh - 1, for: .vertical)
        return $0
    }(UITextView())
    
    // 도수
    private let alcoholLabel: UILabel = {
        $0.textColor = .customRGB(red: 40, green: 180, blue: 180, alpha: 1)
        $0.font = .apphelveticaFont(.helveticaLight, size: 18)
        $0.textAlignment = .center
        return $0
    }(UILabel())
    
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
        guard let cockRecipe = recipeViewModel.cockRecipe else { return }
        
        cockNameLabel.text = cockRecipe.name
        cockSubnameLabel.text = cockRecipe.subname
        resourceLabel.text = "출처: \(cockRecipe.source)"
        descriptionTextView.text = recipeViewModel.convertRecipe()
        alcoholLabel.text = "도수: \(cockRecipe.alcohol)%"
        
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
        
        view.backgroundColor = .white
        view.addSubview(scrollView)
        view.addSubview(dismissButton)
        scrollView.addSubview(recipeView)
        recipeView.addSubview(infoGraphicImage)
        recipeView.addSubview(recipeStackView)
        recipeView.addSubview(alcoholLabel)
        
        infoGraphicImage.frame = CGRect(x: 0, y: 0, width: recipeView.frame.size.width, height: recipeView.frame.size.height / 2)
    }
    
    override func setupConstraints() {
        
        // 스크롤뷰
        scrollView.snp.makeConstraints {
            $0.edges.equalTo(view)
        }
        
        // 레시피 뷰. on Scroll
        recipeView.snp.makeConstraints {
            $0.width.equalTo(scrollView)
            $0.edges.equalTo(scrollView)
            $0.height.equalTo(1000)
        }
        
        // 뒤로가기 버튼
        dismissButton.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            $0.leading.equalTo(view).offset(20)
            $0.width.equalTo(40)
        }
        
        // 칵테일 이미지
        infoGraphicImage.snp.makeConstraints {
            $0.top.equalTo(recipeView).offset(20)
            $0.leading.trailing.equalTo(recipeView)
            $0.height.equalTo(view.frame.size.height / 2)
        }
        
        // 칵테일 name, description 가진 스택뷰
        recipeStackView.snp.makeConstraints {
            $0.top.equalTo(infoGraphicImage.snp.bottom).offset(20)
            $0.leading.equalTo(recipeView).offset(20)
            $0.trailing.equalTo(recipeView).offset(-20)
        }
        
        // 도수
        alcoholLabel.snp.makeConstraints {
            $0.top.equalTo(recipeStackView.snp.bottom).offset(20)
            $0.centerX.equalTo(view)
            $0.width.greaterThanOrEqualTo(50)
            $0.height.equalTo(30)
            $0.bottom.lessThanOrEqualTo(recipeView).offset(-20)
        }
    }
}
