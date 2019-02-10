//
//  LogInViewController.swift
//  ZhambylTIPO
//
//  Created by Yerbol on 1/25/19.
//  Copyright © 2019 Yerbol. All rights reserved.
//

import UIKit
import EasyPeasy

class LogInViewController: UIViewController {
  
  lazy var loginView: LogInView = {
    let loginView = LogInView()
    loginView.logInButton.addTarget(self, action: #selector(logIn), for: .touchUpInside)
    loginView.loginField.text = "910906356163"
    loginView.passwordField.text = "123456"
    return loginView
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view = loginView
    if UserDefaults.standard.bool(forKey: Keys.isLogged) == true{
      logIn()
    } 
  }
  
  @objc func logIn() {
    loginView.startAnimating()
    let conn = APIConnection()
    conn.logIn(login: self.loginView.loginField.text ?? "",
               password: self.loginView.passwordField.text ?? "") { error in
      self.loginView.stopAnimating()
      guard let error = error else {
        self.present(TabBarController(), animated: true, completion: nil)
        return
      }
      self.showToast(message: error.getMessage())
    }
  }
  
}
