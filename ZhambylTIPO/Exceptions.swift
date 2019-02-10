//
//  Exceptions.swift
//  ZhambylTIPO
//
//  Created by Yerbol on 1/27/19.
//  Copyright © 2019 Yerbol. All rights reserved.
//

import Foundation

class ErrorStatusException: Error {
  
  var code: Int
  var message: String?
  
  init(code: Int, message: String?) {
    self.code = code
    self.message = message
  }
  
  func getStatus() -> Int {
    return self.code
  }
  
  func getMessage() -> String {
    if let message = self.message {
      return message
    }
    return "Неизвестная ошибка"
  }
  
}

