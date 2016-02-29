//
//  ViewController.swift
//  Delta
//
//  Created by Ivan Bruel on 02/29/2016.
//  Copyright (c) 2016 Ivan Bruel. All rights reserved.
//

import UIKit
import Delta

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {


  var dataModel = [String]()
  let deltaCalculator = DeltaCalculator<String>() { (lhs, rhs) -> Bool in
    return lhs == rhs
  }

  var number: Int = 0
  @IBOutlet var tableView: UITableView!

  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "tableViewCell")
  }

  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return dataModel.count
  }

  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("tableViewCell", forIndexPath: indexPath)
    cell.textLabel?.text = dataModel[indexPath.row]
    return cell
  }

  func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
    if editingStyle == .Delete {
      removeItem(indexPath.row)
    }
  }

  @IBAction func addClick() {
    addItem("\(number++)")
  }

  @IBAction func shuffleClick() {
    guard dataModel.count > 1 else {
      print("cant shuffle array with 0 or 1 items")
      return
    }
    let firstRandomIndex = Int(arc4random_uniform(UInt32(dataModel.count)))
    let secondRandomIndex = Int(arc4random_uniform(UInt32(dataModel.count)))
    if firstRandomIndex == secondRandomIndex {
      shuffleClick()
      return
    }
    moveItem(firstRandomIndex, newIndex: secondRandomIndex)

  }

}

extension ViewController {

  func addItem(string: String) {
    updateTableView(dataModel + [string])
  }

  func removeItem(index: Int) {
    var newDataModel = dataModel
    newDataModel.removeAtIndex(index)
    updateTableView(newDataModel)
  }

  func moveItem(oldIndex: Int, newIndex: Int) {
    var newDataModel = dataModel
    swap(&newDataModel[oldIndex], &newDataModel[newIndex])
    updateTableView(newDataModel)
  }

  func updateTableView(newDataModel: [String]) {
    let delta = deltaCalculator.deltaFromOldArray(dataModel, toNewArray: newDataModel)
    tableView.beginUpdates()
    dataModel = newDataModel
    delta.applyUpdatesToTableView(tableView, inSection: 0, withRowAnimation: UITableViewRowAnimation.Right)
    tableView.endUpdates()
  }


}

