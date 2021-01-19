//
//  DownloadedVideosRouter.swift
//  Downloader
//
//  Created by Alex Kharchenko on 18.01.2021.
//

import Foundation

protocol DownloadedVideosRouterType {
    func showPayer(player: PlayerViewController)
    func showSharedView(_ sharedView: ActivityViewController)
}

class DownloadedVideosRouter: DownloadedVideosRouterType {
    
    weak var view: DownloadedVideosViewController?
    
    init(view: DownloadedVideosViewController) {
        self.view = view
    }
    
    func showPayer(player: PlayerViewController) {
        view?.present(player, animated: true)
    }
    
    func showSharedView(_ sharedView: ActivityViewController) {
        guard let view = view?.view else { return }
        sharedView.popoverPresentationController?.sourceView = view
        sharedView.popoverPresentationController?.sourceRect = view.frame
        self.view?.present(sharedView, animated: true)
    }
}
