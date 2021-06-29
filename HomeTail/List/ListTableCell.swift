//
//  ListTableCell.swift
//  HomeTail
//
//  Created by taeuk on 2021/06/26.
//

import UIKit
import SnapKit

class ListTableCell: UITableViewCell {

    // MARK: - Properties
    
    private let infoGraphicImage: UIImageView = create {
        $0.contentMode = .scaleAspectFit
        $0.backgroundColor = .blue
    }
    
    private let nameLabel: UILabel = create {
        $0.textAlignment = .left
//        $0.font = .systemFont(ofSize: 16)
        $0.font = .appSansFont(.sansHWRegular, size: 16)
    }
    
    private let subNameLabel: UILabel = create {
        $0.textAlignment = .left
        $0.font = .apphelveticaFont(.helveticaMedium, size: 12)
    }
    
    private let labelStack: UIStackView = create {
        $0.alignment = .fill
        $0.distribution = .fill
        $0.axis = .vertical
        $0.spacing = 3
    }
    
    // MARK: - LifeCycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setConfigure()
        setConstraints()
        
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpCell(mainString name: String, subString sub: String) {
        nameLabel.text = name
        subNameLabel.text = sub
    }
}

extension ListTableCell {
    
    func setConfigure() {

        contentView.layer.cornerRadius = 15
//        contentView.backgroundColor = .appMainColor(.subWhiteColor)
        contentView.backgroundColor = .white
        
        backgroundColor = .appMainColor(.subSkyBlueColor)
        infoGraphicImage.layer.cornerRadius = 8
        
        labelStack.addArrangedSubview(nameLabel)
        labelStack.addArrangedSubview(subNameLabel)
        
        contentView.addSubview(infoGraphicImage)
        contentView.addSubview(labelStack)

    }
    
    func setConstraints() {
        
        infoGraphicImage.snp.makeConstraints {
            $0.top.equalTo(contentView).offset(10)
            $0.bottom.equalTo(contentView).offset(-10)
            $0.leading.equalTo(contentView).offset(10)
            $0.width.equalTo(80)
        }
        
        labelStack.snp.makeConstraints {
            $0.leading.equalTo(infoGraphicImage.snp.trailing).offset(10)
            $0.centerY.equalTo(contentView)
            $0.width.greaterThanOrEqualTo(100)
        }
    }
}
