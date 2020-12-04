//
//  BrowserConfigurator.swift
//  Downloader
//
//  Created by Alex Kharchenko on 01.12.2020.
//

import Foundation

protocol BrowserConfiguratorType {
    func configure(viewController: BrowserViewController)
}

class BrowserConfigurator: BrowserConfiguratorType {
    
    var urlString: String
    
    init(urlString: String) {
        self.urlString = urlString
    }
    
    func configure(viewController: BrowserViewController) {
        let presenter = BrowserPresenter()
        presenter.view = viewController
        presenter.urlString = urlString
        viewController.webKitView.navigationDelegate = presenter
        viewController.presenter = presenter
    }
    
}
