//
//  BrowserViewController.swift
//  Downloader
//
//  Created by Alex Kharchenko on 01.12.2020.
//

import UIKit
import WebKit

protocol BrowserViewType: class {
    var selectionDownloadedVideoView: SelectionDownloadedVideoView? {get}
    func loadWebPage(request: URLRequest)
    func showDownloadedVideoView()
    func hideDownloadedVideoView()
    func changeDownloadButtonState(isActive: Bool)
}

class BrowserViewController: UIViewController, BrowserViewType {
    
    @IBOutlet weak var webKitView: WKWebView!
    @IBOutlet weak var downloadButton: UIButton!
    
    var selectionDownloadedVideoView: SelectionDownloadedVideoView?
    var blackoutView = UIView()
    var downloadedVideoBottomConstraint: NSLayoutConstraint?
    
    var configurator: BrowserConfiguratorType?
    var presenter: BrowserPresenterType?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurator?.configure(viewController: self)
        presenter?.viewDidLoad()
        configUI()
        webKitView.addObserver(self, forKeyPath: "URL", options: [.new, .old], context: nil)
        tapToDownloadButton()
    }
    
    func configUI() {
        title = "Browser"
        setupDownloadedVideoView()
    }
    
    func loadWebPage(request: URLRequest) {
        webKitView.load(request)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        guard let newValue = change?[.newKey], let oldValue = change?[.oldKey] else {return}
        let nextUrl = "\(newValue)"
        let pastUrl = "\(oldValue)"
        
        if  nextUrl != pastUrl {
            print(nextUrl)
        } else {
            print(pastUrl)
        }
    }
    
    func tapToDownloadButton() {
        selectionDownloadedVideoView?.tapToDownloadButton = { [weak self] in
            self?.presenter?.tapToDownloadButton()
        }
    }
    
    func showDownloadedVideoView() {
        blackoutView.isHidden = false
        UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, animations: { [weak self] in
            guard let self = self else { return }
            self.blackoutView.alpha = 0.5
            self.downloadedVideoBottomConstraint?.constant = 20
            self.tabBarController?.view.layoutIfNeeded()
        })
    }
    
    func hideDownloadedVideoView() {
        guard let videoView = selectionDownloadedVideoView else {return}
        self.view.layoutIfNeeded()
        UIView.animate(withDuration: 0.5) { [weak self] in
            guard let self = self else { return }
            self.blackoutView.alpha = 0.0
            self.downloadedVideoBottomConstraint?.constant = videoView.frame.height
            self.tabBarController?.view.layoutIfNeeded()
        } completion: { [weak self] (_) in
            self?.blackoutView.isHidden = true
        }
    }
    
    func changeDownloadButtonState(isActive: Bool) {
        downloadButton.isEnabled = isActive
        downloadButton.backgroundColor = isActive == true ? .green : .darkGray
    }
    
    @IBAction func downloadAction(_ sender: Any) {
        presenter?.downloadAction()
    }
    
    private func setupDownloadedVideoView() {
        selectionDownloadedVideoView = R.nib.selectionDownloadedVideoView(owner: self)
        guard let videoView = selectionDownloadedVideoView else {return}
        blackoutView.backgroundColor = .black
        blackoutView.frame = view.frame
        blackoutView.alpha = 0.0
        blackoutView.isHidden = true
        if let tabbarView = tabBarController?.view {
            tabbarView.addSubview(blackoutView)
            tabbarView.addSubview(videoView)
            videoView.translatesAutoresizingMaskIntoConstraints = false
            videoView.widthAnchor.constraint(equalTo: tabbarView.widthAnchor).isActive = true
            downloadedVideoBottomConstraint = videoView.bottomAnchor.constraint(equalTo: tabbarView.bottomAnchor)
            downloadedVideoBottomConstraint?.constant = videoView.frame.height
            downloadedVideoBottomConstraint?.isActive = true
            videoView.leftAnchor.constraint(equalTo: tabbarView.leftAnchor).isActive = true
            videoView.rightAnchor.constraint(equalTo: tabbarView.rightAnchor).isActive = true
        }
    }
}
