[![Version](https://img.shields.io/cocoapods/v/DeltaCalculator.svg?style=flat)](http://cocoapods.org/pods/DeltaCalculator)
[![License](https://img.shields.io/cocoapods/l/DeltaCalculator.svg?style=flat)](http://cocoapods.org/pods/DeltaCalculator)
[![Platform](https://img.shields.io/cocoapods/p/DeltaCalculator.svg?style=flat)](http://cocoapods.org/pods/DeltaCalculator)

![DeltaCalculator](http://i.imgur.com/yZOOcwC.png)

# DeltaCalculator

DeltaCalculator is a Swift Library focused on replacing reloadData() calls with animated insert, delete and move operations.

DeltaCalculator tries to optimize the number of iterations to calculate all the changes, making sure the UI thread doesn't block.

This framework is based on [BKDeltaCalculator](https://github.com/Basket/BKDeltaCalculator) Objective-C library.

## Installation

DeltaCalculator is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'DeltaCalculator'
```

## Usage

`DeltaCalculator` compares two arrays and computes the delta between them, represented by a `Delta` object.
`DeltaCalculator` is generic, therefor, you need to supply the class in the initializer.

In case your generic class is `Equatable` you can initialize the calculator without an `equalityTest`.

```swift
let deltaCalculator = DeltaCalculator<String>()
let delta = deltaCalculator.deltaFromOldArray(dataModel, toNewArray: newDataModel)
```

Otherwise you are required to supply an `equalityTest` in the initializer.

```swift
let deltaCalculator = DeltaCalculator<NSDate>() { (lhs, rhs) -> Bool in
  return lhs.compare(rhs) == .OrderedSame
}
let delta = deltaCalculator.deltaFromOldArray(dataModel, toNewArray: newDataModel)
```

### UITableViews

To apply the `Delta` to a `UITableView` you need to use a batch update such as the following:

```swift
let delta = deltaCalculator.deltaFromOldArray(dataModel, toNewArray: newDataModel)
tableView.beginUpdates()
dataModel = newDataModel
delta.applyUpdatesToTableView(tableView, inSection: 0, withRowAnimation: UITableViewRowAnimation.Right)
tableView.endUpdates()
```

### UICollectionViews

To apply the `Delta` to a `UICollectionView` you also need to perform it in a batch update:

```swift
let delta = deltaCalculator.deltaFromOldArray(dataModel, toNewArray: newDataModel)
collectionView.performBatchUpdates({
  self.dataModel = newDataModel
  delta.applyUpdatesToCollectionView(collectionView, inSection: 0)
}, completion: nil)
```

## Sample

There is a sample project in the `Example` directory.

## Author

Ivan Bruel, [@ivanbruel](http://twitter.com/ivanbruel)

## License

Delta is available under the MIT license. See the LICENSE file for more info.
