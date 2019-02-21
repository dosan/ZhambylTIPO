//
//  LogInView.swift
//  ZhambylTIPO
//
//  Created by Yerbol on 1/25/19.
//  Copyright © 2019 Yerbol. All rights reserved.
//

import UIKit
import EasyPeasy

class LogInView: UIView {
  
  lazy var logo: UIImageView = {
    let logo = UIImageView()
    logo.image = UIImage(named: "logo")
    logo.contentMode = .scaleAspectFit
    return logo
  }()
  
  lazy var loginField: UITextField = {
    let loginField = UITextField()
    loginField.placeholder = "ИИН или Email"
    loginField.layer.borderWidth = 1
    loginField.layer.borderColor = UIColor.white.cgColor
    loginField.textAlignment = .center
    loginField.textColor = .white
    loginField.font = UIFont(name: Font.bold, size: 20)
    loginField.layer.cornerRadius = 5
    return loginField
  }()
  
  lazy var passwordField: UITextField = {
    let passwordField = UITextField()
    passwordField.isSecureTextEntry = true
    passwordField.placeholder = "Пароль"
    passwordField.layer.borderWidth = 1
    passwordField.layer.borderColor = UIColor.white.cgColor
    passwordField.textAlignment = .center
    passwordField.textColor = .white
    passwordField.font = UIFont(name: Font.bold, size: 20)
    passwordField.layer.cornerRadius = 5
    return passwordField
  }()
  
  lazy var logInButton: UIButton = {
    let logInButton = UIButton()
    logInButton.layer.borderWidth = 1
    logInButton.layer.borderColor = UIColor.white.cgColor
    logInButton.titleLabel?.font =  UIFont(name: Font.bold, size: 22)
    logInButton.layer.cornerRadius = 5
    return logInButton
  }()
  
  lazy var logInIndicator: UIActivityIndicatorView = {
    let logInIndicator = UIActivityIndicatorView()
    logInIndicator.hidesWhenStopped = true
    logInIndicator.style = .white
    return logInIndicator
  }()

  override init(frame: CGRect) {
    super.init(frame: frame)
    stopAnimating()
    backgroundColor = Color.blue
    setupViews()
    setupConstraints()
  }
  
  required init(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func startAnimating() {
    logInIndicator.startAnimating()
    logInButton.setTitle("ВХОД...", for: .normal)
    loginField.isEnabled = false
    passwordField.isEnabled = false
    logInButton.isEnabled = false
  }
  
  func stopAnimating() {
    logInIndicator.stopAnimating()
    logInButton.setTitle("ВОЙТИ", for: .normal)
    loginField.isEnabled = true
    passwordField.isEnabled = true
    logInButton.isEnabled = true
  }
  
  
  fileprivate func setupViews(){
    [logo, loginField, passwordField, logInButton].forEach {
      self.addSubview($0)
    }
    logInButton.addSubview(logInIndicator)
  }
  

  fileprivate func setupConstraints() {
    logo.easy.layout(CenterX(0),
                     Top(60.heightProportion()),
                     Height(100.heightProportion()))
    loginField.easy.layout(Top(30.heightProportion()).to(logo),
                           Width(300.widthProportion()),
                           Height(50.heightProportion()),
                           CenterX(0))
    passwordField.easy.layout(Top(5.heightProportion()).to(loginField),
                              Width().like(loginField),
                              Height().like(loginField),
                              CenterX(0))
    logInButton.easy.layout(Top(20.heightProportion()).to(passwordField),
                            CenterX(0),
                            Width().like(loginField),
                            Height().like(loginField))
    logInIndicator.easy.layout(Right(20.widthProportion()),
                               Top(0),
                               Bottom(0))
  }
}
