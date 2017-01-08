//
//  SMWebView
//
//  Created by Shai Mishali on 8/19/15.
//  Copyright (c) 2015 Shai Mishali. All rights reserved.
//

import Foundation
import UIKit

public class SMWebView : UIWebView, UIWebViewDelegate{
    //MARK: Typealiasing for Closure Types
    public typealias SMWebViewClosure                                       = (_ webView:SMWebView) -> ()
    public typealias SMWebViewFailClosure                                   = (_ webView:SMWebView, _ error: NSError?) -> ()
    public typealias SMWebViewShouldLoadClosure                             = (_ webView:SMWebView, _ request: NSURLRequest, _ navigationType: UIWebViewNavigationType) -> (Bool)
    
    //MARK: Internal storage for Closures
    internal var __didStartLoadingHandler:SMWebViewClosure?                 = nil
    internal var __didFinishLoadingHandler:SMWebViewClosure?                = nil
    internal var __didCompleteLoadingHandler:SMWebViewClosure?              = nil
    internal var __didFailLoadingHandler:SMWebViewFailClosure?              = nil
    internal var __shouldStartLoadingHandler:SMWebViewShouldLoadClosure?    = nil
    
    //MARK: Initializers
    override public init(frame: CGRect) {
        super.init(frame: frame)
        self.delegate  = self
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.delegate  = self
    }
    
    // URL/String loaders with Chaining-support
    public class func loadURL(URL: NSURL) -> SMWebView{
        let wv = SMWebView()
        wv.loadRequest(NSURLRequest(url: URL as URL) as URLRequest)
        return wv
    }
    
    public class func loadHTML(string: String!, baseURL: NSURL!) -> SMWebView{
        let wv = SMWebView()
        wv.loadHTMLString(string, baseURL: baseURL as URL?)
        return wv
    }
    
    public func loadURL(URL: NSURL) -> SMWebView{
        self.loadRequest(NSURLRequest(url: URL as URL) as URLRequest)
        return self
    }
    
    public func loadHTML(string: String!, baseURL: NSURL!) -> SMWebView{
        self.loadHTMLString(string, baseURL: baseURL as URL?)
        return self
    }
    
    //MARK: Closure methods
//    public func didStartLoading(handler: @escaping @escaping SMWebViewClosure) -> SMWebView{
//        self.__didStartLoadingHandler       = handler
//        
//        return self
//    }
    
    public func didFinishLoading(handler: @escaping SMWebViewClosure) -> SMWebView{
        self.__didFinishLoadingHandler      = handler
        return self
    }
    
    public func didFailLoading(handler: @escaping SMWebViewFailClosure) -> SMWebView{
        self.__didFailLoadingHandler        = handler
        return self
    }
    
    public func didCompleteLoading(handler: @escaping SMWebViewClosure) -> SMWebView{
        self.__didCompleteLoadingHandler    = handler
        return self
    }
    
    public func shouldStartLoading(handler: @escaping SMWebViewShouldLoadClosure) -> SMWebView{
        self.__shouldStartLoadingHandler    = handler
        return self
    }
    
    //MARK: UIWebView Delegate & Closure Handling
    public func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        self.__didFailLoadingHandler?(self, error as NSError?)
    }
    
    public func webView(_ webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        if self.__shouldStartLoadingHandler != nil {
            return self.__shouldStartLoadingHandler!(self, request, navigationType)
        }
        
        return true
    }
    
    
    
    
    public func webViewDidStartLoad(_ webView: UIWebView) {
        self.__didStartLoadingHandler?(self)
    }
    
    public func webViewDidFinishLoad(_ webView: UIWebView) {
        self.__didFinishLoadingHandler?(self)
        
        if !webView.isLoading {
            self.__didCompleteLoadingHandler?(self)
        }
    }
}
