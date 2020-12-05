# 🎈FloatingShowable
This is a support kit that helps you develop a picture-in-picture-like view.

[![FloatingShowable](https://cocoapod-badges.herokuapp.com/v/FloatingShowable/badge.png)](https://cocoapods.org/pods/FloatingShowable)
![ios](https://cocoapod-badges.herokuapp.com/p/FloatingShowable/badge.png)
![MIT](https://cocoapod-badges.herokuapp.com/l/FloatingShowable/badge.png)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![Build Status](https://travis-ci.com/AkkeyLab/FloatingShowable.svg?branch=master)](https://travis-ci.com/AkkeyLab/FloatingShowable)
[![codecov](https://codecov.io/gh/AkkeyLab/FloatingShowable/branch/master/graph/badge.svg)](https://codecov.io/gh/AkkeyLab/FloatingShowable)

# Introduction
`FloatingShowable` is a UIKit library for a more concise picture-in-picture implementation. Acceleration control, which tends to be complicated, is also supported.

Features:

- It was developed inspired by the picture-in-picture introduced in iOS14.
- Movement that takes acceleration into account is possible
- Various parameters related to shadow and movement animation can be customized
- With this, picture-in-picture will be available in the app even on devices with iOS13 or lower.

# Installation
#### CocoaPods
```ruby
# Podfile
use_frameworks!

target 'YOUR_TARGET_NAME' do
    pod 'FloatingShowable'
end
```
Replace YOUR_TARGET_NAME and then, in the Podfile directory, type:
```sh
$ pod install
```

#### Carthage
Add this to `Cartfile`.
```ruby
# Cartfile
github "AkkeyLab/FloatingShowable"
```
Run this script to install it.
```sh
$ carthage update --platform iOS
```

# Simplest Usage
1. Please import FloatingShowable
2. The target UIViewController must be FloatingShowable compliant
```swift
import FloatingShowable
import UIKit

final class FloatingViewController: UIViewController, FloatingShowable {
    var position: FloatingPosition = .bottomRight

    var frameSize: CGSize {
        CGSize(width: 160, height: 90)
    }

    var window: UIWindow {
        UIApplication.shared.windows.filter { $0.isKeyWindow }.first ?? UIWindow()
    }
}
```
3. Call the show function from a FloatingShowable compliant object
4. Don't forget to call dismiss function when you want to destroy the parent instance
```swift
final class ViewController: UIViewController {
    private var floatingScreen = FloatingViewController()

    deinit {
        floatingScreen.dismiss(isScaleChange: true)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        floatingScreen.show()
    }
}
```
For the simplest implementation, picture-in-picture can be achieved in just four steps.

# Change the movement range
1. Change `stayArea` value
2. Call updateLayout function when the target object is already displayed
```swift
final class ViewController: UIViewController {
    private var floatingScreen = FloatingViewController()
    private var isBottomInsetAdd = false {
        didSet {
            floatingScreen.stayArea.bottom = isBottomInsetAdd ? 100 : 16
            floatingScreen.updateLayout()
        }
    }
}
```
After changing the value, if the target object is in the no-entry area, it will move with animation.

# Requirements
|env  |version |
|---    |---   |
|Swift  |5.x   |
|Xcode  |12.x  |
|iOS    |11.0  |

# License
AKProcessIndicator is available under the MIT license. See the LICENSE file for more info.
