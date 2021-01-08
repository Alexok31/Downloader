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
        let router = BrowserRouter()
        let presenter = BrowserPresenter(interactor: interactor, router: router)
        presenter.view = viewController
        let sheetView = R.nib.sheetView(owner: viewController)
        viewController.view.addSubview(sheetView!)
        if let selectionDownloadedVideoView = R.nib.selectionDownloadedVideoView(owner: sheetView) {
            sheetView?.setupConstraintFromSuperview(content: selectionDownloadedVideoView, height: 270, isDarkBackground: true)
        }
        
        viewController.sheetView = sheetView
        
        viewController.presenter = presenter
    }
    
    var interactor: BrowserInteractor {
        let requestService = AlamofireBaseRequestService()
        let browseService = BrowseService(requestService: requestService)
        let interactor = BrowserInteractor(browseService: browseService)
        interactor.urlString = urlString
        return interactor
    }
    
}
