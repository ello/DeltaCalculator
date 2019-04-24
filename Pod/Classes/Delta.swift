//
//  Delta.swift
//
//  Created by Ivan Bruel on 26/02/16.
//

import Foundation
import UIKit

public class Delta {

  public let addedIndices: IndexSet
  public let removedIndices: IndexSet
  public let movedIndexPairs: [(Int, Int)]
  public let unchangedIndices: IndexSet

  public init(addedIndices: IndexSet, removedIndices: IndexSet, movedIndexPairs: [(Int, Int)],
    unchangedIndices: IndexSet) {
      self.addedIndices = addedIndices
      self.removedIndices = removedIndices
      self.movedIndexPairs = movedIndexPairs
      self.unchangedIndices = unchangedIndices
  }

  public func applyUpdatesToTableView(_ tableView: UITableView, inSection section: Int,
    withRowAnimation rowAnimation: UITableView.RowAnimation) {
      let removedIndexPaths = removedIndices.map { IndexPath(row: $0, section: section) }
      tableView.deleteRows(at: removedIndexPaths, with: rowAnimation)

      let addedIndexPaths = addedIndices.map { IndexPath(row: $0, section: section) }
      tableView.insertRows(at: addedIndexPaths, with: rowAnimation)

      movedIndexPairs
        .map { (IndexPath(row: $0.0, section: section),
          IndexPath(row: $0.1, section: section)) }.forEach {
            tableView.moveRow(at: $0.0, to: $0.1)
      }
  }

  public func applyUpdatesToCollectionView(_ collectionView: UICollectionView,
    inSection section: Int) {
    let removedIndexPaths = removedIndices.map { IndexPath(row: $0, section: section) }
    collectionView.deleteItems(at: removedIndexPaths)

    let addedIndexPaths = addedIndices.map { IndexPath(row: $0, section: section) }
    collectionView.insertItems(at: addedIndexPaths)

    movedIndexPairs
      .map { (IndexPath(row: $0.0, section: section),
        IndexPath(row: $0.1, section: section)) }.forEach {
          collectionView.moveItem(at: $0.0, to: $0.1)
    }
  }

}
