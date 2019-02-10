//
//  WebViewController.swift
//  ZhambylTIPO
//
//  Created by Yerbol on 2/1/19.
//  Copyright © 2019 Yerbol. All rights reserved.
//

import UIKit
import EasyPeasy

class ContentViewController: UIViewController {
  
  var content: String!
  
  lazy var contentView : UITextView = {
    let contentView = UITextView()
    contentView.isEditable = false
    return contentView
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    view.addSubview(contentView)
    contentView.easy.layout(Edges(10))
    if let content = self.content {
      contentView.text = content
    }
  }
  
  
}
