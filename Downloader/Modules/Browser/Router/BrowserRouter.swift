//
//  BrowserRouter.swift
//  Downloader
//
//  Created by Alex Kharchenko on 01.12.2020.
//

import Foundation

protocol BrowserRouterType {
    func showSharedView(_ sharedView: ActivityViewController)
}

class BrowserRouter: BrowserRouterType {
    
    private weak var view: BrowserViewController?
    
    init(view: BrowserViewController) {
        self.view = view
    }
    
    func showSharedView(_ sharedView: ActivityViewController) {
        guard let view = view?.view else { return }
        sharedView.popoverPresentationController?.sourceView = view
        sharedView.popoverPresentationController?.sourceRect = view.frame
        self.view?.present(sharedView, animated: true)
    }
}
