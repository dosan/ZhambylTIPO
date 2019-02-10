//
//  GradeCollectionViewCell.swift
//  ZhambylTIPO
//
//  Created by Yerbol on 2/5/19.
//  Copyright © 2019 Yerbol. All rights reserved.
//

import UIKit
import EasyPeasy

class GradeCollectionViewCell: UICollectionViewCell {
  
  var grade: Grade? {
    didSet {
      guard let grade = grade else { return }
      gradeLabel.text = grade.getGradeDescription()
      gradeLabel.textColor = .white
      gradeLabel.layer.borderWidth = 0
      let moduleGrade = grade.getGradeByModuleType()
      switch moduleGrade {
      case 5:
        gradeLabel.backgroundColor = GradesColor.five
      case 4:
        gradeLabel.backgroundColor = GradesColor.four
      case 3:
        gradeLabel.backgroundColor = GradesColor.three
      case 2:
        gradeLabel.backgroundColor = GradesColor.two
      case 1:
        gradeLabel.backgroundColor = GradesColor.one
      default:
        gradeLabel.layer.borderWidth = 1
        gradeLabel.layer.borderColor = GradesColor.five.cgColor
        gradeLabel.backgroundColor = .white
        gradeLabel.textColor = GradesColor.five
        gradeLabel.text = "У"
      }
    }
  }
  
  lazy var gradeLabel: UILabel = {
    let gradeLabel = UILabel()
    gradeLabel.layer.cornerRadius = 0.5 * self.frame.width
    gradeLabel.clipsToBounds = true
    gradeLabel.textAlignment = .center
    return gradeLabel
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    contentView.addSubview(gradeLabel)
    gradeLabel.easy.layout(Edges(0))
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
}
}
