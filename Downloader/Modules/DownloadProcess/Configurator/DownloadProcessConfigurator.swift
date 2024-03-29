//
//  DownloadProcessConfigurator.swift
//  Downloader
//
//  Created by Alex Kharchenko on 04.12.2020.
//

import Foundation

protocol DownloadProcessConfiguratorType {
    func configure(view: DownloadProcessViewController)
}

class DownloadProcessConfigurator: DownloadProcessConfiguratorType {
    
    func configure(view: DownloadProcessViewController) {
        let presenter = DownloadProcessPresenter(interactor: interactor, view: view)
        view.downloadingVideosTableView.delegate = presenter
        view.downloadingVideosTableView.dataSource = presenter
        view.presenter = presenter
    }
    
    var interactor: DownloadProcessInteractorType {
        return DownloadProcessInteractor(dataBaseService: RealmDataBaseServise())
    }
}
