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
        if let resultTopPages = dataBaseServise.fetch(object: TopPageEntity.self) {
            return Array(resultTopPages)
        }
        return nil
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
    
    func observeTopPages(complition: @escaping()->()) {
        guard let resultTopPages = dataBaseServise.fetch(object: TopPageEntity.self) else { return }
        dataBaseServise.addObserve(object: resultTopPages, initial: { (topPages) in
            complition()
        }, update: { (_, _) in
            complition()
        })
    }
    
    func removeObserve() {
        dataBaseServise.removeRealmNotificationToken()
    }
    
    private func saveTopPages(pages: TopPagesEntity?) {
        guard let topPages = pages else { return }
        self.dataBaseServise.save(object: topPages, isUpdate: true)
    }
    
}
