//
//  Delta.swift
//  ChicByChoice
//
//  Created by Ivan Bruel on 26/02/16.
//  Copyright © 2016 Chic by Choice. All rights reserved.
//

import Foundation
import UIKit

public class Delta {

  public let addedIndices: NSIndexSet
  public let removedIndices: NSIndexSet
  public let movedIndexPairs: [(Int, Int)]
  public let unchangedIndices: NSIndexSet

  public init(addedIndices: NSIndexSet, removedIndices: NSIndexSet, movedIndexPairs: [(Int, Int)],
    unchangedIndices: NSIndexSet) {
      self.addedIndices = addedIndices
      self.removedIndices = removedIndices
      self.movedIndexPairs = movedIndexPairs
      self.unchangedIndices = unchangedIndices
  }

  public func applyUpdatesToTableView(tableView: UITableView, inSection section: Int,
    withRowAnimation rowAnimation: UITableViewRowAnimation) {
      let removedIndexPaths = removedIndices.map { NSIndexPath(forRow: $0, inSection: section) }
      tableView.deleteRowsAtIndexPaths(removedIndexPaths, withRowAnimation: rowAnimation)

      let addedIndexPaths = addedIndices.map { NSIndexPath(forRow: $0, inSection: section) }
      tableView.insertRowsAtIndexPaths(addedIndexPaths, withRowAnimation: rowAnimation)

      movedIndexPairs
        .map { (NSIndexPath(forRow: $0.0, inSection: section),
          NSIndexPath(forRow: $0.1, inSection: section)) }.forEach {
            tableView.moveRowAtIndexPath($0.0, toIndexPath: $0.1)
      }
  }

  public func applyUpdatesToCollectionView(collectionView: UICollectionView,
    inSection section: Int) {
    let removedIndexPaths = removedIndices.map { NSIndexPath(forRow: $0, inSection: section) }
    collectionView.deleteItemsAtIndexPaths(removedIndexPaths)

    let addedIndexPaths = addedIndices.map { NSIndexPath(forRow: $0, inSection: section) }
    collectionView.insertItemsAtIndexPaths(addedIndexPaths)

    movedIndexPairs
      .map { (NSIndexPath(forRow: $0.0, inSection: section),
        NSIndexPath(forRow: $0.1, inSection: section)) }.forEach {
          collectionView.moveItemAtIndexPath($0.0, toIndexPath: $0.1)
    }
  }

}
