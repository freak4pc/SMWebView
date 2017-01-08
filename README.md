SMWebView
================

[![Version](https://img.shields.io/cocoapods/v/SMWebView.svg?style=flat)](http://cocoapods.org/pods/SMWebView)
[![License](https://img.shields.io/cocoapods/l/SMWebView.svg?style=flat)](http://cocoapods.org/pods/SMWebView)
[![Platform](https://img.shields.io/cocoapods/p/SMWebView.svg?style=flat)](http://cocoapods.org/pods/SMWebView)

SMWebView is a delightful, lightweight Swift wrapper around UIWebView that lets you harness the power of Closures and Chaining. 
And of course - Get rid of those pesky, awful delegates ;-) 

## Usage

Instead of allocating a new UIWebView and assigning a delegate to it, you can use either a Storyboard or SMWebView's static methods in order to get started.

##### Storyboard / Outlet Usage

Using a storyboard setup is as easy as calling `loadURL` / `loadHTML` on our SMWebView Outlet, which will put all of this closure-chaining magic is right at your finger tips :) 

```swift
@IBOutlet weak fileprivate var webView: SMWebView! 

...

// Basic Implementation
webView
    .loadURL(URL(string: "https://github.com/freak4pc")!)
    .didCompleteLoading { webView in
        print("Finished loading entire webpage")
    }

// All Options
webView
    .loadURL(URL(string: "https://github.com/freak4pc")!)
    .didStartLoading { webView in
        print("Started loading \(webView.request?.url?.absoluteString)")
    }
    .didFinishLoading { webView in
        print("Finished loading \(webView.request?.url?.absoluteString)")
    }
    .didFailLoading { webView, error in
        print("Failed loading \(error)")
    }
    .didCompleteLoading { webView in
        print("Finished loading entire webpage")
    }
    .shouldStartLoading { webView, request, type in
        return true
    }
```

##### Classic Usage

SMWebView features Static Methods allowing you to configure your entire SMWebView with a single statement, followed by setting the frame and adding it to your view hierarchy as follows:

```swift
let webView = SMWebView
                .loadURL(URL(string: "https://github.com/freak4pc")!)
                .didCompleteLoading { webView in
                    print("Finished loading URL: \(webView.request?.url?.absoluteString)")
                }

webView.frame = UIScreen.main.bounds
self.view.addSubview(webView)
```

Clearly all other options from the Storyboard example are relevant here as well.

## Installation

SMWebView is available through [CocoaPods](http://cocoapods.org).
To install it, simply add the following line to your Podfile:

```ruby
pod 'SMWebView'
```

## Author
[![GitHub][1.1]](https://github.com/freak4pc)
[![Twitter][2.1]](https://twitter.com/freak4pc)
[![Facebook][3.1]](https://facebook.com/freak4pc)

Shai Mishali (freak4pc)

[1.1]: http://i.imgur.com/0o48UoR.png
[2.1]: http://i.imgur.com/tXSoThF.png
[3.1]: http://i.imgur.com/P3YfQoD.png

## License

SMWebView is available under the MIT license. See the LICENSE file for more info.

