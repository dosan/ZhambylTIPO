//
//  SubtitlesStackView.swift
//  ZhambylTIPO
//
//  Created by Yerbol on 1/31/19.
//  Copyright © 2019 Yerbol. All rights reserved.
//

import UIKit

class SubtitlesStackView: UIStackView {

  lazy var exercisesCountView: GradesViewSubTitleView = {
    let exercisedCountView = GradesViewSubTitleView()
    exercisedCountView.detailLabel.text = "Занятий"
    return exercisedCountView
  }()
  
  lazy var gradesCountView: GradesViewSubTitleView = {
    let gradesCountView = GradesViewSubTitleView()
    gradesCountView.detailLabel.text = "Оценок"
    return gradesCountView
  }()
  
  lazy var averageGradeView: GradesViewSubTitleView = {
    let averageGradeView = GradesViewSubTitleView()
    averageGradeView.detailLabel.text = "Ср.балл"
    return averageGradeView
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    alignment = .fill
    spacing = 30
    addArrangedSubview(exercisesCountView)
    addArrangedSubview(gradesCountView)
    addArrangedSubview(averageGradeView)
  }
  
  required init(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}
