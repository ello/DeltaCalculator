//
//  DeltaCalculator.swift
//  ChicByChoice
//
//  Created by Ivan Bruel on 29/02/16.
//  Copyright © 2016 Chic by Choice. All rights reserved.
//

import Foundation

public class DeltaCalculator<T> {

  public let equalityTest: (T, T) -> Bool

  public init(equalityTest: ((T, T) -> Bool)) {
    self.equalityTest = equalityTest
  }

  public func deltaFromOldArray(oldArray: [T], toNewArray newArray: [T]) -> Delta {
    let unchangedIndices = NSMutableIndexSet()
    var movedIndices = [(Int, Int)]()
    let addedNewIndices = NSMutableIndexSet()
    let removedOldIndices = NSMutableIndexSet()

    // Unchanged
    for var index = 0; index < oldArray.count && index < newArray.count; index++ {
      if equalityTest(oldArray[index], newArray[index]) {
        unchangedIndices.addIndex(index)
      }
    }

    // Moved and added
    for var index = 0; index < newArray.count; index++ {
      guard !unchangedIndices.contains(index) else {
        continue
      }

      let newItem = newArray[index]
      guard let oldIndex = oldArray.indexOf({ self.equalityTest($0, newItem) }) else {
        addedNewIndices.addIndex(index)
        continue
      }

      movedIndices.append((Int(oldIndex.value), index))
    }

    // Removed
    for var index = 0; index < oldArray.count; index++ {
      let oldItem = oldArray[index]
      guard let _ = newArray.indexOf({ self.equalityTest($0, oldItem) }) else {
        removedOldIndices.addIndex(index)
        continue
      }
    }

    return Delta(addedIndices: addedNewIndices, removedIndices: removedOldIndices,
      movedIndexPairs: movedIndices, unchangedIndices: unchangedIndices)
  }

}
