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
    func tapToDownloadButton()
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
        tapToDownloadButton()
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
    
    func tapToDownloadButton() {
        interactor.startDownloadVideo(name: nil)
        view?.hideDownloadedVideoView()
    }
    
    func downloadAction() {
        view?.showDownloadedVideoView()
    }
    
    func observeVideoUrl() {
        interactor.videoUrl.subscribe { [weak self] (videoUrlBody) in
            self?.view?.changeDownloadButtonState(isActive: true)
            self?.setSelectionDownloadedVideoData()
        }.disposed(by: disposeBag)
    }
    
    func checkPage(from request: URLRequest?) {
        interactor.getUrlVideo(from: request)
    }
    
    func setSelectionDownloadedVideoData() {
        view?.selectionDownloadedVideoView?.model = interactor.urlVideoBody
    }
}

extension BrowserPresenter: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: ((WKNavigationActionPolicy) -> Void)) {

        checkPage(from: navigationAction.request)
        
        decisionHandler(.allow)
    }
    
}
