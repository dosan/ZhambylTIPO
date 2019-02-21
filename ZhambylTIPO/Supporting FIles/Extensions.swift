//
//  Extensions.swift
//  ZhambylTIPO
//
//  Created by Yerbol on 1/27/19.
//  Copyright © 2019 Yerbol. All rights reserved.
//

import UIKit

extension Int {
  
  func heightProportion() -> CGFloat {
    return CGFloat(self)*Screen.heightProportion
  }
  
  func widthProportion() -> CGFloat {
    return CGFloat(self)*Screen.widthProportion
  }
  
}

extension String {
  func subString(startIndex: Int, endIndex: Int) -> String {
    let end = (endIndex - self.count) + 1
    let indexStartOfText = self.index(self.startIndex, offsetBy: startIndex)
    let indexEndOfText = self.index(self.endIndex, offsetBy: end)
    let substring = self[indexStartOfText..<indexEndOfText]
    return String(substring)
  }
}

extension UIImageView {
  func load(url: URL) {
    DispatchQueue.global().async { [weak self] in
      if let data = try? Data(contentsOf: url) {
        if let image = UIImage(data: data) {
          DispatchQueue.main.async {
            self?.image = image
          }
        }
      }
    }
  }
}


extension UIViewController {
  
  func showToast(message : String) {
    
    let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 150, y: self.view.frame.size.height-100, width: 300, height: 50))
    toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
    toastLabel.textColor = .white
    toastLabel.textAlignment = .center;
    toastLabel.font = UIFont(name: Font.regular, size: 11)
    toastLabel.text = message
    toastLabel.alpha = 1.0
    toastLabel.layer.cornerRadius = 10;
    toastLabel.clipsToBounds  =  true
    self.view.addSubview(toastLabel)
    UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseOut, animations: {
      toastLabel.alpha = 0.0
    }, completion: {(isCompleted) in
      toastLabel.removeFromSuperview()
    })
  }
  
}

