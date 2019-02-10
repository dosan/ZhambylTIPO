//
//  Discipline.swift
//  ZhambylTIPO
//
//  Created by Yerbol on 1/28/19.
//  Copyright © 2019 Yerbol. All rights reserved.
//

import Foundation
import ObjectMapper

struct Discipline {
  
  var id: Int?
  var hours: Int?
  var title_kz: String?
  var title_ru: String?
  var created_at: String?
  var updated_at: String?
  var grades = [Grade]()
  
  init?(map: Map) {
  }
  
  func getID() -> String {
    if let id = self.id {
      return "\(id)"
    }
    return ""
  }
  
  func getTitle() -> String {
    if let title_kz = self.title_kz {
      return title_kz
    }
    if let title_ru = self.title_ru {
      return title_ru
    }
    return ""
  }
  
}

extension Discipline: Mappable {
  mutating func mapping(map: Map) {
    id <- map["id"]
    hours <- map["hours"]
    title_kz <- map["title_kz"]
    title_ru <- map["title_ru"]
    created_at <- map["created_at"]
    updated_at <- map["updated_at"]
    
  }
}

extension Discipline {
  
  mutating func addGrades(grades: [Grade]){
    grades.forEach {
      if $0.getDisciplineID() == self.getID() {
        self.grades.append($0)
      }
    }
  }
  
  func getExercisesCount() -> Int {
    return grades.count
  }
  
  func getGradesCount() -> Int {
    var count = 0
    grades.forEach {
        if $0.getGrade() > 0 {
          count += 1
        }
      }
    return count
  }
  
  func getGradesAverage() -> Int {
    var sum = 0
    grades.forEach {
        sum += $0.getGrade()
      }
    let gradesCount = self.getGradesCount()
    if gradesCount > 0 {
      return Int(round(Double(sum/gradesCount)))
    }
    return 0
  }
  
  func getGrades() -> [Grade] {
    return self.grades
  }
  
}



