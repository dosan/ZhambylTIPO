//
//  GradesSubTitleView.swift
//  ZhambylTIPO
//
//  Created by Yerbol on 1/31/19.
//  Copyright © 2019 Yerbol. All rights reserved.
//

import UIKit
import EasyPeasy

class GradesViewSubTitleView: UIView {
  
  lazy var titleLabel: UILabel = {
    let titleLabel = UILabel()
    titleLabel.font = UIFont(name: Font.regular, size: 30)
    titleLabel.textAlignment = .center
    titleLabel.adjustsFontSizeToFitWidth = true
    return titleLabel
  }()
  
  lazy var detailLabel: UILabel = {
    let detailLabel = UILabel()
    detailLabel.font = UIFont(name: Font.regular, size: 15)
    detailLabel.textAlignment = .center
    detailLabel.adjustsFontSizeToFitWidth = true
    return detailLabel
  }()

  override init(frame: CGRect) {
    super.init(frame: frame)
    self.addSubview(titleLabel)
    self.addSubview(detailLabel)
    titleLabel.easy.layout(Top(0),
                           Left(0),
                           Right(0))
    detailLabel.easy.layout(Top(0).to(titleLabel),
                            Left(0),
                            Right(0))
  }
  
  required init(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
