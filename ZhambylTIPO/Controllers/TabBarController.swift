//
//  TabBarController.swift
//  ZhambylTIPO
//
//  Created by Yerbol on 1/25/19.
//  Copyright © 2019 Yerbol. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {
  
  let tabBarElements = [["title": "Уведомления", "imageName": "news"],
                        ["title": "Занятия", "imageName": "classes"],
                        ["title": "Оценки", "imageName": "grades"],
                        ["title": "Профиль", "imageName": "profile"]]
  
  let controllers = [EventsViewController(), SchedulesViewController(), GradesViewController(), ProfileViewController()]
  var tabBarVC: [UINavigationController] = []
  
  override func viewDidLoad() {
    super.viewDidLoad()
    controllers.forEach{
      let navController = UINavigationController()
      navController.viewControllers = [$0]
      navController.navigationBar.isTranslucent = false
      tabBarVC.append(navController)
    }
    viewControllers = tabBarVC
    tabBar.barTintColor = .white
    tabBar.tintColor = Color.blue
    tabBar.isTranslucent = false
    
    if #available(iOS 10.0, *) {
      self.tabBar.unselectedItemTintColor = UIColor.black.withAlphaComponent(0.3)
    }
    
    for (index, item) in (self.tabBar.items?.enumerated())! {
      item.title = tabBarElements[index]["title"]
      item.image = UIImage(named: tabBarElements[index]["imageName"]!)
    }
  }
  
  
}
