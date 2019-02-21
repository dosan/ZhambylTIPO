//
//  Switcher.swift
//  ZhambylTIPO
//
//  Created by Yerbol on 2/15/19.
//  Copyright © 2019 Yerbol. All rights reserved.
//

import UIKit

class Switcher {
  
  static func updateRootVC(){
    
    let status = UserDefaults.standard.bool(forKey: Keys.isLogged)
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    if(status == true){
      appDelegate.window?.rootViewController = TabBarController()

    }else{
      appDelegate.window?.rootViewController = LogInViewController()
    }
  }
  
}
