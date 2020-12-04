//
//  SearchVideoConfigurator.swift
//  Downloader
//
//  Created by Alex Kharchenko on 30.11.2020.
//

import UIKit

protocol SearchVideoConfiguratorType {
    func configure(viewController: SearchVideoViewController)
}

class SearchVideoConfigurator: SearchVideoConfiguratorType {
    
    func configure(viewController: SearchVideoViewController) {
        let router = SearchVideoRouter()
        let presenter = SearchVideoPresenter(interactor: interactor, router: router)
        presenter.view = viewController
        router.view = viewController
        viewController.topPageCollectioView.delegate = presenter
        viewController.topPageCollectioView.dataSource = presenter
        viewController.searchBar.delegate = presenter
        viewController.presenter = presenter
    }
    
    var interactor: SearchVideoInteractorType {
        let pagesService = PagesService(requestService: AlamofireBaseRequestService())
        let dataBase = RealmDataBaseServise()
        return SearchVideoInteractor(pagesService: pagesService, dataBaseServise: dataBase)
    }
}
