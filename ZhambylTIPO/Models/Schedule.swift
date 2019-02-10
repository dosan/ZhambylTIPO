//
//  Schedule.swift
//  ZhambylTIPO
//
//  Created by Yerbol on 1/28/19.
//  Copyright © 2019 Yerbol. All rights reserved.
//

import Foundation
import ObjectMapper

struct Schedule {
  
  var id: Int?
  var date: String?
  var discipline_id: Int?
  var start_time: String?
  var end_time: String?
  var semester_week: Int?
  var week_day: Int?
  var exercise: Int?
  var teacher_id: Int?
  var type: String?
  var created_at: String?
  var updated_at: String?
  var discipline: Discipline?
  
  init?(map: Map) {
  }
  
  func getDisciplineID() -> String {
    if let id = self.discipline_id {
      return "\(id)"
    }
    return ""
  }
  
  func getDate() -> String {
    return self.date ?? ""
  }
  
  func getExercise() -> Int {
    return self.exercise ?? 0
  }
  
  func getStartTime() -> String {
    if let start_time = self.start_time {
      return start_time.subString(startIndex: 0, endIndex: 4)
    }
    return ":"
  }
  
  func getEndTime() -> String {
    if let end_time = self.end_time {
      return end_time.subString(startIndex: 0, endIndex: 4)
    }
    return ":"
  }
  
  func getStartAndEndTime() -> String {
    return "\(self.getStartTime()) - \(self.getEndTime())"
  }
  
  func getType() -> String {
    return self.type ?? ""
  }
  
}

extension Schedule: Mappable {
  mutating func mapping(map: Map) {
    id <- map["id"]
    date <- map["date"]
    discipline_id <- map["discipline_id"]
    start_time <- map["start_time"]
    end_time <- map["end_time"]
    semester_week <- map["semester_week"]
    week_day <- map["week_day"]
    exercise <- map["exercise"]
    teacher_id <- map["teacher_id"]
    type <- map["type"]
    created_at <- map["created_at"]
    updated_at <- map["updated_at"]
    
  }
}

