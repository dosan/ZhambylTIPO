//
//  NewsViewController.swift
//  ZhambylTIPO
//
//  Created by Yerbol on 1/25/19.
//  Copyright © 2019 Yerbol. All rights reserved.
//

import UIKit
import EasyPeasy

class EventsViewController: UIViewController {
  
  var events = [Event]()
  var eventsCount = 0
  var currentPageNumber = 1
  let onePageEventsCount = 8
  
  lazy var tableView: UITableView = {
    let tableView = UITableView()
    tableView.tableFooterView = UIView()
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    tableView.dataSource = self
    tableView.delegate = self
    return tableView
  }()
  
  lazy var refreshControl: UIRefreshControl = {
    let refreshControl = UIRefreshControl()
    refreshControl.addTarget(self, action: #selector(handleRefresh(_:)), for: .valueChanged)
    return refreshControl
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    title = "Уведомления"
    view.addSubview(tableView)
    tableView.addSubview(self.refreshControl)
    tableView.easy.layout(Edges(0))
    getEvents()
  }
  
  func getEvents(pageNumber: Int = 1) {
    let conn = APIConnection()
    conn.getEvents(pageNumber: pageNumber) { result, eventsCount, error in
      guard let result = result else {
        self.showToast(message: error!.getMessage())
        return
      }
      self.events += result
      self.eventsCount = eventsCount
      self.tableView.reloadData()
      self.refreshControl.endRefreshing()
    }
  }
  
  @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
    self.events = []
    currentPageNumber = 1
    getEvents()
  }
  
}


extension EventsViewController: UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return events.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell: UITableViewCell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
    cell.textLabel?.numberOfLines = 3
    if events.count > 0 {
      cell.textLabel?.text = events[indexPath.row].getTitle()
      cell.detailTextLabel?.text = events[indexPath.row].getCreadetDate()
    }
    return cell
  }
  
}

extension EventsViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    if indexPath.row == events.count - 1, Int(eventsCount/onePageEventsCount)+1 > currentPageNumber  {
      currentPageNumber += 1
      getEvents(pageNumber: currentPageNumber)
    }
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    let webVC = ContentViewController()
    webVC.content = events[indexPath.row].getContent()
    navigationController?.pushViewController(webVC, animated: true)
  }
}


