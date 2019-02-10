//
//  User.swift
//  ZhambylTIPO
//
//  Created by Yerbol on 1/28/19.
//  Copyright © 2019 Yerbol. All rights reserved.
//

import Foundation
import ObjectMapper

struct User {
  
  var avatar: String?
  var firstname: String?
  var lastname: String?
  var middlename: String?
  var email: String?
  var phone: String?
  var created_at: String?
  var updated_at: String?
  var college_name: String?
  var course: Int?
  var group_name: String?
  var classification: String?

  init?(map: Map) {
  }
  
  func getAvatarLink() -> String {
    return self.avatar ?? ""
  }
  
  func getFirstName() -> String {
    return self.firstname ?? ""
  }
  
  func getLastName() -> String {
    return self.lastname ?? ""
  }
  
  func getMiddleName() -> String {
    return self.middlename ?? ""
  }
  
  func getFullName() -> String {
    return "\(self.getLastName()) \(self.getFirstName()) \(self.getMiddleName())"
  }
  
  func getCollegeName() -> String {
    return self.college_name ?? ""
  }
  
  func getClassification() -> String {
    return self.classification ?? ""
  }
  
  func getCourse() -> String {
    if let course = self.course {
      return "\(course)"
    }
    return ""
  }
  
  func getGroupName() -> String {
    return self.group_name ?? ""
  }
  
  func getEmail() -> String {
    return self.email ?? ""
  }
  
  func getPhone() -> String {
    return self.phone ?? ""
  }
  
}

extension User: Mappable {
  mutating func mapping(map: Map) {
    avatar <- map["avatar"]
    firstname <- map["first_name"]
    lastname <- map["last_name"]
    middlename <- map["middle_name"]
    email <- map["email"]
    phone <- map["phone"]
    created_at <- map["created_at"]
    updated_at <- map["updated_at"]
    college_name <- map["college_name"]
    course <- map["course"]
    group_name <- map["group_name"]
    classification <- map["classification"]
  }
}

