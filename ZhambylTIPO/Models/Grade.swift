//
//  Grade.swift
//  ZhambylTIPO
//
//  Created by Yerbol on 1/28/19.
//  Copyright © 2019 Yerbol. All rights reserved.
//

import Foundation
import ObjectMapper

struct Grade {
  
  var id: Int?
  var date: String?
  var discipline_id: Int?
  var start_time: String?
  var end_time: String?
  var exercise: Int?
  var grade: Int?
  var grade_type: String?
  
  init?(map: Map) {
  }
  
  func getDisciplineID() -> String {
    if let id = self.discipline_id {
      return "\(id)"
    }
    return ""
  }
  
  func getGradeType() -> String {
    return self.grade_type ?? "module"
  }
  
  func getGrade() -> Int {
    return self.grade ?? 0
  }
  
  func getGradeByModuleType() -> Int {
    let grade = getGrade()
    if self.grade_type == "credit" {
      switch grade {
      case 80...100: return 5
      case 70..<80: return 4
      case 60..<70: return 3
      case 50..<60: return 2
      case 1..<50: return 1
      default: break }
    }
    return grade
  }
  
  func getGradeDescription() -> String {
    let grade = self.grade ?? 0
    var strGrade = "\(grade)"
    if self.grade_type == "credit" {
      switch grade {
      case 90...100: strGrade = "A+"
      case 85..<90: strGrade = "A"
      case 80..<80: strGrade = "A-"
      case 77..<80: strGrade = "B+"
      case 73..<77: strGrade = "B"
      case 70..<73: strGrade = "B-"
      case 67..<70: strGrade = "C+"
      case 63..<67: strGrade = "C"
      case 60..<63: strGrade = "C-"
      case 57..<60: strGrade = "D+"
      case 53..<57: strGrade = "D"
      case 50..<53: strGrade = "D-"
      case 1..<50: strGrade = "F"
      default: break }
    }
    return strGrade
  }
  
  
}

extension Grade: Mappable {
  mutating func mapping(map: Map) {
    id <- map["id"]
    date <- map["date"]
    discipline_id <- map["discipline_id"]
    start_time <- map["start_time"]
    end_time <- map["end_time"]
    exercise <- map["exercise"]
    grade <- map["grade"]
    grade_type <- map["grade_type"]
    
  }
}
