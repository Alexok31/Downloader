//
//  SearchVideoInteractor.swift
//  Downloader
//
//  Created by Alex Kharchenko on 30.11.2020.
//

import RxSwift

class SearchVideoInteractor: SearchVideoInteractorType {
    
    private var pagesService: PagesServiceType
    private var dataBaseServise: DataBaseServise
    
    init(pagesService: PagesServiceType, dataBaseServise: DataBaseServise) {
        self.pagesService = pagesService
        self.dataBaseServise = dataBaseServise
    }
    
    var topPages: TopPagesEntity? {
        return dataBaseServise.fetch(object: TopPageEntity.self)
    }
    
    var topPagesCount: Int {
        return topPages?.count ?? 0
    }
    
    func topPageInfo(for indexPath: IndexPath) -> TopPageInfo? {
        guard let topPage = topPages?[indexPath.row] else {return nil}
        return TopPageInfo(imageUrl: topPage.icon ?? "", name: topPage.name ?? "")
    }
    
    func tapToTopPageLink(for indexPath: IndexPath) -> String? {
        guard let topPage = topPages?[indexPath.row] else {return nil}
        return topPage.link
    }
    
    func updateTopPages() {
        pagesService.getTopPages { (status, topPages) in
            self.saveTopPages(pages: topPages)
        }
    }
    
    func observeTopPages(complition: @escaping(TopPagesEntity)->()) {
        dataBaseServise.addObserve(object: TopPageEntity.self) { (topPages) in
            if let topPages = topPages {
                complition(topPages)
            }
        }
    }
    
    func removeObserve() {
        dataBaseServise.removeRealmNotificationToken()
    }
    
    private func saveTopPages(pages: TopPagesEntity?) {
        guard let topPages = pages else { return }
        self.dataBaseServise.save(object: topPages, isUpdate: true)
    }
    
}
