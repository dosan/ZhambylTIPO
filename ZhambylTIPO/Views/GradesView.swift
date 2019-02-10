//
//  DisciplineGradesView.swift
//  ZhambylTIPO
//
//  Created by Yerbol on 2/5/19.
//  Copyright © 2019 Yerbol. All rights reserved.
//

import UIKit
import EasyPeasy

class GradesView: UIView {
  
  var grades: [Grade]? {
    didSet {
      guard let _ = grades else { return }
      collectionView.reloadData()
    }
  }
  
  var discipline: Discipline? {
    didSet {
      guard let discipline = discipline else { return }
      self.grades = discipline.getGrades()
      self.disciplineLabel.text = discipline.getTitle()
      self.subtitlesStackView.averageGradeView.titleLabel.text = "\(discipline.getGradesAverage())"
      self.subtitlesStackView.exercisesCountView.titleLabel.text = "\(discipline.getExercisesCount())"
      self.subtitlesStackView.gradesCountView.titleLabel.text = "\(discipline.getGradesCount())"
    }
  }

  lazy var disciplineLabel: UILabel = {
    let disciplineLabel = UILabel()
    disciplineLabel.textAlignment = .center
    disciplineLabel.font = UIFont(name: Font.bold, size: 22)
    disciplineLabel.adjustsFontSizeToFitWidth = true
    return disciplineLabel
  }()
  
  lazy var mainView: UIView = {
    let mainView = UIView()
    mainView.backgroundColor = UIColor.white
    mainView.layer.cornerRadius = 5
    mainView.layer.shadowOpacity = 0.35
    mainView.layer.shadowOffset = CGSize(width: 0, height: 0)
    mainView.layer.shadowColor = UIColor.gray.cgColor
    mainView.translatesAutoresizingMaskIntoConstraints = false
    return mainView
  }()
  
  lazy var subtitlesStackView: SubtitlesStackView = {
    let subtitlesStackView = SubtitlesStackView()
    return subtitlesStackView
  }()
  
  let layout: UICollectionViewFlowLayout = {
    let layout = UICollectionViewFlowLayout()
    layout.itemSize = CGSize(width: 35.widthProportion(), height: 35.widthProportion())
    layout.minimumLineSpacing = 5
    return layout
  }()
  
  lazy var collectionView: UICollectionView = {
    let collectionView =  UICollectionView(frame: .zero, collectionViewLayout: layout)
    collectionView.showsVerticalScrollIndicator = false
    collectionView.showsHorizontalScrollIndicator = false
    collectionView.register(GradeCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: GradeCollectionViewCell.self))
    collectionView.backgroundColor = .clear
    collectionView.dataSource = self
    return collectionView
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    backgroundColor = .white
    setupViews()
    setupConstraints()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setupViews(){
    addSubview(mainView)
    [disciplineLabel, subtitlesStackView, collectionView].forEach {
      mainView.addSubview($0)
    }
  }
  
  private func setupConstraints() {
    mainView.easy.layout(Edges(30.widthProportion()))
    disciplineLabel.easy.layout(Top(10),
                                Left(0),
                                Right(0))
    subtitlesStackView.easy.layout(Top(10.heightProportion()).to(disciplineLabel),
                                   CenterX(0),
                                   Height(90.heightProportion()))
    collectionView.easy.layout(Top(10.heightProportion()).to(subtitlesStackView),
                               Left(20.widthProportion()),
                               Right(20.widthProportion()),
                               Bottom(0))
}
}

extension GradesView: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return grades?.count ?? 0
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: GradeCollectionViewCell.self), for: indexPath) as! GradeCollectionViewCell
    if let grades = self.grades {
      cell.grade = grades[indexPath.row]
    }
    return cell
  }

}
