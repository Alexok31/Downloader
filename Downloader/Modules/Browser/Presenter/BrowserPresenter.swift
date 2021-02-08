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
    func checkPage(from urlLink: String)
    func openInSafari(url: URL?)
    func sharedWebPage(url: URL?)
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
        observeUrlVideoResult()
        observeVideoUrl()
        tapToDownloadButton()
    }
    
    func viewDidLoad() {
        loadWebPage()
    }
    
    func tapToDownloadButton() {
        interactor.startDownloadVideo(name: nil)
        view?.hideDownloadedVideoView()
        setBadge(value: "1")
    }
    
    func downloadAction() {
        view?.showDownloadedVideoView()
    }
    
    func checkPage(from urlLink: String) {
        interactor.stopAllDataTasks()
        view?.changeDownloadButtonState(isActive: false)
        view?.loadingView(isActive: true)
        interactor.getUrlVideo(from: urlLink)
    }
    
    func openInSafari(url: URL?) {
        guard let url = url else { return }
        UIApplication.shared.open(url)
    }
    
    private func loadWebPage() {
        guard let request = interactor.request else { return }
        view?.loadWebPage(request: request)
    }
    
    func sharedWebPage(url: URL?) {
        guard let url = url else { return }
        let activityItems: [Any] = [url]
        let activityController = ActivityViewController(activityItems: activityItems, applicationActivities: nil)
        router.showSharedView(activityController)
    }
    
    private func setBadge(value: String) {
        let viewController = view as? UIViewController
        viewController?.tabBarController?.viewControllers?[1].tabBarItem.badgeValue = value
    }
    
    private func setSelectionDownloadedVideoData() {
        guard let selectionDownloadedVideoView = view?.sheetView?.content as? SelectionDownloadedVideoView else { return }
        selectionDownloadedVideoView.model = interactor.urlVideoBody
        selectionDownloadedVideoView.tapToDownloadButton = { [weak self] in
            self?.tapToDownloadButton()
        }
    }
    
    private func  observeUrlVideoResult() {
        interactor.statusServer.subscribe { [weak self] (errorResponse) in
            let isActive = errorResponse.element == .empty
            self?.view?.changeDownloadButtonState(isActive: isActive)
            self?.view?.loadingView(isActive: false)
        }.disposed(by: disposeBag)
    }
    
    private func observeVideoUrl() {
        interactor.videoUrl.subscribe { [weak self] (videoUrlBody) in
            self?.setSelectionDownloadedVideoData()
        }.disposed(by: disposeBag)
    }
}
