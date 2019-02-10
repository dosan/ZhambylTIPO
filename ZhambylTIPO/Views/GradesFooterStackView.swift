//
//  GradesFooterStackView
//  ZhambylTIPO
//
//  Created by Yerbol on 1/30/19.
//  Copyright © 2019 Yerbol. All rights reserved.
//

import UIKit
import EasyPeasy

class GradesFooterStackView: UIStackView {
  
  lazy var textField: UITextField = {
    let textField = UITextField()
    textField.text = "ВЫБРАТЬ ПРЕДМЕТ"
    textField.layer.borderWidth = 1
    textField.layer.borderColor = UIColor.black.cgColor
    textField.textAlignment = .center
    textField.textColor = .white
    textField.tintColor = .clear
    return textField
  }()
  
  lazy var updatedDateLabel: UILabel = {
    let updatedDateLabel = UILabel()
    updatedDateLabel.textColor = UIColor.white
    updatedDateLabel.text = ""
    updatedDateLabel.textAlignment = .right
    return updatedDateLabel
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    alignment = .fill
    axis = .vertical
    spacing = 10
    textField.easy.layout(Height(50.heightProportion()))
    addArrangedSubview(textField)
    addArrangedSubview(updatedDateLabel)
  }
  
  required init(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  
}

