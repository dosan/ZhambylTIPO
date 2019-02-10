//
//  Event.swift
//  ZhambylTIPO
//
//  Created by Yerbol on 1/31/19.
//  Copyright © 2019 Yerbol. All rights reserved.
//

import Foundation
import ObjectMapper

struct Event {
  
  var id: Int?
  var title: String?
  var created_at: String?
  var url: String?
  var content: String?
  
  init?(map: Map) {
  }
  
  func getTitle() -> String {
    return self.title ?? ""
  }
  
  func getURL() -> String {
    return self.url ?? ""
  }
  
  func getCreadetDate() -> String {
    return self.created_at ?? ""
  }
  
  func getContent() -> String {
    return self.content ?? ""
  }
  
}

extension Event: Mappable {
  mutating func mapping(map: Map) {
    id <- map["id"]
    title <- map["title"]
    created_at <- map["created_at"]
    url <- map["url"]
    content <- map["content"]
  }
}
