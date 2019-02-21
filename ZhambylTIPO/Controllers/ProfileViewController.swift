//
//  ProfileViewController.swift
//  ZhambylTIPO
//
//  Created by Yerbol on 1/28/19.
//  Copyright © 2019 Yerbol. All rights reserved.
//

import UIKit
import EasyPeasy

class ProfileViewController: UIViewController {
  
  var user: User!
  
  lazy var tableView: UITableView = {
    let tableView = UITableView()
    tableView.delegate = self
    tableView.dataSource = self
    tableView.tableFooterView = UIView()
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    tableView.allowsSelection = false
    return tableView
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "sign_out"), style: .plain, target: self, action: #selector(signOut))
    view.addSubview(tableView)
    tableView.easy.layout(Edges(0))
    getUser()
  }
  
  func getUser() {
    let conn = APIConnection()
    conn.getProfileInfo { user, error in
      guard let user = user else {
        self.showToast(message: error!.getMessage())
        return
      }
      self.user = user
      self.navigationItem.title = user.getFirstName()
      self.tableView.reloadData()
    }
  }
  
  @objc func signOut() {
    let alert = UIAlertController(title: "", message: "Вы действительно хотите выйти?", preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "Выйти", style: .destructive, handler: { action in
      UserDefaults.standard.set(false, forKey: Keys.isLogged)
      Switcher.updateRootVC()
    }))
    alert.addAction(UIAlertAction(title: "Отменить", style: UIAlertAction.Style.cancel, handler: nil))
    self.present(alert, animated: true, completion: nil)
  }
  
}

extension ProfileViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 7
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell: UITableViewCell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
    cell.textLabel?.font = UIFont(name: Font.regular, size: 10)
    cell.detailTextLabel?.font = UIFont(name: Font.regular, size: 20)
    cell.detailTextLabel?.adjustsFontSizeToFitWidth = true
    cell.detailTextLabel?.numberOfLines = 2
    
    var text = ""
    var detailText = ""
    
    if let user = user {
      switch indexPath.row {
      case 0:
        text = "ФИО"
        detailText = user.getFullName()
      case 1:
        text = "Колледж"
        detailText = user.getCollegeName()
      case 2:
        text = "Специальность"
        detailText = user.getClassification()
      case 3:
        text = "Курс"
        detailText = user.getCourse()
      case 4:
        text = "Группа"
        detailText = user.getGroupName()
      case 5:
        text = "Email"
        detailText = user.getEmail()
      case 6:
        text = "Телефон"
        detailText = user.getPhone()
      default:
        break
      }
      cell.textLabel?.text = text
      cell.detailTextLabel?.text = detailText
    }
    return cell
  }
  
}

extension ProfileViewController: UITableViewDelegate {

  func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return 150.heightProportion()
  }
  
  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    let header = UIView()
    header.backgroundColor = .white
    let imageView = UIImageView()
    imageView.contentMode = .scaleAspectFit
    imageView.image = UIImage(named: "avatar2")
    imageView.layer.cornerRadius = 10
    imageView.clipsToBounds = true
    if let user = self.user {
      if let url = URL(string: user.getAvatarLink()) {
        imageView.load(url: url)
      }
    }
    header.addSubview(imageView)
    imageView.easy.layout(Center(0),
                          Size(135.heightProportion()))
    return header
  }
  
}

