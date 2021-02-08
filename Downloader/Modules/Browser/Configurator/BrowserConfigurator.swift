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
        let router = BrowserRouter(view: viewController)
        let presenter = BrowserPresenter(interactor: interactor, router: router)
        presenter.view = viewController
        viewController.webKitView.navigationDelegate = viewController
        viewController.presenter = presenter
        
        configureSheetView(viewController: viewController)
    }
    
    private var interactor: BrowserInteractor {
        let linksService = LinksService()
        let interactor = BrowserInteractor(netowkService: linksService)
        interactor.urlString = urlString
        return interactor
    }
    
    private func configureSheetView(viewController: BrowserViewController) {
        let sheetView = R.nib.sheetView(owner: viewController)
        viewController.view.addSubview(sheetView!)
        if let selectionDownloadedVideoView = R.nib.selectionDownloadedVideoView(owner: sheetView) {
            sheetView?.setupConstraintFromSuperview(content: selectionDownloadedVideoView, height: 270, isDarkBackground: true)
        }
        viewController.sheetView = sheetView
    }
    
}
