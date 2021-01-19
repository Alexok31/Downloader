//
//  SearchVideoProtocols.swift
//  Downloader
//
//  Created by Alex Kharchenko on 25.12.2020.
//

import Foundation

protocol SearchVideoConfiguratorType {
    func configure(viewController: SearchVideoViewController)
}

protocol SearchVideoViewType: class {
    func reloadTopPages()
    func updateTopPagesHeigth()
}

protocol SearchVideoInteractorType {
    var topPages: TopPagesEntity? { get }
    var topPagesCount: Int { get }
    func updateTopPages()
    func topPageInfo(for indexPath: IndexPath) -> TopPageInfo?
    func tapToTopPageLink(for indexPath: IndexPath) -> String?
    func observeTopPages(complition: @escaping()->())
    func removeObserve()
}

protocol SearchVideoPresenterType: class {
    func viewDidLoad()
    func howToDownloadAction()
}

protocol SearchVideoRouterType {
    func openBrowser(urlString: String)
}
