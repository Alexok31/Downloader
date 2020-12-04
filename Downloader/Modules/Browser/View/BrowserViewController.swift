//
//  BrowserViewController.swift
//  Downloader
//
//  Created by Alex Kharchenko on 01.12.2020.
//

import UIKit
import WebKit

protocol BrowserViewType: class {
    func loadWebPage(request: URLRequest)
}

class BrowserViewController: UIViewController, BrowserViewType {
    
    @IBOutlet weak var webKitView: WKWebView!
    @IBOutlet weak var downloadButton: UIButton!
    
    var configurator: BrowserConfiguratorType?
    var presenter: BrowserPresenterType?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurator?.configure(viewController: self)
        presenter?.viewDidLoad()
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
            print(nextUrl)
        } else {
            print(pastUrl)
        }
    }
    
    @IBAction func downloadAction(_ sender: Any) {
        presenter?.downloadAction()
    }
}
