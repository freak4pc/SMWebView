//
//  SMWebView
//
//  Created by Shai Mishali on 8/19/15.
//  Copyright (c) 2015 Shai Mishali. All rights reserved.
//

import Foundation
import UIKit

open class SMWebView: UIWebView, UIWebViewDelegate{
    //MARK: Typealiasing for Closure Types
    public typealias SMWebViewClosure                                       = (_ webView :SMWebView) -> ()
    public typealias SMWebViewFailClosure                                   = (_ webView :SMWebView, _ error: Error?) -> ()
    public typealias SMWebViewShouldLoadClosure                             = (_ webView :SMWebView, _ request: URLRequest, _ navigationType: UIWebViewNavigationType) -> (Bool)
    
    //MARK: Internal storage for Closures
    fileprivate var didStartLoadingHandler: SMWebViewClosure?               = nil
    fileprivate var didFinishLoadingHandler: SMWebViewClosure?              = nil
    fileprivate var didCompleteLoadingHandler: SMWebViewClosure?            = nil
    fileprivate var didFailLoadingHandler: SMWebViewFailClosure?            = nil
    fileprivate var shouldStartLoadingHandler: SMWebViewShouldLoadClosure?  = nil
    
    //MARK: Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        delegate  = self
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        delegate  = self
    }
    
    // URL/String loaders with Chaining-support
    public class func loadURL(_ URL: URL) -> SMWebView {
        let wv = SMWebView()
        wv.loadRequest(URLRequest(url: URL))
        return wv
    }

    public class func loadHTML(_ string: String, baseURL: URL) -> SMWebView {
        let wv = SMWebView()
        wv.loadHTMLString(string, baseURL: baseURL)
        return wv
    }

    @discardableResult
    public func loadURL(_ URL: URL) -> SMWebView {
        loadRequest(URLRequest(url: URL))
        return self
    }

    @discardableResult
    public func loadHTML(_ string: String, baseURL: URL) -> SMWebView {
        loadHTMLString(string, baseURL: baseURL)
        return self
    }

    //MARK: Closure methods
    @discardableResult
    public func didStartLoading(handler: @escaping SMWebViewClosure) -> SMWebView {
        didStartLoadingHandler       = handler
        
        return self
    }

    @discardableResult
    public func didFinishLoading(handler: @escaping SMWebViewClosure) -> SMWebView {
        didFinishLoadingHandler      = handler
        return self
    }

    @discardableResult
    public func didFailLoading(handler: @escaping SMWebViewFailClosure) -> SMWebView {
        didFailLoadingHandler        = handler
        return self
    }

    @discardableResult
    public func didCompleteLoading(handler: @escaping SMWebViewClosure) -> SMWebView {
        didCompleteLoadingHandler    = handler
        return self
    }

    @discardableResult
    public func shouldStartLoading(handler: @escaping SMWebViewShouldLoadClosure) -> SMWebView {
        shouldStartLoadingHandler    = handler
        return self
    }
    
    //MARK: UIWebView Delegate & Closure Handling
    public func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        didFailLoadingHandler?(self, error)
    }

    public func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        guard let handler = shouldStartLoadingHandler,
              shouldStartLoadingHandler != nil else {
            return true
        }

        return handler(self, request, navigationType)
    }

    public func webViewDidStartLoad(_ webView: UIWebView) {
        didStartLoadingHandler?(self)
    }

    public func webViewDidFinishLoad(_ webView: UIWebView) {
        didFinishLoadingHandler?(self)

        if !webView.isLoading {
            didCompleteLoadingHandler?(self)
        }
    }
}
