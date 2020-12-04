//
//  BrowserPresenter.swift
//  Downloader
//
//  Created by Alex Kharchenko on 01.12.2020.
//

import WebKit

protocol BrowserPresenterType {
    func viewDidLoad()
    func downloadAction()
}

class BrowserPresenter: NSObject, BrowserPresenterType {
    
    weak var view: BrowserViewType?
    
    var urlString = ""
    
    func viewDidLoad() {
        
        loadWebPage()
    }
    
    func loadWebPage() {
        if let url = URL(string: urlString) {
            let request = URLRequest(url: url)
            view?.loadWebPage(request: request)
        }
    }
    
    func downloadAction() {
        
    }
}

extension BrowserPresenter: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: ((WKNavigationActionPolicy) -> Void)) {

        if let url = navigationAction.request.url {
            
        }
        
        decisionHandler(.allow)
    }
    
}
