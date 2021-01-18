//
//  DownloadedVideosConfigurator.swift
//  Downloader
//
//  Created by Alex Kharchenko on 13.12.2020.
//

import Foundation

protocol DownloadedVideosConfiguratorType {
    func configure(view: DownloadedVideosViewController)
}

class DownloadedVideosConfigurator: DownloadedVideosConfiguratorType {
    
    func configure(view: DownloadedVideosViewController) {
        let router = DownloadedVideosRouter(view: view)
        let presenter = DownloadedVideosPresenter(view: view, interactor: interactor, router: router)
        view.downloadedVideosTableView.delegate = presenter
        view.downloadedVideosTableView.dataSource = presenter
        view.presenter = presenter
    }
    
    var interactor: DownloadedVideosInteractorType {
        let dataBaseService = RealmDataBaseServise()
        return DownloadedVideosInteractor(dataBaseService: dataBaseService)
    }
    
    
}
