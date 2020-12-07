//
//  BrowserPresenter.swift
//  Downloader
//
//  Created by Alex Kharchenko on 01.12.2020.
//

import WebKit
import RxSwift

protocol BrowserPresenterType {
    func viewDidLoad()
    func downloadAction()
}

class BrowserPresenter: NSObject, BrowserPresenterType {
    
    weak var view: BrowserViewType?
    var interactor: BrowserInteractorType
    var router: BrowserRouterType
    
    var urlString = String()
    private var disposeBag = DisposeBag()
    
    init(interactor: BrowserInteractorType, router: BrowserRouterType) {
        self.interactor = interactor
        self.router = router
        super.init()
        observeVideoUrl()
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
        interactor.startDownloadVideo()
    }
    
    func observeVideoUrl() {
        interactor.videoUrl.subscribe { (videoUrlBody) in
            print("link in redy")
        }.disposed(by: disposeBag)
    }
    
    func checkPage(from request: URLRequest?) {
        interactor.getUrlVideo(from: request)
    }
}

extension BrowserPresenter: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: ((WKNavigationActionPolicy) -> Void)) {

        checkPage(from: navigationAction.request)
        
        decisionHandler(.allow)
    }
    
}
