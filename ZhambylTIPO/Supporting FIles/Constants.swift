//
//  Constants.swift
//  ZhambylTIPO
//
//  Created by Yerbol on 1/28/19.
//  Copyright © 2019 Yerbol. All rights reserved.
//

import UIKit

enum Color {
  static let blue = UIColor(red: 49/255.0, green: 61/255.0, blue: 124/255.0, alpha: 1.0)
}

enum GradesColor {
  static let five = UIColor(red:0.24, green:0.44, blue:0.15, alpha:1.00)
  static let four = UIColor(red:0.45, green:0.68, blue:0.33, alpha:1.00)
  static let three = UIColor(red:0.91, green:0.52, blue:0.26, alpha:1.00)
  static let two = UIColor(red:0.90, green:0.30, blue:0.36, alpha:1.00)
  static let one = UIColor.red
}

enum Screen {
  static let width = UIScreen.main.bounds.width
  static let height = UIScreen.main.bounds.height
  static let widthProportion = width/375
  static let heightProportion = height/667
}

enum Keys {
  static let isLogged = "isUserLogged"
  static let login = "Login"
  static let password = "Password"
}

enum Font {
  static let regular = "Avenir Next"
  static let bold = "AvenirNext-Bold"
}
