//
//  FilteringTableCell.swift
//  HomeTail
//
//  Created by taeuk on 2021/06/28.
//

import UIKit
import SnapKit

class FilteringTableCell: UITableViewCell {

    private let textureLabel: UILabel = create {
        $0.font = .appSansFont(.sansHWRegular, size: 17)
        $0.textAlignment = .left
    }
    
    var texlables: String?
    
    private let selecteImage: String = "stop.fill"
    private let nonSelectImage: String = "stop"
    
    var isSelectState: Bool = false {
        didSet {
            let symbolConfigure = UIImage.SymbolConfiguration(pointSize: 30, weight: .medium, scale: .default)
            let buttonSymbol = UIImage(systemName: isSelectState ? selecteImage : nonSelectImage, withConfiguration: symbolConfigure)
            checkBox.setImage(buttonSymbol, for: .normal)
        }
    }
    
    let checkBox: UIButton = create {
        $0.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        let symbolConfigure = UIImage.SymbolConfiguration(pointSize: 30, weight: .medium, scale: .default)
        let buttonSymbol = UIImage(systemName: "stop", withConfiguration: symbolConfigure)
        $0.setImage(buttonSymbol, for: .normal)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setConfigure()
        setConstraints()
        checkBox.addTarget(self, action: #selector(isCheckAction(_:)), for: .touchUpInside)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("FilteringTableCell is Error")
    }

    func textShow(_ text: String) {
        textureLabel.text = text
        texlables = text
    }
    
    func selectItems(_ item: SelectedItems) {
        guard let itemTaste = item.taste, let itemBase = item.base, let itemAlcohol = item.alcohol else { return }
        if texlables == itemTaste || texlables == itemBase || texlables == itemAlcohol {
            isSelectState = true
        } else {
            isSelectState = false
        }
    }
    
    @objc func isCheckAction(_ sender: UIButton) {
        if let texlabels = texlables {
            print(texlabels)
        }
    }
    
}

extension FilteringTableCell {
    
    func setConfigure() {
        
        contentView.addSubview(textureLabel)
        contentView.addSubview(checkBox)
    }
    
    func setConstraints() {
        
        textureLabel.snp.makeConstraints {
            $0.centerY.equalTo(contentView)
            $0.leading.equalTo(contentView).offset(20)
            $0.width.greaterThanOrEqualTo(80)
        }
        
        checkBox.snp.makeConstraints {
            $0.trailing.equalTo(contentView).offset(-20)
            $0.centerY.equalTo(contentView)
        }
    }
}
