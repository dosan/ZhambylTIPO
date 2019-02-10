//
//  GradesViewController.swift
//  ZhambylTIPO
//
//  Created by Yerbol on 1/25/19.
//  Copyright © 2019 Yerbol. All rights reserved.
//

import UIKit
import EasyPeasy

class GradesViewController: UIViewController {
  
  var grades: [Grade]!
  var disciplines: [Discipline]!
  
  lazy var gradesView = GradesView()
  
  lazy var footerView = GradesFooterStackView()
  
  lazy var stackView: UIStackView = {
    let stackView = UIStackView()
    stackView.axis = .vertical
    stackView.addArrangedSubview(gradesView)
    stackView.addArrangedSubview(footerView)
    stackView.translatesAutoresizingMaskIntoConstraints = false
    return stackView
  }()
  
  lazy var pickerView: UIPickerView = {
    let pickerView = UIPickerView()
    pickerView.dataSource = self
    pickerView.delegate = self
    return pickerView
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    title = "Оценки"
    view.backgroundColor = Color.blue
    view.addSubview(stackView)
    stackView.easy.layout(Edges(0))
    createPicker()
    getDisciplines()
    getGrades()
  }
  
  func getDisciplines() {
    let conn = APIConnection()
    conn.getDisciplines { disciplines, error in
      guard let disciplines = disciplines else {
        self.showToast(message: error!.getMessage())
        return
      }
      self.disciplines = disciplines
      self.setData(discipline: disciplines[0])
    }
  }
  
  func getGrades() {
    let conn = APIConnection()
    conn.getGrades { result, error in
      guard let grades = result else {
        self.showToast(message: error!.getMessage())
        return
      }
      self.grades = grades
      if let disciplines = self.disciplines {
        self.setData(discipline: disciplines[0])
      }
    }
  }
  
  func setData(discipline: Discipline?) {
    guard let grades = self.grades else {
      return
    }
    if var discipline = discipline {
      discipline.addGrades(grades: grades)
      gradesView.discipline = discipline
    }
  }

  
  func createPicker( ) {
    let doneButton = UIBarButtonItem(title: "Выбрать", style: .plain, target: self, action: #selector(selectDiscipline))
    let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
    let cancelButton = UIBarButtonItem(title: "Отмена", style: .plain, target: self, action: #selector(cancelPicker))
    
    let toolBar = UIToolbar()
    toolBar.sizeToFit()
    toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
    toolBar.isUserInteractionEnabled = true
    
    footerView.textField.inputView = pickerView
    footerView.textField.inputAccessoryView = toolBar
  }
  
  @objc func selectDiscipline() {
    if let disciplines = self.disciplines {
      setData(discipline: disciplines[pickerView.selectedRow(inComponent: 0)])
    }
    cancelPicker()
  }
  
  @objc func cancelPicker() {
    footerView.textField.resignFirstResponder()
  }
  
}


extension GradesViewController: UIPickerViewDataSource {
  func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return 1
  }
  
  func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    if let disciplines = self.disciplines {
      return disciplines.count
    }
    return 0
  }
}

extension GradesViewController: UIPickerViewDelegate {
  func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    if let disciplines = self.disciplines {
      return disciplines[row].getTitle()
    }
    return ""
  }
}
