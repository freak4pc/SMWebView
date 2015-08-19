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
@IBOutlet weak var webView: SMWebView! 

...

// Basic Implementation
webView.loadURL(NSURL("http://github.com/freak4pc")!)
       .didCompleteLoading  { webView in
                           	log("Finished loading entire webpage")
                        	}

// All Options
webView.loadURL(NSURL(string: "http://dreamdate.io/terms.php?bare")!)
       .didStartLoading 	{ webView in
                           		log("Started loading \(webView.request?.URL?.absoluteString)")
                          	}
       .didFinishLoading 	{ webView in
                           		log("Finished loading \(webView.request?.URL?.absoluteString)")
                       		}
       .didFailLoading		{ webView, error in
           						log("Failed loading \(error)")
       						}
       .didCompleteLoading 	{ webView in
                           		log("Finished loading entire webpage")
                        	}
       .shouldStartLoading	{ webView, request, type in
       							return true
       						}
```

##### Classic Usage

SMWebView features Static Methods allowing you to configure your entire SMWebView with a single statement, followed by setting the frame and adding it to your view hierarchy as follows:

```swift

let webView     = SMWebView.loadURL(NSURL(string: "http://github.com/freak4pc")!)
						   .didCompleteLoading { webView in
				 	           log("Finished loading URL : \(webView.request?.URL?.absoluteString)")
			               }
        
webView.frame   = UIScreen.mainScreen().bounds
self.view.addSubview(webView)
```

Clearly all other options from the Storyboard example are relevant here as well.


## Installation

SMWebView is available through [CocoaPods](http://cocoapods.org).
To install it, simply add the following line to your Podfile:

```ruby
pod "SMWebView"
```

## Methods

### Loading Content

##### loadURL(URL: NSURL)
Starts loading the supplied NSURL and returns a SMWebView, allowing to chain methods to it. Has both an instance and a class variance.

##### loadHTML(string: String, baseURL: NSURL)
Starts loading the supplied HTML String over the supplied Base URL and returns a SMWebView, allowing to chain methods to it. Has both an instance and a class variance.

### Get Updates (Chainable Closures)

##### didStartLoading
A closure wrapper around UIWebViewDelegate's `webViewDidStartLoad` notifying your closure when a resource starts loading. Can be chained to other SMWebView methods. 

##### didFinishLoading
A closure wrapper around UIWebViewDelegate's `webViewDidFinishLoad` notifying your closure when a resource finishes loading. Can be chained to other SMWebView methods. 

##### didFailLoading
A closure wrapper around UIWebViewDelegate's `webViewDidFailLoadWithError` notifying your closure when a resource fails loading. Can be chained to other SMWebView methods. 

##### shouldStartLoading
A closure wrapper around UIWebViewDelegate's `webViewDidFailLoadWithError` notifying your closure when a resource is about to be loaded, allowing you to return either `true` or `false` in order to prevent or allow the loading of that specific action. Can be chained to other SMWebView methods. 

##### didCompleteLoading
A closure notifying you when your Web page has been completely looking, as opposed to didStartLoading which updates you on the loading of every resource on the requested page. This feature is still iffy / in beta and has some issues when handling redirections / complex fetching. 




## Author

Shai Mishali (freak4pc), me@freak4pc.com<br />
http://github.com/freak4pc<br />
http://facebook.com/freak4pc

## License

SMWebView is available under the MIT license. See the LICENSE file for more info.

