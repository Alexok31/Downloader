//
//  SearchVideoConfigurator.swift
//  Downloader
//
//  Created by Alex Kharchenko on 30.11.2020.
//

import UIKit

class SearchVideoConfigurator: SearchVideoConfiguratorType {
    
    func configure(viewController: SearchVideoViewController) {
        let router = SearchVideoRouter(view: viewController)
        let presenter = SearchVideoPresenter(view: viewController, interactor: interactor, router: router)
        presenter.view = viewController
        viewController.topPageCollectioView.delegate = presenter
        viewController.topPageCollectioView.dataSource = presenter
        viewController.searchBar.delegate = presenter
        viewController.presenter = presenter
    }
    
    private var interactor: SearchVideoInteractorType {
        let linksService = LinksService()
        let dataBase = RealmDataBaseServise()
        return SearchVideoInteractor(networkService: linksService, dataBaseServise: dataBase)
    }
}
