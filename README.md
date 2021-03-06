# YTSelectionPopupView

[![CI Status](http://img.shields.io/travis/yigit26/YTSelectionPopupView.svg?style=flat)](https://travis-ci.org/yigit26/YTSelectionPopupView) 
[![Version](https://img.shields.io/cocoapods/v/YTSelectionPopupView.svg?style=flat)](http://cocoapods.org/pods/YTSelectionPopupView)
[![License](https://img.shields.io/cocoapods/l/YTSelectionPopupView.svg?style=flat)](http://cocoapods.org/pods/YTSelectionPopupView)
[![Platform](https://img.shields.io/cocoapods/p/YTSelectionPopupView.svg?style=flat)](http://cocoapods.org/pods/YTSelectionPopupView)
[![Coverage Status](https://coveralls.io/repos/github/yigit26/YTSelectionPopupView/badge.svg?branch=master)](https://coveralls.io/github/yigit26/YTSelectionPopupView?branch=master)

## Screenshots

![simulator screen shot 31 may 2017 18 57 08](https://cloud.githubusercontent.com/assets/4510936/26649004/fb1e68d4-464c-11e7-958a-8cba4f4d7068.png)


## Usage
First of all import module
```swift
 import YTSelectionPopupView
```
Then you can use like this :
```swift
 let selectionView = YTSelectionPopupView.instantiate()
        selectionView.optionButtonTitleDone = "OK"
        selectionView.optionButtonTitleCancel = "Cancel"
        selectionView.optionBackgroundColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
        selectionView.dataSource = self
        selectionView.delegate = self
        selectionView.optionSelectionType = .multiple // .single
        selectionView.optionDisplayStyle = .withoutTextField //  .withTextField
        selectionView.optionPopupTitle = "Title Here!"
        present(selectionView, animated: true, completion: nil)
```
## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements
iOS9+

## Installation

YTSelectionPopupView is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "YTSelectionPopupView"
```

## Author

Yigit Can Ture,

## License

YTSelectionPopupView is available under the MIT license. See the LICENSE file for more info.
