//
//  BrowserViewController.swift
//  Downloader
//
//  Created by Alex Kharchenko on 01.12.2020.
//

import UIKit
import WebKit

protocol BrowserViewType: class {
    var sheetView: SheetView? {get}
    func loadWebPage(request: URLRequest)
    func showDownloadedVideoView()
    func hideDownloadedVideoView()
    func changeDownloadButtonState(isActive: Bool)
    func loadingView(isActive: Bool)
}

class BrowserViewController: UIViewController, BrowserViewType {
    
    @IBOutlet weak var webKitView: WKWebView!
    @IBOutlet weak var loadingView: LoadView!
    @IBOutlet weak var downloadButton: UIButton!
    
    var sheetView: SheetView?
    
    var configurator: BrowserConfiguratorType?
    var presenter: BrowserPresenterType?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurator?.configure(viewController: self)
        presenter?.viewDidLoad()
        configUI()
        webKitView.addObserver(self, forKeyPath: "URL", options: [.new, .old], context: nil)
    }
    
    func loadWebPage(request: URLRequest) {
        webKitView.load(request)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        guard let newValue = change?[.newKey], let oldValue = change?[.oldKey] else {return}
        let nextUrl = "\(newValue)"
        let pastUrl = "\(oldValue)"
        
        if  nextUrl != pastUrl {
            // nextUrl
            presenter?.checkPage(from: nextUrl)
        } else {
            // pastUrl
        }
    }
    
    func showDownloadedVideoView() {
        sheetView?.open()
    }
    
    func hideDownloadedVideoView() {
        sheetView?.clouse()
    }
    
    func changeDownloadButtonState(isActive: Bool) {
        downloadButton.isEnabled = isActive
        downloadButton.backgroundColor = .gray
        let buttonTitle = isActive ? "Download" : "Not Found"
        let buttonColor = isActive ? R.color.activeDownloadColor() : R.color.notFoundVideoColor()
        downloadButton.setTitle(buttonTitle, for: .normal)
        downloadButton.backgroundColor = buttonColor
        downloadButton.layer.standartShadow(color: buttonColor)
    }
    
    func loadingView(isActive: Bool) {
        let buttonTitle = "Searching"
        let buttonColor = R.color.searchVideoColor()
        if isActive {
            loadingView.start()
            downloadButton.setTitle(buttonTitle, for: .normal)
            downloadButton.backgroundColor = buttonColor
            downloadButton.layer.standartShadow(color: buttonColor)
        } else {
            loadingView.stop()
        }
    }
    
    private func configUI() {
        title = "Browser"
        setupDownloadedVideoView()
        configLoadingView()
    }
    
    private func setupDownloadedVideoView() {
        let topPosition = view.frame.height - 270 - (self.tabBarController?.tabBar.frame.height ?? 49.0)
        sheetView?.configure(bottomPosition: view.frame.height + 50, topPosition: topPosition)
    }
    
    private func configLoadingView() {
        loadingView.backgroundColor = .clear
    }
    
    @IBAction private func downloadAction(_ sender: Any) {
        presenter?.downloadAction()
    }
}

extension BrowserViewController: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
         defer {
             decisionHandler(.allow)
         }
         guard
            let url = navigationAction.request.url,
            let host = url.host, host.hasPrefix(Constants.instagramUrl)
         else {
             return
         }
        presenter?.checkPage(from: url.absoluteString)
     }
}
