//
//  DeltaCalculator.swift
//
//  Created by Ivan Bruel on 29/02/16.
//

import Foundation

public enum DeltaOptions {
  case ignoreRemove
  case ignoreInsertAndMove
}

public class DeltaCalculator<T> {

  public var options: [DeltaOptions]
  public let equalityTest: (T, T) -> Bool

  public init(options: [DeltaOptions]? = nil, equalityTest: @escaping ((T, T) -> Bool)) {
    self.options = options ?? []
    self.equalityTest = equalityTest
  }

  public func deltaFromOldArray(_ oldArray: [T], toNewArray newArray: [T]) -> Delta {
    var unchangedIndices = IndexSet()
    var movedIndices = [(Int, Int)]()
    var addedNewIndices = IndexSet()
    var removedOldIndices = IndexSet()

    // Unchanged
    let minIndex = min(oldArray.count, newArray.count)
    for index in 0..<minIndex {
      if equalityTest(oldArray[index], newArray[index]) {
        unchangedIndices.insert(index)
      }
    }

    // Moved and added
    if !options.contains(.ignoreInsertAndMove) {
      for index in 0..<newArray.count {
        guard !unchangedIndices.contains(index) else {
          continue
        }

        let newItem = newArray[index]
        guard let oldIndex = oldArray.index(where: { self.equalityTest($0, newItem) }) else {
          addedNewIndices.insert(index)
          continue
        }

        movedIndices.append((oldIndex, index))
      }
    }

    // Removed
    if !options.contains(.ignoreRemove) {
      for index in 0..<oldArray.count {
        let oldItem = oldArray[index]
        guard let _ = newArray.index(where: { self.equalityTest($0, oldItem) }) else {
          removedOldIndices.insert(index)
          continue
        }
      }
    }

    return Delta(addedIndices: addedNewIndices, removedIndices: removedOldIndices,
      movedIndexPairs: movedIndices, unchangedIndices: unchangedIndices)
  }

}

extension DeltaCalculator where T: Equatable {

  public convenience init() {
    self.init() { (lhs, rhs) -> Bool in
      return lhs == rhs
    }
  }

}
