//
//  SearchVideoInteractor.swift
//  Downloader
//
//  Created by Alex Kharchenko on 30.11.2020.
//

import RxSwift

class SearchVideoInteractor: SearchVideoInteractorType {
    
    private var networkService: LinksService
    private var dataBaseServise: DataBaseServise
    
    init(networkService: LinksService, dataBaseServise: DataBaseServise) {
        self.networkService = networkService
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
        networkService.topPages { (result) in
            switch result {
            case .succsess(let topPages):
                self.saveTopPages(pages: topPages)
            case .failure( _): break
            }
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
        dataBaseServise.save(object: topPages, isUpdate: true)
        removeDiferentTopPages(pages: topPages)
    }
    
    private func removeDiferentTopPages(pages: TopPagesEntity) {
        let ids = pages.map { $0.name ?? "" }
        self.dataBaseServise.delete(objectType: TopPageEntity.self, notIdIn: ids)
    }
    
}
