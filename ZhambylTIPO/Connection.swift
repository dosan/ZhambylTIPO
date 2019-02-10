//
//  Connection.swift
//  ZhambylTIPO
//
//  Created by Yerbol on 1/27/19.
//  Copyright © 2019 Yerbol. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

class APIConnection {
  
  static var access_url: String {
    return "https://tipo2.jdi.kz/mobile/"
  }
  
  var schemas = ["login": "\(access_url)login",
                 "profile": "\(access_url)profile",
                 "disciplines": "\(access_url)disciplines",
                 "schedules": "\(access_url)schedules",
                 "grades": "\(access_url)grades",
                 "events": "\(access_url)events?page=1)"]
  
  func sendRequest(action_name: String, method: HTTPMethod = .get, parameters: Parameters,
                   completion: @escaping ([String: Any]?, ErrorStatusException?) -> Void) {
    guard let url = self.schemas[action_name] else {
      return
    }
    request(url, method: method, parameters: parameters, encoding: URLEncoding.httpBody)
      .validate(statusCode: 200..<300)
      .responseJSON{ response in
        switch response.result {
        case .success:
          guard let json = response.result.value as? [String: Any] else{
            return
          }
          if let isError = json["error"] as? Bool {
            if isError {
              completion(nil, ErrorStatusException(code: response.response?.statusCode ?? 200, message: json["error_msg"] as? String))
            } else {
              completion(json, nil)
            }
          }
        case .failure(let error):
          completion(nil, ErrorStatusException(code: response.response?.statusCode ?? 666, message: error.localizedDescription))
        }

    }
  }
  
  func generateToken() -> String {
    return UserDefaults.standard.value(forKey: Keys.login) as! String
  }
  
  func getToken(login: String = "", password: String = "") -> String {
    if login != "", password != "" {
      UserDefaults.standard.set(login, forKey: Keys.login)
      UserDefaults.standard.set(password, forKey: Keys.password)
    }
    return self.generateToken()
  }
  
  func logIn(login: String, password: String, completion: @escaping (ErrorStatusException?) -> Void){
    let parameters : Parameters = ["login": login,
                                   "password": password,
                                   "token": self.getToken(login: login, password: password)]
    sendRequest(action_name: "login", method: .post, parameters: parameters){ result, error in
      guard let error = error else {
        UserDefaults.standard.set(true, forKey: Keys.isLogged)
        completion(nil)
        return
      }
      UserDefaults.standard.set(false, forKey: Keys.isLogged)
      completion(error)
    }
  }
  
  func getProfileInfo(completion: @escaping (User?, ErrorStatusException?) -> Void){
    let parameters : Parameters = ["token": self.getToken()]
    sendRequest(action_name: "profile", method: .post, parameters: parameters){ result, error in
      guard let error = error else {
        let user = Mapper<User>().map(JSONObject: result?["user"] as? [String: Any])
        completion(user, nil)
        return
      }
      completion(nil, error)
    }
  }
  
  func getDisciplines(completion: @escaping ([Discipline]?, ErrorStatusException?) -> Void){
    let parameters : Parameters = ["token": self.getToken()]
    sendRequest(action_name: "disciplines", method: .post, parameters: parameters){ result, error in
      guard let error = error else {
        let disciplines = Mapper<Discipline>().mapArray(JSONObject: result?["disciplines"] as? [[String: Any]])
        completion(disciplines, nil)
        return
      }
      completion(nil, error)
    }
  }
  
  func getSchedules(completion: @escaping ([Schedule]?,ErrorStatusException?) -> Void){
    let parameters : Parameters = ["token": self.getToken()]
    sendRequest(action_name: "schedules", method: .post, parameters: parameters){ result, error in
      guard let error = error else {
        let schedules = Mapper<Schedule>().mapArray(JSONObject: result?["schedules"] as? [[String: Any]])
        completion(schedules,nil)
        return
      }
      completion(nil, error)
    }
  }
  
  func getGrades(completion: @escaping ([Grade]?, ErrorStatusException?) -> Void){
    let parameters : Parameters = ["token": self.getToken()]
    sendRequest(action_name: "grades", method: .post, parameters: parameters){ result, error in
      guard let error = error else {
        let grades = Mapper<Grade>().mapArray(JSONObject: result?["grades"] as? [[String: Any]])
        completion(grades, nil)
        return
      }
      completion(nil, error)
    }
  }
  
  func getEvents(pageNumber: Int, completion: @escaping ([Event]?, Int, ErrorStatusException?) -> Void){
    let parameters : Parameters = ["token": self.getToken()]
    self.schemas["events"] = "\(APIConnection.access_url)events?page=\(pageNumber)"
    sendRequest(action_name: "events", method: .post, parameters: parameters){ result, error in
      guard let error = error else {
        let events = Mapper<Event>().mapArray(JSONObject: result?["events"] as? [[String: Any]])
        let eventsCount = result?["events_quantity"] as? Int
        completion(events, eventsCount ?? 0, nil)
        return
      }
      completion(nil, 0, error)
    }
  }

}


