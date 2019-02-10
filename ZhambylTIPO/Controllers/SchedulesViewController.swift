//
//  TasksViewController.swift
//  ZhambylTIPO
//
//  Created by Yerbol on 1/25/19.
//  Copyright © 2019 Yerbol. All rights reserved.
//

import UIKit
import EasyPeasy
import FSCalendar

class SchedulesViewController: UIViewController {
  
  var disciplines: [Discipline]!
  var schedules: [Schedule]!
  
  var selectedDaySchedules: [Schedule] = []
  var selectedDayExercisesCount: Int = 0
  
  lazy var calendar: FSCalendar = {
    let calendar = FSCalendar()
    calendar.delegate = self
    calendar.dataSource = self
    calendar.firstWeekday = 2
    calendar.appearance.headerDateFormat = "LLLL yyyy"
    calendar.locale = Locale(identifier: "ru_RU")
    calendar.scope = .week
    calendar.appearance.titleFont = UIFont(name: Font.regular, size: 18)
    calendar.appearance.headerTitleFont = UIFont(name: Font.regular, size: 20)
    calendar.appearance.weekdayFont = UIFont(name: Font.regular, size: 16)
    return calendar
  }()
  
  lazy var tableView: UITableView = {
    let tableView = UITableView()
    tableView.delegate = self
    tableView.dataSource = self
    tableView.register(DisciplineTableViewCell.self, forCellReuseIdentifier: "cell")
    return tableView
  }()
  
  fileprivate lazy var dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd"
    return formatter
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Месяц", style: .plain, target: self, action: #selector(toggleCalendar))
    navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Сегодня", style: .plain, target: self, action: #selector(selectToday))
    setupViews()
    setupConstraints()
    getDisciplines()
    getSchedule()
  }
  
  func getDisciplines() {
    let conn = APIConnection()
    conn.getDisciplines { disciplines, error in
      guard let disciplines = disciplines else {
        self.showToast(message: error!.getMessage())
        return
      }
      self.disciplines = disciplines
      self.showSchedule()
    }
  }
  
  func getSchedule() {
    let conn = APIConnection()
    conn.getSchedules { schedules, error in
      guard let schedules = schedules else {
        self.showToast(message: error!.getMessage())
        return
      }
      self.schedules = schedules
      self.showSchedule()
      self.calendar.reloadData()
    }
  }
  
  func getDisciplineByID(id: String) -> Discipline? {
    if let disciplines = self.disciplines {
      if let discipline = disciplines.first(where: {$0.getID() == id }) {
        return discipline
      }
    }
    return nil
  }
  
  @objc func selectToday() {
    calendar.select(Date())
    showSchedule()
  }
  
  @objc func toggleCalendar() {
    if calendar.scope == .month {
      navigationItem.rightBarButtonItem?.title = "Месяц"
      calendar.setScope(.week, animated: true)
    } else {
      navigationItem.rightBarButtonItem?.title = "Неделя"
      calendar.setScope(.month, animated: true)
    }
  }
  
  func showSchedule(selectedDate date: Date = Date()) {
    selectedDaySchedules = []
    selectedDayExercisesCount = 0
    let strDate = "\(dateFormatter.string(from: date))"
    navigationItem.title = strDate
    if let schedules = self.schedules {
      selectedDaySchedules = schedules.filter { $0.getDate() == strDate }
      selectedDayExercisesCount = selectedDaySchedules.max { $0.getExercise() < $1.getExercise() }?.getExercise() ?? 0
      self.tableView.reloadData()
    }
  }

  fileprivate func setupViews() {
    [calendar, tableView].forEach {
      self.view.addSubview($0)
    }
  }
  
  fileprivate func setupConstraints() {
    calendar.easy.layout(Top(0),
                         Left(0),
                         Right(0),
                         Height(270.heightProportion()))
    tableView.easy.layout(Top(30.heightProportion()
      ).to(calendar),
                          Left(0),
                          Right(0),
                          Bottom(0))
  }
  
}

extension SchedulesViewController: FSCalendarDelegate {
  func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
    showSchedule(selectedDate: date)
  }
  
  func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool) {
    calendar.easy.layout(Height(bounds.height))
    self.view.layoutIfNeeded()
  }
}

extension SchedulesViewController: FSCalendarDataSource {
  func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
    let strDate = "\(dateFormatter.string(from: date))"
    if let schedules = self.schedules {
      let dayExercises = schedules.filter { $0.getDate() == strDate }
      return dayExercises.count
    }
    return 0
  }
}

extension SchedulesViewController: UITableViewDataSource {
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return selectedDayExercisesCount
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! DisciplineTableViewCell
    
    let schedule = selectedDaySchedules.first(where: {$0.getExercise() == indexPath.section+1})
    
    if let schedule = schedule {
      cell.textLabel?.text =  getDisciplineByID(id: schedule.getDisciplineID())?.getTitle() ?? ""
      cell.detailTextLabel?.text = schedule.getType()
      cell.noDiscipline = false
    } else {
      cell.textLabel?.text = ""
      cell.detailTextLabel?.text = ""
      cell.noDiscipline = true
    }

    return cell
  }
}


extension SchedulesViewController: UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    var title = "\(section+1). -"
    if section < selectedDayExercisesCount {
      if let schedule = selectedDaySchedules.first(where: {$0.getExercise() == section+1}) {
        title = "\(schedule.getExercise()). " + schedule.getStartAndEndTime()
      }
    }
    return title
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
  }
  
}
