//
//  DownloadedVideosRouter.swift
//  Downloader
//
//  Created by Alex Kharchenko on 18.01.2021.
//

import Foundation
import AVKit

protocol DownloadedVideosRouterType {
    func showPayer(player: PlayerViewController)
}

class DownloadedVideosRouter: DownloadedVideosRouterType {
    
    weak var view: DownloadedVideosViewController?
    
    init(view: DownloadedVideosViewController) {
        self.view = view
    }
    
    func showPayer(player: PlayerViewController) {
        view?.present(player, animated: true)
    }
}
