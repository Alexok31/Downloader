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
    var interactor: BrowserInteractorType
    var router: BrowserRouterType
    
    var urlString = String()
    
    init(interactor: BrowserInteractorType, router: BrowserRouterType) {
        self.interactor = interactor
        self.router = router
    }
    
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
        interactor.startDownloadVideo(by: "https://scontent-fco1-1.cdninstagram.com/v/t50.2886-16/10000000_1785963831566700_6444225060331382646_n.mp4?_nc_ht=scontent-fco1-1.cdninstagram.com&_nc_cat=100&_nc_ohc=xXo-kfjDMkgAX9akqwT&oe=5FCCFA9B&oh=9a0e31326301b42e54519a64ebe6fe76")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.interactor.pauseDownload()
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 10) { [self] in
            interactor.resumeDownload()
        }
    }
}

extension BrowserPresenter: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: ((WKNavigationActionPolicy) -> Void)) {

        if let url = navigationAction.request.url {
            
        }
        
        decisionHandler(.allow)
    }
    
}
