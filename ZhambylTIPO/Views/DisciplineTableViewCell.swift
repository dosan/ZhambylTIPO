//
//  DistciplineTableViewCell.swift
//  ZhambylTIPO
//
//  Created by Yerbol on 1/28/19.
//  Copyright © 2019 Yerbol. All rights reserved.
//

import UIKit

class DisciplineTableViewCell: UITableViewCell {
  
  var noDiscipline: Bool = false {
    didSet{
      if noDiscipline {
        self.backgroundColor = UIColor.lightGray.withAlphaComponent(0.3)
      } else {
        self.backgroundColor = .white
      }
    }
  }
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: UITableViewCell.CellStyle.value1, reuseIdentifier: "cell")
    self.noDiscipline = false
    self.textLabel?.font = UIFont(name: Font.regular, size: 20)
    self.detailTextLabel?.font = UIFont(name: Font.regular, size: 15)
    self.textLabel?.adjustsFontSizeToFitWidth = true
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

}
